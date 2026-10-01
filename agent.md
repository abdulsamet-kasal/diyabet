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
| **Faz 2** | Veri Katmanı (Supabase şeması, Drift yerel DB, Import pipeline, Kalite kontrolleri) | 🟢 Tamamlandı | Drift SQLite, RLS, Python validator ve repo testleri %100 | `faz-2: data-layer` |
| **Faz 3** | Tasarım Sistemi + Onboarding + Terapi Ayarları | 🟢 Tamamlandı | Tüm WCAG AA bileşenleri, Riverpod NotifierProvider ve testler yeşil | `faz-3: design-onboarding` |
| **Faz 4** | Besin Modülü (Arama/FTS, Detay, Porsiyonlar, Barkod, Doğrulama) | 🟢 Tamamlandı | Canlı arama, porsiyon/GI-GL hesabı, etiket ekleme ve barkod akışı tamamlandı | `faz-4: food-module` |
| **Faz 5** | Öğün Oluşturucu + Doz Hesaplama Ekranı & Doz Logu | 🟢 Tamamlandı | Tabak yönetimi, profil kilidi, IOB düşümü, append-only loglama ve widget testleri yeşil | `faz-5: meal-dose` |
| **Faz 6** | Glikoz Günlüğü + Raporlar (PDF Dokümanı) | 🟢 Tamamlandı | Canlı ölçüm kaydı, Time-in-Range hesabı, Hekim PDF raporu oluşturma ve testler yeşil | `faz-6: glucose-reports` |
| **Faz 7** | Eğitim İçeriği + Acil Durum (Hipoglisemi Kartı) + Hatırlatıcılar | 🟢 Tamamlandı | 21 testin tamamı yeşil, analyze 0 hata | `faz-7: education-emergency-reminders` |
| **Faz 8** | Supabase Senkronizasyon + KVKK / Gizlilik + Biyometrik Kilit | 🟢 Tamamlandı | 25 testin tamamı yeşil, analyze 0 hata | `faz-8: sync-kvkk-security` |
| **Faz 9** | Sertleştirme, Erişilebilirlik, Testler & APK Derleme/Yayınlama | 🟢 Tamamlandı | %100 CI yeşil, Release APK derlendi & GitHub'a yüklendi | `v1.0.0` (Release) |

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

### [Faz 2] - Veri Katmanı (Supabase & Drift SQLite)
- **Tarih:** 2026-10-01
- **Yapılanlar:**
  - Supabase PostgreSQL migration (`20261001000000_initial_schema.sql`):
    - `foods`, `food_sources`, `food_portions`, `food_audit_log`, `import_quarantine`
    - `profiles`, `therapy_settings`, `glucose_logs`, `meal_logs`
    - Hukuki ve klinik güvenlik: `dose_logs` ve `consent_logs` tabloları salt ekleme (append-only) RLS politikalarıyla güvenceye alındı (UPDATE ve DELETE yasaklandı).
  - Supabase seed dosyası (`seed.sql`):
    - TürKomp ve USDA doğrulanmış örnek besinler eklendi (`is_sample: true`).
  - Supabase Edge Function (`lookup_barcode`):
    - Open Food Facts API proxy ve otomatik kalite/karantina kontrolleri.
  - İçe aktarma kalite kontrolü (`tools/import/food_validator.py`):
    - Makro 0-100g, şeker/lif <= karb, 105g toleransı ve kalori tutarlılığı (> %25 sapmada karantina) testleri yazıldı (%100 yeşil).
  - Mobil çevrimdışı yerel veritabanı (`apps/mobile/lib/data/local/app_database.dart` - Drift SQLite):
    - Drift tabloları ve build_runner kod üretimi tamamlandı.
    - `FoodRepository` (Türkçe karakter normalizasyonu, release build'de `is_sample` filtreleme).
    - `TherapySettingsRepository` (versiyonlu geçmiş saklama).
    - `GlucoseRepository` (ölçüm kaydı, hedef aralıkta kalma TIR hesabı).
    - `DoseRepository` (append-only doz logu, IOB penceresi sorguları).
  - Test Sonuçları:
    - Repository in-memory SQLite testleri 5/5 geçti.
    - `flutter analyze` 0 hata.

### [Faz 3] - Tasarım Sistemi, Onboarding & Ayarlar
- **Tarih:** 2026-10-01
- **Yapılanlar:**
  - WCAG AA Erişilebilirlik Bileşenleri geliştirildi:
    - `GlucoseChip` (renk tek başına kullanılmaz; ikon + metin + değer ile ▼ Düşük / ● Hedefte / ▲ Yüksek gösterimi).
    - `CarbBadge` (gram + Türkiye 15g değişim birimi karşılığı).
    - `VerificationBadge` (resmi, etiket, kullanıcı, topluluk doğrulanmamış rozetleri).
    - `WarningBanner` (info, warning, critical hiyerarşisi ve erişilebilir renk kontrastı).
    - `NumericField` (Türkçe ondalık virgül desteği, sessiz 0 dönüşümü olmadan katı doğrulama).
    - `DoseResultCard` (şeffaf formül adımları, U-100 şırınga mL karşılığı, hipoglisemi bloğu kartı).
  - Durum Yönetimi (Riverpod):
    - Kullanıcı kuralına uygun modern `NotifierProvider` mimarisi (`userProfileProvider`).
    - Tip 1 / Tip 2 (insülinli) / Tip 2 (insülinsiz) profillerine göre doz hesaplayıcı yetkilendirmesi (`isDoseCalculatorAllowed`).
  - Onboarding & Kurulum Sihirbazı (`OnboardingScreen`):
    - Hukuki aydınlatma ve açık rıza kaydı.
    - 18 yaş kontrolü (18 yaş altında doz hesaplayıcı kilitlenir).
    - 4 farklı diyabet tipi seçimi.
    - Hekim terapi ayarları sihirbazı (ICR, ISF, Hedef, DIA, Doz Adımı, Hekim teyidi).
  - Ayarlar Ekranı (`SettingsScreen`):
    - Versiyonlu terapi parametreleri düzenleme, şırınga mL seçimi, negatif düzeltme ve lif düşümü ayarları.
  - Test Sonuçları:
    - `design_system_test.dart` ve `repository_test.dart` dahil 12 mobil test %100 yeşil.
    - `flutter analyze` 0 hata.

### [Faz 4] - Besin Modülü
- **Tarih:** 2026-10-01
- **Yapılanlar:**
  - `plateProvider` (Öğün tabağı durum yönetimi, toplam karb ve 15g değişim birimi hesabı).
  - `FoodSearchScreen` (Canlı SQLite araması, Türkçe normalizasyon, kategori çipleri, barkod diyalogu).
  - `FoodDetailScreen` (100g ve porsiyon çarpanları, GI ve Glisemik Yük (GL) formülü `(GI * karb)/100`, tabağa ekleme).
  - `AddFoodScreen` (Paket etiketinden elle besin ekleme, `sugars <= carbs`, `fiber <= carbs` kalite kontrolleri, `user_entered` doğrulaması).
  - Test Sonuçları:
    - `flutter analyze` 0 hata.
    - Tüm testler yeşil.

### [Faz 5] - Öğün Oluşturucu & Doz Hesaplayıcı
- **Tarih:** 2026-10-01
- **Yapılanlar:**
  - `MealBuilderScreen`:
    - Tabaktaki besinlerin listelenmesi, tek tek silinmesi veya toplu temizlenmesi.
    - Anlık toplam karbonhidrat ve Türkiye 15g değişim birimi özeti.
    - Tek tıkla "Bu Öğün İçin Doz Hesapla" akışı.
  - `DoseCalculatorScreen`:
    - 18 yaş altı veya insülinsiz Tip 2 profillerinde doz hesaplama güvenlik kilidi (`isDoseCalculatorAllowed`).
    - Tabaktan otomatik aktarılan karb değeri ve isteğe bağlı glikoz girişi.
    - `DoseRepository` üzerinden son enjeksiyonların çekilip IOB (Aktif İnsülin) düşümünün yapılması.
    - `packages/dose_engine` üzerinden saf matematiksel doz hesabı.
    - `DoseResultCard` üzerinde formül dökümü, hipoglisemi bloğu (< 70 mg/dL), keton ve acil hekim uyarıları.
    - Doğrulanmamış gıda ("Paket etiketini kontrol ettim") zorunlu onay kutusu.
    - "Uyguladım ve Günlüğe Kaydet" butonu ile salt ekleme (append-only) `logAppliedDose` kaydı ve tabağın boşaltılması.
  - Test Sonuçları:
    - `dose_flow_test.dart` (reşit olmama güvenlik kilitlemesi ve tam doz hesaplama akışı) başarıyla geçti.
    - 14 mobil test %100 yeşil, `flutter analyze` 0 hata.

### [Faz 6] - Glikoz Günlüğü & Hekim PDF Raporu
- **Tarih:** 2026-10-01
- **Yapılanlar:**
  - `GlucoseLogScreen`:
    - Açlık, tokluk, gece ve egzersiz bağlamlarıyla hızlı ölçüm girişi.
    - Anlık Time-in-Range (70-180 mg/dL) başarı çubuğu.
    - `GlucoseChip` ile renk körlüğüne duyarlı ölçüm geçmişi listesi.
  - `ReportsScreen` & `PdfReportService`:
    - `pdf` ve `printing` paketleri entegre edildi.
    - Hekim için kapsamlı PDF rapor oluşturucu:
      - Hasta diyabet tipi ve birim bilgisi.
      - Aktif ICR, ISF, Hedef glikoz, DIA ve doz adımı tablosu.
      - Time-in-Range yüzdesi ve ölçüm dağılımı.
      - Son 15 glikoz ölçümü ve uygulanan son 15 insülin dozu tablosu.
      - Yasal sorumluluk ve klinik inceleme uyarısı.
  - Test Sonuçları:
    - `pdf_report_test.dart` ile PDF byte üretimi başarıyla doğrulandı.
    - 15 mobil test %100 yeşil, `flutter analyze` 0 hata.

### [Faz 7] - Eğitim İçeriği, Acil Durum & Hatırlatıcılar
- **Tarih:** 2026-10-01
- **Yapılanlar:**
  - `EmergencyScreen` geliştirmeleri:
    - `url_launcher` ile doğrudan `tel:112` acil arama butonu entegrasyonu.
    - Kullanıcının kendi acil yakını/doktorunu tanımlayabilmesi (`SharedPreferences`) ve tek tıkla arayabilmesi.
    - Haptik geri bildirim (`HapticFeedback`) desteği (sayaç başlangıcı, sıfırlama, bitiş alarmı ve acil arama).
    - Bilinç kaybı ve koma durumunda hasta yakınları için Glukagon kiti ve kurtarma pozisyonu (koma pozisyonu) rehberi.
  - Eğitim Modülü (`apps/mobile/lib/features/education/`):
    - `EducationArticle` ve `EducationArticlesData` ile 8 temel klinik konuda kapsamlı Türkçe eğitim seti:
      - 15-15 Kuralı ile Hipoglisemi Yönetimi
      - Karbonhidrat Sayımı Temelleri & 15g Değişim
      - İnsülin Saklama ve Enjeksiyon Bölge Rotasyonu (Lipohipertrofiyi Önleme)
      - Hiperglisemi ve Keton Yönetimi (DKA Uyarısı)
      - Hasta Günleri Rehberi (Sick-Day Rules)
      - Egzersiz, İnsülin ve Hipoglisemi Koruması
      - Tabak Yöntemi (Plate Method) ile Sağlıklı Beslenme
      - Besin Etiketi Okuma ve Gizli Şekerler
    - Her makalede klinik onay yapılana kadar zorunlu "TASLAK – Klinik Gözden Geçirme Bekliyor" sarı uyarı kartı ve resmi kaynak rehberleri (TEMD, ADA, IDF, TÜBER).
    - `ArticleDetailScreen` ve `EducationScreen` arama filtresi.
  - Hatırlatıcılar Modülü (`apps/mobile/lib/features/reminders/`):
    - Riverpod modern `NotifierProvider` mimarisi (`ReminderNotifier`).
    - `SharedPreferences` tabanlı kalıcı saklama.
    - Sabah açlık ölçümü, gece bazal insülin ve yemekten 2 saat sonrasına tokluk şekeri kontrolü desteği.
    - `RemindersScreen` arayüzü ve `HomeScreen` hızlı erişim kartı.
  - Test Sonuçları:
    - `phase7_test.dart` ile 6 yeni test yazıldı.
    - Toplam 21 mobil test %100 yeşil.
    - `flutter analyze` 0 hata/uyarı (Flutter 3.47+ deprecation temiz).

### [Faz 8] - Supabase Senkronizasyon, KVKK & Güvenlik
- **Tarih:** 2026-10-01
- **Yapılanlar:**
  - `SecurityService`:
    - `flutter_secure_storage` ile hassas token ve biyometrik kilit durumunun güvenli saklanması.
    - `local_auth 3.x` API entegrasyonu: Biyometrik kimlik doğrulama (Parmak İzi / Yüz Tanıma) veya PIN/Desen kilit desteği.
    - `SettingsScreen` üzerinde Biyometrik Kilit açma/kapama seçeneği.
  - `DataExportService` (KVKK Madde 11 & GDPR Article 20 - Veri Taşınabilirliği):
    - Kullanıcının profilini, açık rıza loglarını, terapi ayar geçmişini, glikoz ölçümlerini ve append-only doz kütüklerini standart JSON formatında derleyen dışa aktarma servisi.
    - JSON görüntüleyici ve tek tıkla panoya kopyalama arayüzü.
  - `SyncService` (Çevrimdışı Öncelikli Supabase Senkronizasyonu):
    - Supabase bağlantı kontrolü.
    - Çevrimdışı modda yerel SQLite güvenliği ve internet geldiğinde `glucose_logs`, `meal_logs` ve salt ekleme `dose_logs` tablolarını bulutla eşitleyen kuyruk mimarisi.
  - Unutulma Hakkı & Kalıcı Veri Silme (`hardDeleteAllUserData`):
    - Tek tıkla yerel SQLite tablolarındaki tüm kişisel sağlık kayıtlarını (glikoz, doz, terapi ayarları, rıza) geri dönüşsüz olarak silme.
    - Çift onaylı modal diyalog ve güvenli depolama / önbellek temizliği sonrası Onboarding akışına yönlendirme.
  - Test Sonuçları:
    - `phase8_test.dart` ile 4 yeni test eklendi (JSON Export yapısı, Offline Sync davranışı, Hard Delete sıfırlama, SecurityService).
    - Toplam 25 mobil test %100 yeşil.
    - `flutter analyze` 0 hata.

### [Faz 9] - Sertleştirme, Doğrulama & APK Derleme/Yayınlama
- **Tarih:** 2026-10-01
- **Yapılanlar:**
  - Kalite & Sertleştirme:
    - `FoodRepository` için production modunda `const bool.fromEnvironment('dart.vm.product')` ile `is_sample: true` kayıtlarının filtrelenmesi sağlandı (Definition of Done gereksinimi).
    - AndroidManifest.xml üzerinde `GlikoRehber` adı, internet, biyometrik izinleri ve doğrudan telefon arama (`tel:`) intent'leri eklendi.
    - `CLINICAL_REVIEW_CHECKLIST.md` ve `docs/REGULATORY_NOTES.md` kontrol listeleri tamamlandı.
  - CI & Test Doğrulaması:
    - `scripts/ci.sh` çalıştırıldı: `packages/dose_engine` 27 testi ve `apps/mobile` 25 testi dahil olmak üzere toplam **52 testin tamamı %100 yeşil** geçti.
    - `flutter analyze` ve `dart analyze` sıfır hata ile tamamlandı.
  - Android APK Derleme:
    - Donanım ve Gradle bellek limitlerine tam riayet edildi:
      `org.gradle.jvmargs=-Xmx1280M -XX:MaxMetaspaceSize=512M -XX:ReservedCodeCacheSize=256m -XX:+UseG1GC`
    - CachyOS 8GB RAM hostunda OOM yaşanmadan `flutter build apk --release` başarıyla tamamlandı (66 MB release APK).
  - GitHub Dağıtımı & Release:
    - GitHub Release `v1.0.0` oluşturuldu: `https://github.com/abdulsamet-kasal/diyabet/releases/tag/v1.0.0`
    - Derlenen `app-release.apk` dosyası doğrudan release asset olarak yüklendi ve kullanıcının erişimine sunuldu.
