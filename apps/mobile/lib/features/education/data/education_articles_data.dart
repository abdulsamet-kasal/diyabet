import '../domain/education_article.dart';

class EducationArticlesData {
  static final List<EducationArticle> articles = [
    const EducationArticle(
      id: 'edu-1',
      slug: 'hipoglisemi-15-15',
      titleTr: '15-15 Kuralı ile Hipoglisemi Yönetimi',
      summaryTr: 'Kan şekeri 70 mg/dL altına düştüğünde izlenmesi gereken hayat kurtarıcı acil müdahale protokolü.',
      contentMarkdown: '''
### Hipoglisemi Nedir?
Diyabetli bir bireyde kan glikoz düzeyinin **70 mg/dL** (3.9 mmol/L) veya altına inmesi durumu hipoglisemi olarak adlandırılır. 54 mg/dL altı ise klinik olarak ciddi hipoglisemi kabul edilir.

### Belirtiler
* Titreme, soğuk terleme, çarpıntı
* Ani açlık hissi, baş dönmesi, dudaklarda karıncalanma
* Dikkat dağınıklığı, sinirlilik, görmede bulanıklık

### 15-15 Kuralı Adımları
1. **15 Gram Hızlı Etkili Şeker Tüketin:**
   - 4-5 adet küp şeker (veya 1 bardak suda eritilmiş)
   - 150 ml (1 çay bardağı) meyve suyu
   - 1 tüp hazır glukoz jeli
   - *Önemli:* Çikolata, gofret veya yağlı tatlılar TERCİH EDİLMEMELİDİR. Yağ, şekerin kana karışmasını geciktirir!
2. **15 Dakika Dinlenin ve Bekleyin:**
   - Fiziksel hareketi derhal durdurun, sakin bir yere oturun veya uzanın.
3. **15 Dakika Sonra Şekerinizi Tekrar Ölçün:**
   - Glikoz hala < 70 mg/dL ise adımları bir kez daha tekrarlayın.
   - Şekeriniz 70 mg/dL üzerine çıktıysa ve bir sonraki öğününüze 1 saatten fazla varsa, kompleks karbonhidrat içeren küçük bir ara öğün (ör. 1 dilim kepekli ekmek veya süt) tüketin.

### Ciddi Hipoglisemi ve Bilinç Kaybı
Hasta yutamıyorsa veya bilinci kapalıysa **AĞIZDAN KESİNLİKLE HİÇBİR ŞEY VERİLMEMELİDİR!**
Boğulma riski vardır. Hastayı derhal yan çevirin (koma pozisyonu) ve **112 Acil Yardım** çağırın ya da hekiminizin reçete ettiği Glukagon enjeksiyonunu uygulayın.
''',
      reviewedBy: null,
      reviewedAt: null,
      sources: [
        'Türkiye Endokrinoloji ve Metabolizma Derneği (TEMD) Diyabet Tedavi Kılavuzu',
        'American Diabetes Association (ADA) Standards of Care in Diabetes',
        'International Diabetes Federation (IDF) Clinical Guidelines',
      ],
    ),
    const EducationArticle(
      id: 'edu-2',
      slug: 'karbonhidrat-sayimi-temelleri',
      titleTr: 'Karbonhidrat Sayımı Temelleri & 15g Değişim',
      summaryTr: 'Yiyeceklerdeki karbonhidratı gram cinsinden hesaplama ve Türkiye 15g değişim birimi mantığı.',
      contentMarkdown: '''
### Karbonhidrat Sayımı Neden Önemlidir?
Yediğimiz besinler arasında kan şekerini doğrudan ve en hızlı yükselten temel makro besin karbonhidrattır. Tüketilen karbonhidrat miktarını doğru hesaplamak, doğru miktarda yemek öncesi bolus insülin yapmanın ilk şartıdır.

### Karbonhidrat İçeren Temel Besin Grupları
* **Tahıllar:** Ekmek, pirinç, bulgur, makarna, börek
* **Kuru Baklagiller:** Mercimek, nohut, kuru fasulye
* **Meyveler:** Taze meyveler, kuru meyveler, meyve suları
* **Süt ve Yoğurt:** İçerdikleri laktoz nedeniyle karbonhidrat sayılır (1 bardak süt ~ 10-12g karb)
* **Şeker ve Tatlılar:** Doğrudan basit karbonhidrat

### Türkiye Standardı: 15 Gram Değişim Birimi
Türkiye'de diyetisyenler ve hekimler sıklıkla **1 Karbonhidrat Değişimi = 15 Gram Karbonhidrat** kuralını kullanır.
* 1 ince dilim ekmek (25g) = 15g karb = 1 değişim
* 1 küçük boy elma (~100g) = 15g karb = 1 değişim
* 3 yemek kaşığı pişmiş makarna veya bulgur = 15g karb = 1 değişim

### İnsülin/Karbonhidrat Oranı (ICR)
Hekiminizin belirlediği ICR (örneğin 1:10), yediğiniz her 10 gram karbonhidrat için 1 ünite hızlı etkili insülin yapmanız gerektiğini belirtir. 60 gram karbonhidrat tüketecekseniz:
`60 / 10 = 6 Ünite İnsülin`
''',
      reviewedBy: null,
      reviewedAt: null,
      sources: [
        'Türkiye Diyabet Vakfı Karbonhidrat Sayım Kitapçığı',
        'TEMD Diyabet Diyetisyenliği Çalışma Grubu Kılavuzu',
      ],
    ),
    const EducationArticle(
      id: 'edu-3',
      slug: 'insulin-enjeksiyon-rotasyonu',
      titleTr: 'İnsülin Saklama ve Enjeksiyon Bölge Rotasyonu',
      summaryTr: 'Lipohipertrofiyi (yağ bezesi) önleme teknikleri, iğne ucu kullanımı ve insülin stabilitesi.',
      contentMarkdown: '''
### Lipohipertrofi Nedir ve Neden Önlenmelidir?
İnsülinin sürekli aynı noktaya yapılması deri altında yağ dokusu büyümesine (lipohipertrofi / doku sertleşmesi) yol açar. Bu sert dokulara yapılan insülin emilmez veya çok düzensiz emilir; bu da açıklanamayan ani hipoglisemilere ve hiperglisemilere yol açar.

### Enjeksiyon Bölgeleri ve Emilim Hızları
1. **Karın (Göbek çevresi):** En hızlı emilim bölgesidir. Yemek bolusları için sıklıkla tercih edilir. Göbek deliğinin en az 2 parmak uzağı kullanılmalıdır.
2. **Kolların Dış Yüzü:** Orta hızda emilim.
3. **Uyluk (Bacak ön-dış yüzü):** Yavaş emilim. Bazal (uzun etkili) insülinler için uygundur.
4. **Kalça (Üst dış kadran):** En yavaş emilim.

### Rotasyon Kuralı
* Her enjeksiyon bir önceki noktadan en az **1 parmak (yaklaşık 1-2 cm)** uzağa yapılmalıdır.
* Aynı bölge içinde düzenli bir yön (saat yönünde) takip edilmelidir.
* Sertlik, morarma veya şişlik olan bölgeye doku tamamen iyileşene kadar enjeksiyon yapılmamalıdır.

### Saklama Koşulları
* **Açılmamış insülinler:** Buzdolabında +2°C ile +8°C arasında saklanmalı, asla dondurulmamalıdır.
* **Kullanımdaki insülin kalemi:** Oda sıcaklığında (25°C altında) doğrudan güneş ışığından uzak olarak 28-30 gün saklanabilir. Soğuk insülin enjekte edildiğinde ağrı yapabilir.
* **İğne Uçları:** Her enjeksiyonda YENİ iğne ucu takılmalıdır. İğne ucu tekrar kullanıldığında mikro düzeyde bükülerek dokuya zarar verir.
''',
      reviewedBy: null,
      reviewedAt: null,
      sources: [
        'Forum for Injection Technique and Therapy Expert Recommendations (FITTER)',
        'TEMD Diyabet İnsülin Uygulama Rehberi',
      ],
    ),
    const EducationArticle(
      id: 'edu-4',
      slug: 'hiperglisemi-ve-keton',
      titleTr: 'Hiperglisemi ve Keton Yönetimi',
      summaryTr: 'Yüksek kan şekeri durumunda düzeltme dozu, hidrasyon ve Diyabetik Ketoasidoz (DKA) riskleri.',
      contentMarkdown: '''
### Hiperglisemi Nedir?
Açlık kan glikozunun 130 mg/dL veya tokluk kan glikozunun 180 mg/dL üzerinde seyretmesi hiperglisemi olarak tanımlanır.

### Glikoz > 250 mg/dL İse Ne Yapılmalı?
* **1. Keton Kontrolü:** İdrar veya kan keton çubuğu ile keton bakın. Keton pozitifse veya hasta mide bulantısı/kusma yaşıyorsa derhal hekiminize danışın veya acil servise başvurun.
* **2. Bol Su İçin:** Vücudun fazla şekeri idrarla atabilmesi için saatte en az 1-2 bardak su tüketin.
* **3. İnsülin Düzeltme Dozu:** Yalnızca doktorunuzun belirlediği İnsülin Duyarlılık Faktörü (ISF) doğrultusunda düzeltme dozu uygulayın.
* **4. İnsülin Birikmesini (Insulin Stacking) Önleyin:** İki düzeltme dozu arasında Aktif İnsülin Süreniz (DIA, genelde 3-4 saat) kadar süre geçmiş olmalıdır.

### Acil Durum: DKA (Diyabetik Ketoasidoz) Belirtileri
* Ağızda aseton / meyvemsi koku
* Derin ve hızlı solunum (Kussmaul solunumu)
* Şiddetli karın ağrısı, bulantı, inatçı kusma
* Şiddetli halsizlik ve dalgınlık
*Bu belirtiler varsa VAKİT KAYBETMEDEN EN YAKIN HASTANENİN ACİL SERVİSİNE GİDİLMELİDİR.*
''',
      reviewedBy: null,
      reviewedAt: null,
      sources: [
        'ADA Standards of Care: Diabetes Emergencies',
        'TEMD Diyabet Tanı ve Tedavi Rehberi',
      ],
    ),
    const EducationArticle(
      id: 'edu-5',
      slug: 'hasta-gunleri-yonetimi',
      titleTr: 'Hasta Günleri Rehberi (Sick-Day Management)',
      summaryTr: 'Ateş, grip veya enfeksiyon anında insülin ihtiyacı, dehidratasyon ve beslenme kuralları.',
      contentMarkdown: '''
### Hastalık Döneminde Neden Şeker Yükselir?
Grip, boğaz enfeksiyonu, gastroenterit veya idrar yolu enfeksiyonu gibi durumlarda vücut stres hormonları (kortizol, adrenalin) salgılar. Bu hormonlar karaciğerden glikoz salınımını artırır ve insülin direncine yol açar. Bu nedenle yemek yenmese dahi kan şekeri yükselebilir!

### Altın Kurallar
1. **İnsülininizi Kesinlikle Bırakmayın:** Yemek yiyemeseniz bile bazal (uzun etkili) insülininizi mutlaka yapın.
2. **Sık Sık Ölçüm Yapın:** Normal günlerden farklı olarak kan şekerinizi her 2-4 saatte bir kontrol edin.
3. **Bol Sıvı Tüketin:** Her saat başı en az bir bardak su, açık çay, tuzlu ayran veya et suyu gibi sıvılar alın.
4. **Keton Takibi Yapın:** Tip 1 diyabetli bireyler şeker 240 mg/dL'yi aştığında her 4 saatte bir idrarda veya kanda keton bakmalıdır.
5. **Doktorunuza Haber Verin:** Kan şekeri 24 saat içinde normale dönmüyorsa, 2 defadan fazla kusma olduysa veya keton pozitifse hekiminizi arayın.
''',
      reviewedBy: null,
      reviewedAt: null,
      sources: [
        'International Society for Pediatric and Adolescent Diabetes (ISPAD) Sick Day Management',
        'TEMD Diyabet Kılavuzu',
      ],
    ),
    const EducationArticle(
      id: 'edu-6',
      slug: 'egzersiz-ve-diyabet',
      titleTr: 'Egzersiz, İnsülin ve Hipoglisemi Koruması',
      summaryTr: 'Spor yaparken kan şekeri dalgalanmalarını önleme ve egzersiz öncesi glikoz hedefleri.',
      contentMarkdown: '''
### Egzersizin Kan Şekerine Etkisi
* **Aerobik Egzersizler (Yürüyüş, bisiklet, yüzme, koşu):** İnsülin duyarlılığını artırarak kan şekerini düşürme eğilimindedir. Egzersiz sırasında ve sonrasındaki 24 saate kadar hipoglisemi riski devam edebilir.
* **Anaerobik Egzersizler (Ağırlık kaldırma, sprint):** Adrenalin salgısı nedeniyle egzersiz anında kan şekerini geçici olarak yükseltebilir, ardından düşüş yaşanabilir.

### Güvenli Egzersiz Kuralları
* **Egzersiz Öncesi Ölçüm:**
  - Kan şekeri < 100 mg/dL ise egzersize başlamadan önce 15-20g ek karbonhidrat tüketin.
  - Kan şekeri 100-250 mg/dL ise egzersiz için güvenli aralıktır.
  - Kan şekeri > 250 mg/dL ve kanda keton varsa EGZERSİZ YAPMAYIN (keton üretimi hızlanır).
* **Aktif İnsülin Zirvesi:** Bolus insülinin en güçlü çalıştığı ilk 1-2 saatte yoğun egzersiz yapmaktan kaçının.
* **Yanınızda Her Zaman Hızlı Şeker Bulundurun:** Ceplerinizde veya çantanızda her zaman meyve suyu veya glukoz jeli olsun.
''',
      reviewedBy: null,
      reviewedAt: null,
      sources: [
        'ADA Physical Activity/Exercise and Diabetes Position Statement',
        'TEMD Egzersiz Rehberi',
      ],
    ),
    const EducationArticle(
      id: 'edu-7',
      slug: 'tabak-modeli-beslenme',
      titleTr: 'Tabak Yöntemi (Plate Method) ile Sağlıklı Beslenme',
      summaryTr: 'Porsiyon kontrolünü terazi olmadan görsel olarak kolaylaştıran sağlıklı tabak modeli.',
      contentMarkdown: '''
### Tabak Yöntemi Nedir?
Standart bir yemek tabağını (yaklaşık 22 cm çapında) göz kararı bölerek glisemik dengeyi sağlayan basit ve pratik bir beslenme yöntemidir.

### Tabağın Bölümleri
1. **Tabağın Yarısı (1/2): Nişastasız Sebzeler ve Yeşillikler**
   - Domates, salatalık, marul, ıspanak, brokoli, kabak, patlıcan, biber, lahana.
   - Yüksek lif ve su içeriği sayesinde tokluk hissi sağlar ve glikoz emilimini yavaşlatır.
2. **Tabağın Dörtte Biri (1/4): Yağsız Proteinler**
   - Izgara tavuk, hindi, balık, yumurta, yağsız kırmızı et, peynir, tofu.
   - Kan şekerini doğrudan yükseltmez, kas dokusunu korur.
3. **Tabağın Dörtte Biri (1/4): Karbonhidratlar / Tam Tahıllar**
   - Bulgur, tam buğday makarna, esmer pirinç, haşlanmış mercimek veya 1 dilim ekmek.
   - Sayılan ve insülini hesaplanan kısım burasıdır.
4. **Yanında:**
   - 1 kase yoğurt / 1 bardak ayran ve 1 porsiyon taze meyve.
''',
      reviewedBy: null,
      reviewedAt: null,
      sources: [
        'Türkiye Beslenme Rehberi (TÜBER)',
        'American Diabetes Association Create Your Plate Method',
      ],
    ),
    const EducationArticle(
      id: 'edu-8',
      slug: 'etiket-okuma-gizli-seker',
      titleTr: 'Besin Etiketi Okuma ve Gizli Şekerleri Tespit Etme',
      summaryTr: 'Paketli gıda etiketlerinde toplam karbonhidrat, şeker, lif analizi ve polioller.',
      contentMarkdown: '''
### Paket Etiketinde Neye Bakılmalı?
* **Önce Porsiyon Büyüklüğüne Bakın:** Etiketteki değerler genellikle 100 gram veya 1 porsiyon için verilir. Paketin tamamını tüketiyorsanız paket gramajı ile çarpmayı unutmayın.
* **Toplam Karbonhidrat:** İnsülin hesabında dikkate alınması gereken temel değer "Toplam Karbonhidrat"tır; yalnızca "Şekerler" satırına bakmak büyük bir hatadır! Nişasta da vücutta glikoza dönüşür.
* **Lif (Posa):** Yüksek lifli gıdalar kan şekerinin daha yavaş yükselmesini sağlar. Eğer hekiminiz önerdiyse, porsiyonda 5 gramdan fazla lif varsa toplam karbonhidrattan düşülebilir.

### İçindekiler Listesindeki Gizli Şeker İsimleri
Bir ürünün üzerinde "Şeker İlavesiz" yazsa bile içindekiler listesinde şu isimlerle şeker bulunabilir:
* Maltoz, dekstroz, fruktoz, sukroz, glikoz şurubu
* Yüksek fruktozlu mısır şurubu (HFCS)
* İnvert şeker, pekmez, malt özü, bal, agave şurubu

### Şeker Alkolleri (Polioller - Maltitol, Sorbitol vb.)
"Diyabetik" olarak satılan bazı ürünlerde şeker alkolleri kullanılır. Bunlar kan şekerini şekere göre daha az yükseltse de sıfır değildir ve sindirim sisteminde gaz ve ishale neden olabilir.
''',
      reviewedBy: null,
      reviewedAt: null,
      sources: [
        'Türk Gıda Kodeksi Etiketleme Yönetmeliği',
        'TEMD Diyabetli Bireyler İçin Besin Etiketi Okuma Kılavuzu',
      ],
    ),
  ];
}
