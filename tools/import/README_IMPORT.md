# Besin Verisi İçe Aktarma Rehberi (`README_IMPORT.md`)

Bu dizin, resmi ve akademik besin kompozisyonu veri tabanlarını (TürKomp, USDA FoodData Central) ve Open Food Facts verilerini GlikoRehber veritabanına aktarmak için kullanılan araçları içerir.

## 1. Kalite Kontrolleri (`food_validator.py`)
Tüm veriler aktarılmadan önce aşağıdaki klinik ve analitik testlerden geçer:
1. **0-100 g Sınırı:** Karbonhidrat, protein, yağ, lif, şeker değerleri 0 ile 100 arasında olmalıdır.
2. **Alt Bileşen Mantığı:** Şeker ve lif asla toplam karbonhidrattan büyük olamaz (`sugars <= carbs`, `fiber <= carbs`).
3. **Makro Toplam Toleransı:** `(karbonhidrat + protein + yağ) <= 105 g` (%5 nem/kül toleransı).
4. **Kalori Tutarlılığı:** `4·karb + 4·protein + 9·yağ` ile beyan edilen kcal arasında > %25 sapma varsa kayıt **karantinaya (`import_quarantine`)** alınır.
5. **Pişirme Durumu (`preparation`):** `raw`, `cooked`, `boiled`, `fried`, `as_sold` alanlarından biri zorunludur.

## 2. Çalıştırma
```bash
# Gerekli bağımlılıklar
python3 -m pip install psycopg2-binary requests

# Doğrulama testlerini çalıştırma
python3 tools/import/test_validator.py
```
