# Değişiklik Günlüğü (`CHANGELOG.md`)

Tüm önemli değişiklikler bu dosyada kronolojik olarak listelenir.

## [v0.1.0] - 2026-10-01
### Eklendi
- Faz 0: Mimari plan (`PLAN.md`), varsayımlar (`ASSUMPTIONS.md`), açık sorular (`OPEN_QUESTIONS.md`) oluşturuldu.
- Git deposu ve GitHub entegrasyonu sağlandı (`abdulsamet-kasal/diyabet`).
- CachyOS 8GB RAM ve Gradle JVM sınırları (`android/gradle.properties`) tanımlandı.
- Faz 1: `packages/dose_engine` saf Dart paketi ve 27 klinik test tamamlandı.
- Hipoglisemi bloğu (< 70 mg/dL), muhafazakâr ortada aşağı yuvarlama, IOB düzeltme düşümü, üst sınır koruması uygulandı.
- Faz 2: Supabase şeması, salt ekleme (append-only) RLS politikaları, Edge Function barkod proxy ve Python besin kalite kontrol script'leri hazırlandı.
- Mobil çevrimdışı Drift SQLite veritabanı, Türkçe normalizasyonlu gıda arama ve repository katmanı entegre edildi.
- Faz 3: WCAG AA erişilebilir bileşenler (GlucoseChip, CarbBadge, VerificationBadge, WarningBanner, NumericField, DoseResultCard), modern Riverpod NotifierProvider durum yönetimi, Stepper Onboarding ve Terapi Ayar sihirbazı tamamlandı.
- Faz 4: Besin modülü (canlı SQLite FTS arama, detay ekranı, GI/GL çarpanları, etiket ekleme sihirbazı ve barkod akışı) tamamlandı.
