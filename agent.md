# GlikoRehber - Agent İlerleme ve Faz Takip Günlüğü (`agent.md`)

Bu dosya, projede gerçekleştirilen tüm geliştirme adımlarını, fazları, test sonuçlarını ve GitHub senkronizasyon durumunu kayıt altına alır.

---

## 📌 Genel Proje Bilgileri
- **Proje Adı:** GlikoRehber (Diyabet Karbonhidrat ve İnsülin Doz Asistanı)
- **Depo:** `https://github.com/abdulsamet-kasal/diyabet` (Public)
- **Platform:** Flutter 3.47+ / Dart 3.13+ (Android öncelikli, iOS uyumlu)
- **Donanım Kısıtları:** CachyOS Linux (8GB RAM - AMD Ryzen 3 5300U)
- **Gradle JVM Kısıtı:** `-Xmx1536M -XX:MaxMetaspaceSize=384M -XX:ReservedCodeCacheSize=256m -XX:+UseG1GC`

---

## 🗺️ Faz Durum Tablosu

| Faz | Açıklama | Durum | Testler & Analiz | Commit / Sürüm |
|---|---|---|---|---|
| **Faz 0** | Plan ve İskelet (Mimari, Lint, CI, Dokümantasyon, L10n, Tema temeli) | 🟢 Tamamlandı | flutter analyze: 0 hata, testler: %100 yeşil | `faz-0: initial-skeleton` |
| **Faz 1** | Doz Motoru (`packages/dose_engine` saf Dart, %100 test kapsamı, 10 klinik vaka) | 🟢 Tamamlandı | 27 testin tamamı yeşil, analyze 0 hata | `faz-1: dose-engine` |
| **Faz 2** | Veri Katmanı (Supabase şeması, Drift yerel DB, Import pipeline, Kalite kontrolleri) | ⚪ Bekliyor | - | - |
| **Faz 3** | Tasarım Sistemi + Onboarding + Terapi Ayarları | ⚪ Bekliyor | - | - |
| **Faz 4** | Besin Modülü (Arama/FTS, Detay, Porsiyonlar, Barkod, Doğrulama) | ⚪ Bekliyor | - | - |
| **Faz 5** | Öğün Oluşturucu + Doz Hesaplama Ekranı & Doz Logu | ⚪ Bekliyor | - | - |
| **Faz 6** | Glikoz Günlüğü + Raporlar (PDF Dokümanı) | ⚪ Bekliyor | - | - |
| **Faz 7** | Eğitim İçeriği + Acil Durum (Hipoglisemi Kartı) + Hatırlatıcılar | ⚪ Bekliyor | - | - |
| **Faz 8** | Supabase Senkronizasyon + KVKK / Gizlilik + Biyometrik Kilit | ⚪ Bekliyor | - | - |
| **Faz 9** | Sertleştirme, Erişilebilirlik, Testler & APK Derleme/Yayınlama | ⚪ Bekliyor | - | - |

---

## 📝 Faz Geliştirme Detayları

### [Faz 0] - Plan ve İskelet
- **Tarih:** 2026-10-01
- **Yapılanlar:**
  - Git deposu ilklendirildi ve `abdulsamet-kasal/diyabet` public repo GitHub'a bağlandı.
  - `agent.md`, `PLAN.md`, `ASSUMPTIONS.md`, `OPEN_QUESTIONS.md`, `DATA_SOURCES.md`, `CLINICAL_REVIEW_CHECKLIST.md`, `CHANGELOG.md` dokümanları oluşturuluyor.
  - Proje dizin yapısı (`apps/mobile`, `packages/dose_engine`, `backend/supabase`, `tools/import`, `docs`) oluşturuluyor.
  - Donanım ve Gradle bellek limitleri yapılandırıldı.

### [Faz 1] - Doz Motoru (`packages/dose_engine`)
- **Tarih:** 2026-10-01
- **Yapılanlar:**
  - `packages/dose_engine` saf Dart paketi geliştirildi (UI, ağ, AI bağımlılığı olmadan deterministik).
  - Güvenlik ve klinik değişmezler uygulandı:
    1. Hipoglisemi Bloğu (< 70 mg/dL'de doz kesme; < 54 mg/dL'de acil 112 uyarısı).
    2. Maksimum Tek Doz Limiti (aşıldığında hesaplama kilitlenir).
    3. Muhafazakâr Yuvarlama (doz adımına göre, tam ortada kalanlar hipoglisemi riskini önlemek için daima AŞAĞI yuvarlanır: örn. 4.75 -> 4.5).
    4. Aktif İnsülin (IOB) düşümü yalnızca düzeltme bileşeninden yapılır; öğün dozundan asla düşülmez.
    5. Birim normalizasyonu: mmol/L ve mg/dL simetrisi sağlandı.
    6. Şeffaf matematik dökümü (`breakdown`) ve U-100 şırınga mL karşılığı.
  - Test Sonuçları:
    - 10 zorunlu klinik vaka (%100 yeşil).
    - Monotonluk, negatif olmama ve birim dönüşüm simetrisi property testleri (%100 yeşil).
    - IOB monoton azalma ve DIA tükenme testleri (%100 yeşil).
    - Toplam 27 test başarıyla geçti.
