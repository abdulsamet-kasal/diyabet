// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'GlikoRehber';

  @override
  String get disclaimerTitle => 'Tıbbi Sorumluluk Reddi';

  @override
  String get disclaimerText =>
      'GlikoRehber yalnızca bir hesaplama ve takip asistanıdır. Kesinlikle tıbbi tavsiye vermez. Önerilen insülin dozunu uygulamadan önce mutlaka hekiminizin veya diyabet eğitim hemşirenizin talimatlarıyla karşılaştırınız.';

  @override
  String get acceptAndContinue => 'Okudum, Anladım ve Kabul Ediyorum';

  @override
  String get home => 'Ana Sayfa';

  @override
  String get foods => 'Besinler';

  @override
  String get plate => 'Öğün Tabağı';

  @override
  String get doseCalculator => 'Doz Hesapla';

  @override
  String get glucoseLog => 'Glikoz Günlüğü';

  @override
  String get education => 'Eğitim';

  @override
  String get emergency => 'Acil Durum (15-15)';

  @override
  String get settings => 'Ayarlar';

  @override
  String get hypoAlert => 'DİKKAT: Hipoglisemi Riski! Doz hesaplanamaz.';

  @override
  String get hypoRule15 =>
      '15-15 Kuralını uygulayınız: 15g hızlı etkili karbonhidrat alıp 15 dakika sonra kan şekerinizi yeniden ölçünüz.';
}
