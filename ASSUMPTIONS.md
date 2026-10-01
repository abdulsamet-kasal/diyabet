# Güvenli ve Muhafazakâr Varsayımlar (`ASSUMPTIONS.md`)

Bu dosya, spesifikasyonda veya tıbbi uygulamada yoruma açık durumlarda benimsenen en güvenli, muhafazakâr varsayımları listeler.

1. **Varsayılan Değer Yokluğu:** Hiçbir kullanıcıya otomatik ICR, ISF veya hedef glikoz atanmaz. Değer girilmemişse doz motoru hesaplama yapmaz ve doğrudan eksik ayar uyarısı verir.
2. **Yuvarlama Kuralı:** Hesaplanan insülin dozu adımına (örn. 0.5 veya 1.0 U) yuvarlanırken, tam ortada kalan değerler (ör. 4.75 U'da 0.5 adımı için) daima **AŞAĞI** yuvarlanır (hipoglisemi riskini önlemek için).
3. **Negatif Düzeltme Kapalı:** Hedef glikozun altındaki tokluk glikozlarında negatif düzeltme (öğün dozundan insülin düşme) varsayılan olarak KAPALIDIR. Yalnızca kullanıcı açıkça açtığında ve hekim onayıyla devreye girer. Toplam doz hiçbir zaman 0'ın altına inemez.
4. **Aktif İnsülin (IOB) Düşümü:** Aktif insülin (IOB) yalnızca glikoz düzeltme dozundan düşülür. Öğün için gereken karbonhidrat karşılığı insülinden asla düşülmez.
5. **Hipoglisemi Eşiği:** 70 mg/dL altındaki tüm durumlarda doz hesaplayıcı kilitlenir. 54 mg/dL altında şiddetli hipoglisemi ve acil çağrı (112) uyarısı verilir.
6. **Yaş Sınırı:** 18 yaş altındaki kullanıcılarda doz motoru v1 sürümünde devre dışıdır (yalnızca bilgi modu).
7. **Birim Dönüşümü:** 1 mmol/L = 18.0182 mg/dL sabit dönüşüm faktörü kullanılır.
8. **Veri Doğrulama:** Resmi kaynaklardan gelmeyen veya kullanıcı tarafından girilen besin verileri `community_unverified` veya `user_entered` işaretlenir ve kullanıcıdan etiket teyidi istenir.
