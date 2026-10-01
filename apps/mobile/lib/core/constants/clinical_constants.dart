/// Clinical constants and thresholds for GlikoRehber.
///
/// NOTE: Values must have clinical citation and review.
/// // TODO(KLİNİK-DOĞRULAMA)
library;

class ClinicalConstants {
  ClinicalConstants._();

  /// Severe hypoglycemia threshold in mg/dL (< 54 mg/dL / 3.0 mmol/L).
  /// Requires immediate emergency protocol and 112 assistance.
  static const double severeHypoglycemiaMgDl = 54.0;

  /// Hypoglycemia threshold in mg/dL (< 70 mg/dL / 3.9 mmol/L).
  /// Dose calculation is completely blocked. "15-15 Rule" is mandated.
  static const double hypoglycemiaThresholdMgDl = 70.0;

  /// Target glucose default range boundaries for display purposes only.
  /// User's personal target must be explicitly configured.
  static const double defaultTargetMinMgDl = 80.0;
  static const double defaultTargetMaxMgDl = 130.0;

  /// Hyperglycemia high warning threshold (> 250 mg/dL / 13.9 mmol/L).
  /// Mandates ketone check warning.
  static const double hyperglycemiaWarningMgDl = 250.0;

  /// Hyperglycemia critical warning threshold (> 300 mg/dL / 16.7 mmol/L).
  /// Strong warning + physician contact recommended.
  static const double hyperglycemiaCriticalMgDl = 300.0;

  /// Standard conversion factor: 1 mmol/L = 18.0182 mg/dL.
  static const double mmolLToMgDlFactor = 18.0182;

  /// Default carbohydrate exchange unit in Turkey (1 exchange = 15g carbs).
  static const double defaultCarbExchangeG = 15.0;

  /// 15-15 Rule: 15g fast-acting carbs, wait 15 minutes.
  static const int hypoCarbAmountG = 15;
  static const int hypoWaitTimeMinutes = 15;
}
