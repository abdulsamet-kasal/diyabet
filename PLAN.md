# GlikoRehber — Uygulama Planı ve Mimari Tasarım (`PLAN.md`)

## 1. Mimari Genel Bakış
GlikoRehber; tip 1 ve tip 2 diyabet hastalarının karbonhidrat sayımı yapmasını ve hekimleri tarafından belirlenen oranlar doğrultusunda güvenli insülin dozu hesaplamasını sağlayan çevrimdışı öncelikli (offline-first) bir mobil sağlık asistanıdır.

### 1.1 Temel Katmanlar
1. **Doz Hesaplama Motoru (`packages/dose_engine`):**
   - Tamamen saf (pure) Dart paketi.
   - Flutter, ağ, dosya sistemi veya yapay zeka bağımlılığı içermez.
   - %100 test kapsamı, deterministik, değişmez matematiksel ve klinik kurallar.
2. **Mobil Uygulama (`apps/mobile`):**
   - Flutter 3.47+ / Dart 3.13+
   - Riverpod (NotifierProvider) ile durum yönetimi
   - GoRouter ile deklaratif yönlendirme
   - Drift (SQLite) ile yerel çevrimdışı veritabanı
   - Material 3 tasarım sistemi (renk tokenları, erişilebilirlik, WCAG AA)
3. **Backend & Senkronizasyon (`backend/supabase`):**
   - Supabase (PostgreSQL, Row Level Security, Edge Functions)
   - Salt ekleme (append-only) güvenli log tabloları (`dose_logs`, `consent_logs`)
4. **Veri İçe Aktarma & Denetim Araçları (`tools/import`):**
   - TürKomp, USDA, Open Food Facts veri doğrulama ve FTS entegrasyonu
   - Kalite kontrol algoritmaları ve karantina tablosu

---

## 2. Faz Listesi ve Kilometre Taşları

### Faz 0: Plan ve İskelet
- Dokümantasyon (`PLAN.md`, `ASSUMPTIONS.md`, `OPEN_QUESTIONS.md`, `DATA_SOURCES.md`, `CLINICAL_REVIEW_CHECKLIST.md`, `PRIVACY.md`, `REGULATORY_NOTES.md`).
- Flutter workspace ve paket yapısının kurulması (`apps/mobile`, `packages/dose_engine`).
- CachyOS / 8GB RAM uyumlu Gradle yapılandırması (`android/gradle.properties`).
- GitHub CI ve lint (`very_good_analysis`) konfigürasyonu.

### Faz 1: Doz Motoru (`packages/dose_engine`)
- Model tanımları: `DoseInput`, `TherapySettings`, `IcrBlock`, `GlucoseUnit`, `DoseResult`, `WarningType`.
- Algoritma adımları: Doğrulama, birim normalizasyonu, hipoglisemi bloğu (<70 mg/dL), öğün dozu, düzeltme dozu, IOB düşümü, yuvarlama (adımlı & ortada aşağı), maksimum tek doz kontrolü.
- Birim testleri: Şart koşulan 10 zorunlu vaka, property-based testler, IOB zaman testleri (%100 line coverage).

### Faz 2: Veri Katmanı
- Supabase SQL şemaları, migration'lar, RLS politikaları.
- Drift yerel veritabanı şeması ve FTS5 Türkçe arama desteği.
- Kalite kontrol doğrulama kuralları (karb, protein, yağ, kcal tutarlılığı, karantina).
- Çevrimdışı paketlenecek doğrulanmış örnek veri (`is_sample: true` / release ayrımı).

### Faz 3: Tasarım Sistemi, Onboarding & Terapi Ayarları
- Material 3 tema sistemi (açık/koyu tema, ColorScheme tokenları, durum renkleri).
- Erişilebilirlik: İkon + metin ikilisi, minimum 48dp dokunma hedefi, TalkBack desteği.
- Onboarding akışı: Sorumluluk reddi & rıza, yaş kontrolü (18+), diyabet tipi seçimi (4 profil).
- Terapi ayar sihirbazı: ICR saatlik dilimleri, ISF, hedef glikoz, DIA, doz adımı, hekim teyit onayı.

### Faz 4: Besin Modülü
- Çevrimdışı SQLite FTS5 Türkçe normalizasyonlu arama.
- Besin detay ekranı: 100g ve porsiyon çarpanları, GI/GL gösterimi, kaynak ve doğrulama rozeti.
- Barkod tarama ve manuel etiket girişi.
- Doğrulanmamış veri ("Paket etiketini kontrol ettim") onay mekanizması.

### Faz 5: Öğün Oluşturucu & Doz Ekranı
- Tabak / öğün toplamı: Besinleri toplama, porsiyon/gram düzenleme, karbonhidrat değişim birimi.
- Doz hesaplayıcı arayüzü: Güncel glikoz girişi, otomatik IOB hesaplama ve döküm.
- Doz sonuç kartı: Şeffaf formül adımları, hipoglisemi uyarısı, acil kart yönlendirmesi, "Uyguladım" kaydı.

### Faz 6: Glikoz Günlüğü & Doktor Raporu (PDF)
- Hızlı glikoz girişi (açlık, tokluk, egzersiz bağlamı).
- Trend grafikleri ve aralıkta kalma (Time-in-Range) analizi.
- PDF dışa aktarma: Doktor için ayarlar ve log dökümü.

### Faz 7: Eğitim, Acil Durum & Hatırlatıcılar
- 15-15 Kuralı ve hipoglisemi acil durum kartı (15 dk zamanlayıcı, 112 arama butonu).
- Eğitim kütüphanesi (taslak makaleler, klinik onay rozetleri).
- Yerel bildirimler ile ölçüm ve enjeksiyon hatırlatıcıları.

### Faz 8: Senkronizasyon, KVKK & Güvenlik
- Supabase auth entegrasyonu ve offline-first sync motoru.
- Biometrik kilit (`local_auth`) ve güvenli depolama (`flutter_secure_storage`).
- KVKK uyumlu hesap ve veri silme, JSON dışa aktarma.

### Faz 9: Sertleştirme, Doğrulama & APK Derleme
- `flutter analyze` ve tüm testlerin çalıştırılması.
- Release build derlemesi: `flutter build apk --release` (Gradle bellek limitleriyle).
- GitHub releases / repo'ya APK pushlanması.

---

## 3. Riskler ve Güvenlik Önlemleri
1. **OOM / Bellek Sıkışması:** 8GB RAM ve paylaşımlı GPU nedeniyle Gradle JVM 1.5GB ile sınırlandırılır. Gereksiz daemon'lar engellenir.
2. **Tıbbi Güvenlik Riski:** Doz hesaplamalarında varsayılan klinik değer kesinlikle verilmez; kullanıcı/hekim girişi zorunludur. Hipoglisemi anında doz önerisi kesinlikle bloke edilir.
3. **Veri Bütünlüğü:** `dose_logs` ve `consent_logs` tabloları Supabase ve yerel DB'de değiştirilemez (append-only) olacaktır.
