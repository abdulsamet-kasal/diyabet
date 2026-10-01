# PROJE: GlikoRehber (çalışma adı) — Diyabet Karbonhidrat ve İnsülin Doz Asistanı

> Bu dosyayı proje köküne `PROJECT_SPEC.md` olarak koy ve ajana şunu söyle:
> "PROJECT_SPEC.md dosyasını baştan sona oku. Önce bir uygulama planı çıkar, sonra Bölüm 14'teki fazları sırayla uygula."

---

## 0. AJAN ÇALIŞMA TALİMATI

Sen kıdemli bir Flutter mimarı, backend mühendisi, UI/UX tasarımcısı ve sağlık yazılımı güvenlik mühendisisin. Bu proje bir **sağlık uygulamasıdır**; yanlış bir sayı, kullanıcıya zarar verebilir. Bu yüzden:

1. Önce `PLAN.md` üret (mimari, faz listesi, riskler). Sonra fazları sırayla uygula.
2. Her fazın sonunda: `flutter analyze` hatasız, tüm testler yeşil, kısa bir commit mesajı, `CHANGELOG.md` güncellemesi.
3. Bana soru sorma. Belirsiz bir yerde en **güvenli ve muhafazakâr** varsayımı seç ve `ASSUMPTIONS.md` dosyasına yaz.
4. **Besin değerlerini, klinik eşikleri veya tıbbi bilgileri ASLA hafızandan/tahminle yazma.** Veri yalnızca resmi kaynaktan içe aktarma (import) script'iyle gelir (Bölüm 5). Kaynağa erişemiyorsan alanı boş bırak, `// TODO(KLİNİK-DOĞRULAMA)` ekle ve `OPEN_QUESTIONS.md`'ye yaz.
5. Test amaçlı örnek veri kullanırsan her kaydı `is_sample = true` ile işaretle; üretim derlemesinde (release build) örnek veri **görünmemeli** (build flag ile engelle).
6. Kod yorumları İngilizce, kullanıcıya görünen tüm metinler Türkçe (ARB dosyaları ile, ikinci dil İngilizce).

---

## 1. ÜRÜN ÖZETİ

Diyabetli bireylerin yiyeceklerin karbonhidrat miktarını hızlıca görmesini ve (insülin kullanıyorsa) kendi doktorunun belirlediği oran/faktörlerle **öneri niteliğinde** insülin ünitesi hesaplamasını sağlayan, çevrimdışı çalışabilen mobil uygulama.

**Örnek kullanım:** Kullanıcı bir paketli ürünü (ör. bir çikolata) barkodla tarar veya arar → 100 g ve porsiyon başına karbonhidrat, şeker, lif, kalori görür → gram/porsiyon girer → toplam karbonhidrat hesaplanır → insülin kullanıyorsa kendi ayarlarıyla önerilen ünite adım adım gösterilir.

**Önemli kavram düzeltmesi:** İnsülin dozu **gram veya mL değil, ünite (U / IU)** cinsindendir. U-100 insülinde 1 mL = 100 ünite (1 ünite = 0,01 mL). Uygulama ana çıktıyı **ünite** olarak verir; yalnızca U-100 için isteğe bağlı "şırınga mL karşılığı" gösterimi sunar. Diğer konsantrasyonlarda (U-200, U-300, U-500) mL gösterimi yapılmaz, uyarı çıkar.

**Hedef platform:** Android + iOS (Flutter). **Hedef kullanıcı (v1):** 18 yaş ve üzeri. 18 yaş altı için v1'de doz hesaplayıcı **kapalıdır** (yalnızca bilgi modu); veli modu v2 olarak `ROADMAP.md`'ye yazılır.

---

## 2. DEĞİŞMEZ GÜVENLİK KURALLARI (Safety Invariants)

Bunlar pazarlık konusu değildir; ihlal eden kod birleştirilmez.

1. **Varsayılan klinik değer yok.** İnsülin/karbonhidrat oranı (ICR), düzeltme faktörü (ISF), hedef glikoz, insülin etki süresi, maksimum tek doz kullanıcıdan alınır (doktor/diyetisyen talimatıyla). Hiçbiri önceden doldurulmaz. Ayarlar eksikse doz hesaplanmaz; kullanıcı ayarlara yönlendirilir.
2. **Doz motoru saf (pure) Dart olmalı:** UI, ağ, yapay zekâ, rastgelelik yok. Aynı girdi → aynı çıktı. Ayrı bir `packages/dose_engine` paketi olarak yazılır, %100 satır kapsamlı test edilir.
3. **Hipoglisemi bloğu:** Güncel glikoz < 70 mg/dL (3,9 mmol/L) ise doz önerisi **verilmez**; "15-15 kuralı" ve acil durum kartı gösterilir. < 54 mg/dL ise ciddi hipoglisemi uyarısı (acil yardım/112 yönlendirmesi).
4. **Yüksek glikoz uyarısı:** > 250 mg/dL'de keton kontrolü uyarısı, > 300 mg/dL'de güçlü uyarı + doktora danış. Eşikler `clinical_constants.dart` içinde, kaynak yorumu ve "klinik doğrulama gerekir" notuyla tutulur.
5. **Maksimum tek doz limiti:** Kullanıcı tanımlı üst sınırı aşan öneri gösterilmez; "Girişlerinizi kontrol edin ve doktorunuza danışın" mesajı çıkar.
6. **Doğrulanmamış besin verisi:** Veri doğrulama düzeyi `official_verified` değilse sonuç ekranında belirgin uyarı ve "Paket etiketindeki değeri kontrol ettim" onay kutusu zorunlu olur.
7. **Şeffaflık:** Her doz sonucu formül dökümüyle gösterilir (karbonhidrat g ÷ ICR = X; (glikoz − hedef) ÷ ISF = Y; aktif insülin düşümü = Z; yuvarlama). Kara kutu sonuç yok.
8. **Doz = öneri.** Her doz ekranında sabit ibare: "Bu bir tıbbi tavsiye değildir. Uygulamadan önce doktorunuzun talimatlarıyla karşılaştırın." Onboarding'de ayrıca açık rıza + sorumluluk reddi onayı alınır ve loglanır.
9. **Yapay zekâ üretimli besin/doz verisi yasak.** LLM çıktısı hiçbir sayısal sağlık verisinin kaynağı olamaz.
10. **Her besin kaydının kaynağı, tarihi ve doğrulama durumu** UI'da görülebilir olmalı.
11. **Yuvarlama muhafazakârdır:** Doz adımına (0,5 / 1 / 0,1 ünite) en yakın değere yuvarla; tam ortadaysa **aşağı** yuvarla.
12. **Negatif düzeltme** (glikoz hedefin altındayken doz azaltma) varsayılan **kapalı**; kullanıcı ayarlardan açabilir, toplam doz hiçbir zaman 0'ın altına inmez.

---

## 3. KULLANICI PROFİLLERİ VE AKIŞLAR

Onboarding'de **diyabet tipi seçimi zorunludur** ve özellik seti buna göre şekillenir:

| Profil | Doz hesaplayıcı | Diğer özellikler |
|---|---|---|
| **Tip 1** | Tam özellik (öğün + düzeltme + aktif insülin) | Glikoz günlüğü, keton uyarıları, hasta günü rehberi |
| **Tip 2 — hızlı etkili (öğün) insülin kullanıyor** | Tam özellik | Aynı |
| **Tip 2 — sadece bazal insülin veya insülin kullanmıyor** | **Kapalı** (öğün dozu hesaplanmaz) | Öğün karbonhidrat bütçesi (kullanıcı/diyetisyen belirler), glisemik indeks/yük, tabak yöntemi, glikoz günlüğü |
| **Diğer (LADA, gestasyonel, MODY vb.)** | Kapalı | "Doktorunuzla birlikte kullanın" bilgi modu, besin veritabanı |

- Tip 2 insülinsiz kullanıcıda bile hipoglisemi riski taşıyan ilaç seçeneği (sülfonilüre vb.) işaretlenebilir; işaretlenirse hipoglisemi uyarıları aktif kalır.
- Profil sonradan değiştirilebilir; değişiklik geçmişi tutulur.

---

## 4. DOZ HESAPLAMA MOTORU (`packages/dose_engine`)

### 4.1 Girdiler
```dart
class DoseInput {
  final double totalCarbsG;          // toplam öğün karbonhidratı (g), >= 0
  final double? currentGlucose;      // opsiyonel
  final GlucoseUnit glucoseUnit;     // mgdl | mmoll
  final TherapySettings settings;    // ICR (zaman dilimli), ISF, hedef, DIA, adım, max doz, ...
  final List<DoseLogEntry> recentDoses; // aktif insülin (IOB) için
  final DateTime now;
  final DataConfidence minFoodConfidence; // öğündeki en düşük veri güveni
}
```

### 4.2 Algoritma (bu sırayla)
1. **Doğrulama:** Ayarlar eksik/geçersizse `DoseResult.missingSettings`. Negatif/NaN/sonsuz girdilerde `DoseResult.invalidInput`.
2. **Birim normalizasyonu:** mmol/L → mg/dL için ×18,0182 (iç hesap mg/dL).
3. **Hipoglisemi bloğu** (Bölüm 2/3 numaralı kural).
4. **Öğün dozu** = `totalCarbsG / ICR` (ICR: 1 ünite kaç g karbonhidrata yeter; öğün saatine göre zaman dilimli olabilir).
5. **Düzeltme dozu** = `max(0, (glikoz − hedef) / ISF)`; negatif düzeltme ayarı açıksa negatif olabilir.
6. **Aktif insülin (IOB):** Son dozlar için `kalan = doz × (1 − geçenSüre / DIA)` (doğrusal, süre ≥ DIA ise 0). **IOB yalnızca düzeltme bileşeninden düşülür** (0'ın altına inmez), öğün dozundan düşülmez.
7. **Toplam** = öğün + düzeltme(IOB sonrası); toplam ≥ 0.
8. **Yuvarlama:** doz adımına, ortada aşağı.
9. **Üst sınır kontrolü** (maksimum tek doz).
10. **Çıktı:** `DoseResult` içinde `roundedUnits`, `rawUnits`, `mealUnits`, `correctionUnits`, `iobDeducted`, `warnings[]` (enum), `breakdown[]` (UI'da gösterilecek satırlar), `assumptions[]`, `requiresUserConfirmation` (doğrulanmamış veri vs.).

> Yağ/protein etkisi (geç yükselme, ikili/uzatılmış bolus) **hesaplanmaz**; yüksek yağlı/proteinli öğünlerde yalnızca bilgi notu gösterilir: "Etki gecikebilir, doktorunuza danışın."

### 4.3 Zorunlu birim test vakaları (hepsi geçmeli; ek vakalar yazılmalı)

| # | Karbonhidrat | ICR | Glikoz | Hedef | ISF | IOB | Adım | Beklenen |
|---|---|---|---|---|---|---|---|---|
| 1 | 45 g | 10 | yok | – | – | 0 | 0,5 | 4,5 U |
| 2 | 45 g | 10 | 180 | 100 | 40 | 1,0 | 0,5 | öğün 4,5 + düzeltme 1,0 = **5,5 U** |
| 3 | 30 g | 12 | 90 | 100 | 40 | 0 | 0,5 | negatif düzeltme kapalı → **2,5 U** |
| 4 | 47,5 g | 10 | yok | – | – | 0 | 0,5 | ham 4,75 → ortada aşağı → **4,5 U** |
| 5 | 60 g | 10 | 65 | 100 | 40 | 0 | 0,5 | **BLOK: hipoglisemi**, doz yok |
| 6 | 0 g | 10 | 200 | 100 | 50 | 0 | 1 | yalnızca düzeltme 2,0 → **2 U** |
| 7 | 120 g | 8 | yok | – | – | 0 | 1 | ham 15 > max doz (ör. 12) → **üst sınır uyarısı**, doz gösterilmez |
| 8 | 45 g | 10 | 10,0 mmol/L | 5,5 mmol/L | 2,2 mmol/L/U | 0 | 0,5 | mmol/L dönüşümü doğru çalışmalı (mg/dL eşdeğeriyle aynı sonuç) |
| 9 | 45 g | 10 | 300 | 100 | 40 | 0 | 0,5 | doz + **güçlü yüksek glikoz/keton uyarısı** |
| 10 | herhangi | eksik | – | – | – | – | – | `missingSettings` |

Ek olarak: property-based testler (doz hiçbir zaman negatif olmaz, karbonhidrat artınca doz azalmaz, birim dönüşümü simetriktir) ve IOB'nin zaman içinde monoton azaldığını doğrulayan testler yaz.

### 4.4 mL gösterimi (isteğe bağlı)
Yalnızca U-100: `mL = ünite / 100`. Örnek: 5,5 U = 0,055 mL. Ayarlarda "Şırınga kullanıyorum" işaretliyse göster; kalem kullanıcılarına gösterme.

---

## 5. BESİN VERİSİ STRATEJİSİ (en kritik bölüm)

### 5.1 Kaynak hiyerarşisi
1. **Resmi/akademik kompozisyon veritabanları:** TürKomp (Türkiye Besin Kompozisyon Veri Tabanı), USDA FoodData Central. Lisans ve atıf koşullarını kontrol et, `DATA_SOURCES.md`'ye yaz.
2. **Paketli ürünler:** Open Food Facts (barkod araması) — topluluk verisidir, ODbL lisanslıdır (atıf zorunlu). Bu veri **otomatik olarak `community_unverified`** işaretlenir.
3. **Kullanıcı girişi:** Kullanıcı kendi paketinin etiket değerlerini elle girebilir (`user_entered`). Etiket fotoğrafı kaydı opsiyonel (v2).
4. **Editoryal doğrulama:** Admin/diyetisyen paneli (basit web ya da Supabase Studio + SQL view) ile kayıtlar `official_verified` veya `label_verified` yapılabilir; kim, ne zaman doğruladı loglanır.

### 5.2 Doğrulama düzeyleri (enum `verification_status`)
`official_verified` · `label_verified` · `community_unverified` · `user_entered` · `sample_only`

### 5.3 Veri kalitesi kontrolleri (import sırasında ve DB constraint olarak)
- Karbonhidrat, protein, yağ, lif, şeker ≥ 0 ve her biri ≤ 100 g/100 g.
- şeker ≤ toplam karbonhidrat; lif ≤ toplam karbonhidrat.
- (karbonhidrat + protein + yağ + su + kül) toplamı 100 g/100 g'ı belirgin biçimde aşmamalı (tolerans %5).
- kcal tutarlılığı: `4·karb + 4·protein + 9·yağ` ile kcal arasında > %25 sapma varsa kayıt **karantinaya** alınır, `import_quarantine` tablosuna yazılır, UI'a girmez.
- Pişmiş/çiğ ayrımı zorunlu alan (`preparation`): ham, haşlanmış, kızarmış vb. Aynı yiyeceğin pişmiş/çiğ değerleri ayrı kayıt.
- Porsiyon ölçüleri (1 dilim ekmek, 1 su bardağı pilav, 1 simit…) gram karşılığıyla ve **kaynağıyla** tutulur; kaynaksız porsiyon eklenmez.

### 5.4 Hesaplanan karbonhidrat
- Varsayılan: **etiketteki/kompozisyondaki toplam karbonhidrat** (g) kullanılır.
- Ayar (varsayılan kapalı): "Lifi düş" — açıksa `net = toplam − lif`; açıkken bu bilginin doktorla teyit edilmesi gerektiği notu gösterilir.
- Glisemik indeks (GI) yalnızca kaynağı belli olduğunda gösterilir; glisemik yük = `GI × karbonhidrat(g) / 100` (hesaplanır, saklanmaz).
- Karbonhidrat değişim birimi (Türkiye'de diyetisyenler genellikle 15 g = 1 değişim kullanır) ayarlanabilir (10 g / 15 g).

### 5.5 Import pipeline
- `tools/import/` altında Dart veya Python script'leri: kaynak dosya → normalizasyon → kalite kontrolleri → `foods` tablosu + `food_sources` kaydı. Her kayıt `source_id`, `source_ref`, `source_version`, `imported_at` taşır.
- Script **idempotent** olmalı, değişiklikleri `food_audit_log`'a yazmalı.
- Ajan veriyi indiremiyorsa import kodunu ve `README_IMPORT.md` talimatını yazar, **veri uydurmaz**.

### 5.6 Arama
- Türkçe normalizasyon (ı/İ, ş, ğ, ü, ö, ç): `normalized_name` alanı. İstemcide SQLite FTS5, sunucuda Postgres `unaccent` + `pg_trgm` + `turkish` metin arama yapılandırması.
- Yazım hatasına toleranslı (trigram) arama, kategori filtresi, favoriler, son kullanılanlar, barkod tarama (`mobile_scanner`).
- Paketli ürün bulunamazsa → "Etiketten elle ekle" akışı (karbonhidrat/100 g, porsiyon gramajı, şeker, lif, kalori).

---

## 6. TEKNOLOJİ YIĞINI

- **Flutter** (güncel stable) + **Dart 3**, null safety, `very_good_analysis` lint seti.
- **Durum yönetimi:** Riverpod (`riverpod_generator`). **Yönlendirme:** `go_router`.
- **Model:** `freezed` + `json_serializable`. **Hata yönetimi:** sealed `Result` tipleri; kritik akışlarda istisna fırlatma yerine açık sonuç tipleri.
- **Yerel veritabanı (çevrimdışı öncelikli):** `drift` (SQLite) — doz hesaplayıcı ve besin veritabanı **internetsiz çalışmalı**. Doğrulanmış besin DB'si uygulama ile birlikte paketlenir, güncellemeler sunucudan delta olarak gelir.
- **Backend:** **Supabase** (PostgreSQL + Auth + Row Level Security + Edge Functions + Storage). Alternatif düşünme; Supabase'e sabitle.
- **Diğer paketler:** `supabase_flutter`, `mobile_scanner`, `fl_chart`, `flutter_local_notifications`, `local_auth` (biyometrik kilit), `flutter_secure_storage`, `pdf` + `printing` (doktor raporu), `intl` + ARB (l10n), `connectivity_plus`, `package_info_plus`.
- Paket sürümlerini pub.dev'den güncel/uyumlu çek; kullanımdan kalkmış paket kullanma.
- **CI:** GitHub Actions — `flutter analyze`, `flutter test --coverage`, doz motoru için kapsam eşiği %100, format kontrolü.

---

## 7. MİMARİ VE KLASÖR YAPISI

Feature-first + katmanlı (presentation / application / domain / data).

```
glikorehber/
├─ apps/mobile/
│  ├─ lib/
│  │  ├─ main.dart, app.dart, bootstrap.dart
│  │  ├─ core/            (theme, l10n, router, constants, utils, error, security)
│  │  ├─ features/
│  │  │  ├─ onboarding/
│  │  │  ├─ profile_settings/   (diyabet tipi, ICR/ISF/hedef/DIA, birimler)
│  │  │  ├─ food/               (arama, detay, barkod, manuel ekleme, favoriler)
│  │  │  ├─ meal_builder/       (tabak, öğün toplamı)
│  │  │  ├─ dose_calculator/    (UI; hesap packages/dose_engine'den)
│  │  │  ├─ glucose_log/
│  │  │  ├─ history_reports/    (grafikler, PDF)
│  │  │  ├─ education/
│  │  │  ├─ emergency/          (hipoglisemi kartı)
│  │  │  └─ account_privacy/
│  │  └─ data/ (drift db, supabase client, repositories, sync)
│  ├─ assets/ (fonts, illustrations, bundled_food_db)
│  └─ test/, integration_test/
├─ packages/dose_engine/       (pure Dart, ayrı test paketi)
├─ backend/supabase/ (migrations, seed (yalnızca sample), functions, policies)
├─ tools/import/               (TürKomp / USDA / OFF import script'leri)
└─ docs/ (PLAN.md, ASSUMPTIONS.md, DATA_SOURCES.md, CLINICAL_REVIEW_CHECKLIST.md, PRIVACY.md)
```

**Senkronizasyon:** offline-first; yerel yazma → kuyruk → Supabase. Çakışmada son yazan kazanır, ancak `dose_logs` ve `consent_logs` **değiştirilemez (append-only)**.

---

## 8. VERİTABANI ŞEMASI (Supabase / PostgreSQL — temel)

```sql
create type diabetes_type as enum ('type1','type2_prandial_insulin','type2_basal_or_none','other');
create type verification_status as enum
  ('official_verified','label_verified','community_unverified','user_entered','sample_only');

create table food_sources (
  id uuid primary key default gen_random_uuid(),
  name text not null,                -- TürKomp, USDA FDC, Open Food Facts...
  url text, license text, attribution_text text, version text
);

create table foods (
  id uuid primary key default gen_random_uuid(),
  name_tr text not null, name_en text,
  normalized_name text not null,
  category text, brand text, barcode text unique,
  preparation text not null default 'as_sold',   -- raw/cooked/boiled/fried/as_sold
  carbs_g_per_100g numeric(6,2) check (carbs_g_per_100g between 0 and 100),
  sugars_g_per_100g numeric(6,2), fiber_g_per_100g numeric(6,2),
  protein_g_per_100g numeric(6,2), fat_g_per_100g numeric(6,2),
  kcal_per_100g numeric(6,1), gi smallint check (gi between 0 and 110),
  gi_source text,
  source_id uuid references food_sources(id), source_ref text, data_date date,
  verification verification_status not null default 'community_unverified',
  verified_by uuid, verified_at timestamptz,
  is_sample boolean not null default false,
  version int not null default 1, updated_at timestamptz default now(),
  constraint sugars_le_carbs check (sugars_g_per_100g is null or sugars_g_per_100g <= carbs_g_per_100g),
  constraint fiber_le_carbs  check (fiber_g_per_100g  is null or fiber_g_per_100g  <= carbs_g_per_100g)
);

create table food_portions (
  id uuid primary key default gen_random_uuid(),
  food_id uuid references foods(id) on delete cascade,
  label_tr text not null, grams numeric(7,2) not null check (grams > 0),
  source_ref text not null
);

create table food_audit_log (...);       -- kim/ne zaman/hangi alan değişti
create table import_quarantine (...);    -- kalite kontrolünden geçemeyen kayıtlar

create table profiles (
  user_id uuid primary key references auth.users on delete cascade,
  birth_year int, diabetes_type diabetes_type not null,
  glucose_unit text not null default 'mgdl',
  uses_syringe boolean default false, insulin_concentration smallint default 100
);

create table therapy_settings (       -- versiyonlu; eski kayıtlar silinmez
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users on delete cascade,
  icr_blocks jsonb not null,          -- [{from:"06:00",to:"11:00",gPerUnit:10}, ...]
  isf_mgdl_per_unit numeric, target_mgdl numeric, dia_hours numeric,
  dose_step numeric not null, max_single_dose numeric not null,
  allow_negative_correction boolean default false, subtract_fiber boolean default false,
  confirmed_with_clinician boolean not null default false,
  created_at timestamptz default now()
);

create table glucose_logs (id uuid primary key, user_id uuid, value_mgdl numeric,
  context text, measured_at timestamptz, note text);
create table meal_logs (id uuid primary key, user_id uuid, items jsonb, total_carbs_g numeric, created_at timestamptz);
create table dose_logs (                -- append-only
  id uuid primary key, user_id uuid, meal_log_id uuid, input_snapshot jsonb,
  result_snapshot jsonb, engine_version text, applied_units numeric, applied_at timestamptz);
create table consent_logs (id uuid primary key, user_id uuid, type text, text_version text, accepted_at timestamptz);
create table education_articles (id uuid primary key, slug text unique, title_tr text, body_md text,
  reviewed_by text, reviewed_at date, sources jsonb);
```

**RLS:** kullanıcı tabloları `user_id = auth.uid()`; `foods`/`food_portions`/`education_articles` herkese okuma, yazma yalnızca admin rolüne. `dose_logs` ve `consent_logs` için update/delete politikası **yok**.
**Edge Function:** `lookup_barcode` — Open Food Facts proxy; sonucu `community_unverified` ile önbelleğe alır, kalite kontrollerinden geçirir.

---

## 9. EKRANLAR VE UX AKIŞLARI

1. **Splash → Onboarding:** (a) sorumluluk reddi + açık rıza (kaydırmadan "Kabul" aktifleşmez), (b) yaş (18 altı → bilgi modu), (c) **diyabet tipi seçimi** (4 büyük kart), (d) insülin kullanımı, (e) glikoz birimi, (f) "Doktorunuzun verdiği değerleri girin" ayar sihirbazı (ICR, ISF, hedef, DIA, doz adımı, max doz) — her alanda "Bunu nereden bulurum?" yardım balonu, (g) "Bu değerleri doktorumla teyit ettim" onayı.
2. **Ana sayfa:** son glikoz, bugünkü toplam karbonhidrat, hızlı eylemler (Besin Ara, Barkod Tara, Doz Hesapla, Glikoz Ekle), kırmızı **Hipoglisemi Yardımı** kısayolu her zaman görünür.
3. **Besin arama:** arama çubuğu, kategori çipleri, barkod butonu, favoriler/son kullanılanlar.
4. **Besin detayı:** 100 g ve seçilen porsiyon için karbonhidrat/şeker/lif/protein/yağ/kcal, GI/GL, **kaynak + doğrulama rozeti + veri tarihi**, gram/porsiyon seçici (çarpan anında hesaplanır), "Öğüne ekle".
5. **Öğün oluşturucu (tabak):** eklenen besinler, adet/gram düzenleme, toplam karbonhidrat (büyük), toplam değişim birimi, karbonhidrat dağılım grafiği.
6. **Doz hesaplayıcı** (yalnızca uygun profiller): öğün karbonhidratı (otomatik), güncel glikoz (opsiyonel), aktif insülin (otomatik, düzenlenebilir), "Hesapla" → **sonuç kartı:** büyük ünite değeri, altında adım adım döküm, uyarılar, doğrulanmamış veri onayı, "Uyguladım" butonu (dose_logs'a yazar). Sonuç her zaman sabit sorumluluk ibaresini gösterir.
7. **Glikoz günlüğü:** hızlı giriş (sayısal klavye), bağlam (aç/tok/yatmadan/egzersiz), liste + trend grafiği, hedef aralığı bandı.
8. **Geçmiş ve raporlar:** günlük/haftalık/aylık karbonhidrat ve glikoz özeti, aralıkta kalma yüzdesi, **doktora PDF raporu** (kullanılan ayarlar + günlükler).
9. **Eğitim:** hipoglisemi, hiperglisemi, keton, hasta günü, egzersiz, enjeksiyon bölgesi rotasyonu, karbonhidrat sayımı temelleri, tabak yöntemi, etiket okuma. Her makale: gözden geçiren uzman, tarih, kaynaklar.
10. **Hipoglisemi acil kartı:** belirtiler, 15-15 kuralı adımları, zamanlayıcı (15 dk), "bilinç kaybı → 112" butonu.
11. **Hatırlatıcılar:** ölçüm, enjeksiyon, öğün (yerel bildirim).
12. **Ayarlar:** terapi ayarları (versiyonlu geçmiş), birimler, biyometrik kilit, dil, tema, veri dışa aktarma, **hesap ve veri silme**.

---

## 10. TASARIM SİSTEMİ

- **His:** sakin, güven veren, klinik olup soğuk olmayan; kullanıcıyı korkutmayan ama net uyaran dil.
- **Material 3**, özel `ThemeData`; açık + koyu tema; tüm renkler `ColorScheme` tokenları üzerinden (hard-code renk yok).
- **Palet önerisi:** birincil deniz yeşili/teal, ikincil sıcak amber (vurgu), nötr gri-mavi yüzeyler. Durum renkleri: düşük (kırmızı), hedefte (yeşil), yüksek (turuncu).
- **Erişilebilirlik (zorunlu):** WCAG AA kontrast; glikoz durumu **yalnızca renkle değil ikon + metinle** (▼ Düşük / ● Hedefte / ▲ Yüksek) belirtilir (renk körlüğü); minimum dokunma alanı 48 dp; sistem yazı tipi ölçeklemesine %200'e kadar uyum; `Semantics` etiketleri (TalkBack/VoiceOver); büyük sayısal göstergeler `tabular figures` ile.
- **Tipografi:** okunabilir bir sans-serif (örn. Inter / Nunito); fontlar `assets`'e paketlenir (çevrimdışı).
- **Bileşenler:** `GlucoseChip`, `CarbBadge`, `VerificationBadge`, `DoseResultCard`, `WarningBanner` (info/warn/critical), `NumericField` (Türkçe ondalık virgül desteği, doğrulamalı), `PlateSummary`, `EmergencyFAB`.
- **Mikro etkileşim:** sakin geçişler, aşırı animasyon yok; kritik uyarılarda haptik geri bildirim.
- **Sayı biçimi:** Türkçe yerel ayar (ondalık virgül). Giriş alanları hem `,` hem `.` kabul eder; ayrıştırma hatasında sessizce yanlış sayı üretme — hata göster.
- Boş durum, hata durumu, yükleme (skeleton) ve çevrimdışı durumları için tasarım üret.

---

## 11. EĞİTİM İÇERİĞİ KURALLARI

- İçerik taslağı üretilebilir ancak her makale `reviewed_by = null` ve "TASLAK – klinik gözden geçirme bekliyor" rozetiyle gelir; **gözden geçirme yapılmadan** üretim sürümünde gösterilmez (feature flag).
- Kaynak olarak Türkiye Diyabet Vakfı, TEMD, ADA, IDF gibi kurum rehberlerine atıf için `sources` alanı hazırlanır; ajan içeriği uydurma kaynakla doldurmaz, boş bırakır.

---

## 12. GÜVENLİK VE GİZLİLİK (KVKK / sağlık verisi = özel nitelikli kişisel veri)

- Açık rıza ekranı + aydınlatma metni şablonu (`docs/PRIVACY.md`); rıza sürümlü ve `consent_logs`'a yazılır.
- Aktarımda TLS; cihazda `flutter_secure_storage` ile token; yerel DB için şifreleme (SQLCipher / drift şifreleme) değerlendirilsin ve uygulansın.
- Biyometrik/PIN kilit (opsiyonel, önerilir). Ekran görüntüsü/uygulama önizlemesi gizleme seçeneği.
- Üçüncü taraf analitik/reklam SDK'sı **yok**. Çökme raporlaması kullanılacaksa kişisel sağlık verisi içermeyecek şekilde filtrelenir.
- Hesap silme = sunucudan tüm kullanıcı verisinin kalıcı silinmesi; veri dışa aktarma (JSON/CSV/PDF).
- Gizli anahtarlar repoda yok (`--dart-define` / `.env` dışarıda), `.gitignore` kontrol edilir.
- Yasal not: Doz hesaplayıcı yazılımı bazı ülkelerde **tıbbi cihaz yazılımı** sayılabilir (AB MDR / Türkiye TİTCK). Bu yüzden `docs/REGULATORY_NOTES.md` oluştur ve yayın öncesi yapılacakları listele (endokrinolog + diyetisyen klinik inceleme, risk analizi (ISO 14971 yaklaşımı), hukuki danışmanlık). **Uygulama yayınlanmadan önce bu adımlar tamamlanmadan "tıbbi doğruluk garantisi" iddiası yapılmaz.**

---

## 13. TEST STRATEJİSİ

- **Unit:** doz motoru (Bölüm 4.3 + property-based), birim dönüşümleri, yuvarlama, IOB, Türkçe sayı ayrıştırma, besin kalite kontrolleri.
- **Golden test:** doz sonuç kartı, uyarı bannerları, besin detay (açık/koyu tema, 1.0x ve 2.0x yazı ölçeği).
- **Widget test:** onboarding akışı, tip bazlı özellik kapatma (Tip 2 insülinsiz → doz sekmesi yok), hipoglisemi bloğu, doğrulanmamış veri onay kutusu zorunluluğu.
- **Integration test:** barkod → besin → öğün → doz → log uçtan uca (barkod için mock).
- **Backend:** RLS politikaları için SQL testleri (başka kullanıcının verisi okunamaz/yazılamaz; `dose_logs` değiştirilemez).
- **Veri testleri:** import pipeline için sabit girdi/çıktı testleri; karantina davranışı.
- **Erişilebilirlik:** semantics denetimi, kontrast kontrolü.
- `CLINICAL_REVIEW_CHECKLIST.md`: insan klinisyenin onaylaması gereken tüm sabitler, eşikler, formüller ve metinlerin listesi (ajan bunu dolduracak, klinisyen imzalayacak).

---

## 14. FAZLAR

**Faz 0 — Plan ve iskelet:** `PLAN.md`, repo yapısı, lint, CI, l10n altyapısı, tema iskeleti.
**Faz 1 — Doz motoru:** `packages/dose_engine` + tüm testler (Bölüm 4). *Kabul: %100 kapsam, 10 vakanın hepsi geçer.*
**Faz 2 — Veri katmanı:** Supabase migration'ları, RLS, drift şeması, import pipeline iskeleti, kalite kontrolleri, örnek (`is_sample`) minimal veri.
**Faz 3 — Tasarım sistemi + Onboarding + Ayarlar:** bileşen kütüphanesi, tip seçimi, terapi ayar sihirbazı, rıza kayıtları.
**Faz 4 — Besin modülü:** arama (FTS), detay, porsiyonlar, barkod, manuel ekleme, favoriler, doğrulama rozetleri.
**Faz 5 — Öğün + Doz ekranı:** öğün oluşturucu, doz hesaplayıcı UI, formül dökümü, uyarılar, doz logu, IOB.
**Faz 6 — Glikoz günlüğü + Raporlar:** giriş, grafikler, aralıkta kalma, PDF rapor.
**Faz 7 — Eğitim + Acil durum + Hatırlatıcılar.**
**Faz 8 — Auth + Senkronizasyon + KVKK:** giriş/kayıt, offline-first sync, hesap silme, veri dışa aktarma, biyometrik kilit.
**Faz 9 — Sertleştirme:** erişilebilirlik, performans (soğuk açılış < 2 sn hedef), ikinci dil (EN), release build'de sample veri engeli, güvenlik gözden geçirmesi, mağaza hazırlığı (ikonlar, gizlilik etiketleri), `CLINICAL_REVIEW_CHECKLIST.md` ve `REGULATORY_NOTES.md` tamamlama.

Her faz sonunda ajan şu çıktıyı verir: yapılanlar, çalıştırılan test sonuçları, açık kalan riskler, bir sonraki fazın ön koşulları.

---

## 15. TAMAMLANMA KRİTERLERİ (Definition of Done)

- [ ] Doz motoru testleri %100 kapsamla geçiyor; UI içinde hiçbir doz hesabı yok.
- [ ] Hiçbir klinik değer varsayılan olarak dolu değil.
- [ ] Hipoglisemi bloğu, üst sınır, doğrulanmamış veri onayı, sorumluluk ibaresi çalışıyor.
- [ ] Uygulama uçak modunda besin arama + doz hesaplamayı yapabiliyor.
- [ ] Her besin kaydında kaynak, tarih ve doğrulama rozeti görünüyor.
- [ ] Release build'de `is_sample` kayıtları görünmüyor.
- [ ] Tip 1 / Tip 2 (insülinli) / Tip 2 (insülinsiz) akışları doğru özellik setini açıyor.
- [ ] RLS testleri geçiyor; `dose_logs` değiştirilemiyor.
- [ ] Erişilebilirlik kontrolleri (kontrast, ölçekleme, semantics) geçiyor.
- [ ] `flutter analyze` temiz, CI yeşil.

---

## 16. YAPILMAYACAKLAR

- Besin/doz/klinik veriyi hafızadan veya LLM ile üretmek.
- Varsayılan ICR/ISF/hedef değerleri koymak.
- Karbonhidrat dışı etkileri (yağ/protein/egzersiz/hastalık) otomatik hesaba katmak.
- "Tedavi eder", "doğruluğu garanti edilir" gibi iddialar.
- Reklam veya üçüncü taraf takip SDK'sı.
- Doz hesaplamasını UI katmanına veya backend'e yaymak (tek kaynak: `dose_engine`).
- Kullanıcıya renk tek başına anlam taşıyan arayüz sunmak.
- Hata durumunda sessizce varsayılan/0 değeriyle devam etmek (hata → açık uyarı, hesaplama durur).
