// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'GlikoRehber';

  @override
  String get disclaimerTitle => 'Medical Disclaimer';

  @override
  String get disclaimerText =>
      'GlikoRehber is only a calculation and tracking assistant. It does not provide medical advice. Always cross-check the suggested insulin dose with your physician or diabetes educator before injection.';

  @override
  String get acceptAndContinue => 'I Have Read, Understood, and Accept';

  @override
  String get home => 'Home';

  @override
  String get foods => 'Foods';

  @override
  String get plate => 'Meal Plate';

  @override
  String get doseCalculator => 'Calculate Dose';

  @override
  String get glucoseLog => 'Glucose Log';

  @override
  String get education => 'Education';

  @override
  String get emergency => 'Emergency (15-15)';

  @override
  String get settings => 'Settings';

  @override
  String get hypoAlert =>
      'WARNING: Hypoglycemia Risk! Dose calculation is blocked.';

  @override
  String get hypoRule15 =>
      'Follow the 15-15 Rule: Consume 15g fast-acting carbs and recheck blood glucose after 15 minutes.';
}
