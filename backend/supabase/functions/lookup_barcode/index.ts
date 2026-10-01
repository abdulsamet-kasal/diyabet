// Follow this to setup Deno & Supabase Edge Functions: https://supabase.com/docs/guides/functions
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const { barcode } = await req.json();
    if (!barcode || typeof barcode !== "string") {
      return new Response(JSON.stringify({ error: "Barkod zorunludur" }), {
        status: 400,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const supabase = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? ""
    );

    // 1. Check local cache in foods table
    const { data: existingFood } = await supabase
      .from("foods")
      .select("*, food_portions(*)")
      .eq("barcode", barcode)
      .maybeSingle();

    if (existingFood) {
      return new Response(JSON.stringify({ source: "cache", food: existingFood }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // 2. Fetch from Open Food Facts API (Turkish / Global proxy)
    const offUrl = `https://world.openfoodfacts.org/api/v2/product/${encodeURIComponent(barcode)}.json`;
    const offRes = await fetch(offUrl, {
      headers: { "User-Agent": "GlikoRehber-App/1.0 (health-safety-app)" },
    });

    if (!offRes.ok) {
      return new Response(JSON.stringify({ error: "Ürün Open Food Facts'te bulunamadı" }), {
        status: 404,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const offData = await offRes.json();
    if (offData.status !== 1 || !offData.product) {
      return new Response(JSON.stringify({ error: "Ürün bulunamadı", not_found: true }), {
        status: 404,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const prod = offData.product;
    const nutriments = prod.nutriments || {};

    const carbs = Number(nutriments.carbohydrates_100g ?? 0);
    const sugars = nutriments.sugars_100g != null ? Number(nutriments.sugars_100g) : null;
    const fiber = nutriments.fiber_100g != null ? Number(nutriments.fiber_100g) : null;
    const protein = Number(nutriments.proteins_100g ?? 0);
    const fat = Number(nutriments.fat_100g ?? 0);
    const energyKcal = Number(nutriments["energy-kcal_100g"] ?? 0);

    // 3. Quality & Consistency Checks (Section 5.3)
    let isQuarantined = false;
    let quarantineReason = "";

    if (carbs < 0 || carbs > 100 || protein < 0 || protein > 100 || fat < 0 || fat > 100) {
      isQuarantined = true;
      quarantineReason = "Makro besinler 0-100g sınırları dışında.";
    } else if (sugars != null && sugars > carbs) {
      isQuarantined = true;
      quarantineReason = "Şeker miktarı toplam karbonhidrattan büyük olamaz.";
    } else if (fiber != null && fiber > carbs) {
      isQuarantined = true;
      quarantineReason = "Lif miktarı toplam karbonhidrattan büyük olamaz.";
    } else if (carbs + protein + fat > 105.0) {
      isQuarantined = true;
      quarantineReason = "Makro besin toplamı 105g toleransını aşıyor.";
    }

    if (isQuarantined) {
      await supabase.from("import_quarantine").insert({
        raw_data: prod,
        rejection_reason: quarantineReason,
      });

      return new Response(
        JSON.stringify({
          error: "Ürün besin değerleri tutarsızlık nedeniyle karantinaya alındı.",
          reason: quarantineReason,
        }),
        { status: 422, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    // 4. Cache valid product with community_unverified status
    const foodRecord = {
      name_tr: prod.product_name_tr || prod.product_name || "Bilinmeyen Ürün",
      name_en: prod.product_name_en || prod.product_name || null,
      normalized_name: (prod.product_name_tr || prod.product_name || "")
        .toLowerCase()
        .replace(/ğ/g, "g")
        .replace(/ü/g, "u")
        .replace(/ş/g, "s")
        .replace(/ı/g, "i")
        .replace(/ö/g, "o")
        .replace(/ç/g, "c"),
      brand: prod.brands || null,
      category: prod.categories || null,
      barcode: barcode,
      preparation: "as_sold",
      carbs_g_per_100g: carbs,
      sugars_g_per_100g: sugars,
      fiber_g_per_100g: fiber,
      protein_g_per_100g: protein,
      fat_g_per_100g: fat,
      kcal_per_100g: energyKcal,
      verification: "community_unverified",
      is_sample: false,
    };

    const { data: inserted, error: insertErr } = await supabase
      .from("foods")
      .insert(foodRecord)
      .select()
      .single();

    if (insertErr) {
      return new Response(JSON.stringify({ error: insertErr.message }), {
        status: 500,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    return new Response(JSON.stringify({ source: "openfoodfacts", food: inserted }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  } catch (err: any) {
    return new Response(JSON.stringify({ error: err.message }), {
      status: 500,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }
});
