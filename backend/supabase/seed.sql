-- ====================================================================
-- GlikoRehber Supabase Seed Data (Sample Only)
-- Note: All sample records are marked with is_sample = true
-- ====================================================================

-- 1. Verified Sources
insert into food_sources (id, name, url, license, attribution_text, version) values
('a0000000-0000-0000-0000-000000000001', 'TürKomp', 'https://www.turkomp.gov.tr', 'Resmi Kullanım', 'TÜBİTAK MAM & T.C. Tarım ve Orman Bakanlığı', '2024.1'),
('a0000000-0000-0000-0000-000000000002', 'USDA FoodData Central', 'https://fdc.nal.usda.gov', 'Public Domain', 'U.S. Department of Agriculture', '2024.2'),
('a0000000-0000-0000-0000-000000000003', 'Open Food Facts', 'https://world.openfoodfacts.org', 'ODbL', 'Open Food Facts Contributors', '2026.1');

-- 2. Sample Verified Foods (TürKomp & USDA verified references)
insert into foods (
  id, name_tr, name_en, normalized_name, category, brand, barcode, preparation,
  carbs_g_per_100g, sugars_g_per_100g, fiber_g_per_100g, protein_g_per_100g, fat_g_per_100g, kcal_per_100g,
  gi, gi_source, source_id, source_ref, data_date, verification, is_sample
) values
(
  'b0000000-0000-0000-0000-000000000001', 'Beyaz Ekmek (Somun)', 'White Bread', 'beyaz ekmek somun', 'Tahıllar', null, '869000000001', 'as_sold',
  49.50, 2.50, 2.70, 8.50, 1.20, 250.0,
  70, 'TürKomp Ref 102', 'a0000000-0000-0000-0000-000000000001', 'TK-102', '2024-01-15', 'official_verified', true
),
(
  'b0000000-0000-0000-0000-000000000002', 'Kırmızı Elma (Kabuklu)', 'Red Apple with skin', 'kirmizi elma kabuklu', 'Meyveler', null, '869000000002', 'raw',
  13.80, 10.40, 2.40, 0.30, 0.20, 52.0,
  36, 'USDA FDC 11095', 'a0000000-0000-0000-0000-000000000002', 'FDC-11095', '2024-02-10', 'official_verified', true
),
(
  'b0000000-0000-0000-0000-000000000003', 'Pirinç Pilavı (Sade, Pişmiş)', 'Cooked White Rice', 'pirinc pilavi sade pismis', 'Tahıllar & Yemekler', null, '869000000003', 'cooked',
  28.20, 0.10, 0.40, 2.70, 2.80, 150.0,
  68, 'TürKomp Ref 504', 'a0000000-0000-0000-0000-000000000001', 'TK-504', '2024-03-01', 'official_verified', true
),
(
  'b0000000-0000-0000-0000-000000000004', 'Süt (Tam Yağlı)', 'Whole Milk', 'sut tam yagli', 'Süt ve Süt Ürünleri', null, '869000000004', 'as_sold',
  4.80, 4.80, 0.00, 3.30, 3.50, 64.0,
  27, 'TürKomp Ref 201', 'a0000000-0000-0000-0000-000000000001', 'TK-201', '2024-01-20', 'official_verified', true
),
(
  'b0000000-0000-0000-0000-000000000005', 'Kuru Fasulye (Haşlanmış)', 'Cooked White Beans', 'kuru fasulye haslanmis', 'Baklagiller', null, '869000000005', 'boiled',
  25.10, 0.30, 6.40, 9.70, 0.50, 142.0,
  31, 'TürKomp Ref 305', 'a0000000-0000-0000-0000-000000000001', 'TK-305', '2024-02-18', 'official_verified', true
);

-- 3. Portions for sample foods
insert into food_portions (id, food_id, label_tr, grams, source_ref) values
('c0000000-0000-0000-0000-000000000001', 'b0000000-0000-0000-0000-000000000001', '1 İnce Dilim', 25.0, 'TürKomp Porsiyon Tablosu'),
('c0000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000001', '1 Kalın Dilim', 50.0, 'TürKomp Porsiyon Tablosu'),
('c0000000-0000-0000-0000-000000000003', 'b0000000-0000-0000-0000-000000000002', '1 Küçük Boy Elma', 100.0, 'USDA Serving Guide'),
('c0000000-0000-0000-0000-000000000004', 'b0000000-0000-0000-0000-000000000002', '1 Orta Boy Elma', 150.0, 'USDA Serving Guide'),
('c0000000-0000-0000-0000-000000000005', 'b0000000-0000-0000-0000-000000000003', '1 Kepçe / 4 Yemek Kaşığı', 80.0, 'TEMD Diyetisyen Rehberi'),
('c0000000-0000-0000-0000-000000000006', 'b0000000-0000-0000-0000-000000000004', '1 Su Bardağı (200 ml)', 200.0, 'Standart Ölçü');
