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
| **Faz 1** | Doz Motoru (`packages/dose_engine` saf Dart, %100 test kapsamı, 10 klinik vaka) | ⚪ Bekliyor | - | - |
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
