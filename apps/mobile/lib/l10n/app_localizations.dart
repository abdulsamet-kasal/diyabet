import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In tr, this message translates to:
  /// **'GlikoRehber'**
  String get appTitle;

  /// No description provided for @disclaimerTitle.
  ///
  /// In tr, this message translates to:
  /// **'Tıbbi Sorumluluk Reddi'**
  String get disclaimerTitle;

  /// No description provided for @disclaimerText.
  ///
  /// In tr, this message translates to:
  /// **'GlikoRehber yalnızca bir hesaplama ve takip asistanıdır. Kesinlikle tıbbi tavsiye vermez. Önerilen insülin dozunu uygulamadan önce mutlaka hekiminizin veya diyabet eğitim hemşirenizin talimatlarıyla karşılaştırınız.'**
  String get disclaimerText;

  /// No description provided for @acceptAndContinue.
  ///
  /// In tr, this message translates to:
  /// **'Okudum, Anladım ve Kabul Ediyorum'**
  String get acceptAndContinue;

  /// No description provided for @home.
  ///
  /// In tr, this message translates to:
  /// **'Ana Sayfa'**
  String get home;

  /// No description provided for @foods.
  ///
  /// In tr, this message translates to:
  /// **'Besinler'**
  String get foods;

  /// No description provided for @plate.
  ///
  /// In tr, this message translates to:
  /// **'Öğün Tabağı'**
  String get plate;

  /// No description provided for @doseCalculator.
  ///
  /// In tr, this message translates to:
  /// **'Doz Hesapla'**
  String get doseCalculator;

  /// No description provided for @glucoseLog.
  ///
  /// In tr, this message translates to:
  /// **'Glikoz Günlüğü'**
  String get glucoseLog;

  /// No description provided for @education.
  ///
  /// In tr, this message translates to:
  /// **'Eğitim'**
  String get education;

  /// No description provided for @emergency.
  ///
  /// In tr, this message translates to:
  /// **'Acil Durum (15-15)'**
  String get emergency;

  /// No description provided for @settings.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar'**
  String get settings;

  /// No description provided for @hypoAlert.
  ///
  /// In tr, this message translates to:
  /// **'DİKKAT: Hipoglisemi Riski! Doz hesaplanamaz.'**
  String get hypoAlert;

  /// No description provided for @hypoRule15.
  ///
  /// In tr, this message translates to:
  /// **'15-15 Kuralını uygulayınız: 15g hızlı etkili karbonhidrat alıp 15 dakika sonra kan şekerinizi yeniden ölçünüz.'**
  String get hypoRule15;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
