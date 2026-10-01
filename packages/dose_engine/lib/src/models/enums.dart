/// Enums used across the dose engine.
library;

/// Supported blood glucose units.
enum GlucoseUnit {
  mgdl,
  mmoll,
}

/// Food data verification status and confidence.
enum DataConfidence {
  officialVerified,
  labelVerified,
  communityUnverified,
  userEntered,
  sampleOnly,
}

/// Safety and clinical warning types generated during dose evaluation.
enum DoseWarning {
  /// Blood glucose is below 70 mg/dL (or 3.9 mmol/L). Dose is completely blocked.
  hypoglycemiaBlock,

  /// Blood glucose is below 54 mg/dL (or 3.0 mmol/L). Severe hypoglycemia!
  severeHypoglycemia,

  /// Blood glucose is above 250 mg/dL (or 13.9 mmol/L). Check ketones.
  hyperglycemiaHighKetoneAlert,

  /// Blood glucose is above 300 mg/dL (or 16.7 mmol/L). Critical high glucose!
  hyperglycemiaCriticalPhysicianAlert,

  /// Calculated raw dose exceeds the configured maximum single dose limit.
  maxSingleDoseExceeded,

  /// Meal contains unverified food data; explicit user verification required.
  unverifiedFoodDataInMeal,

  /// Negative correction was applied reducing meal dose.
  negativeCorrectionApplied,

  /// High fat or protein meal warning; insulin absorption may be delayed.
  highFatProteinAbsorptionDelay,
}

/// Status of the dose calculation outcome.
enum DoseStatus {
  success,
  blockedHypoglycemia,
  blockedMaxDoseExceeded,
  missingSettings,
  invalidInput,
}
