import 'enums.dart';
import 'therapy_settings.dart';
import 'dose_log_entry.dart';

/// Complete input payload required by the pure dose calculation engine.
class DoseInput {
  /// Total meal carbohydrates in grams (must be >= 0).
  final double totalCarbsG;

  /// Current blood glucose reading (optional).
  final double? currentGlucose;

  /// The unit of [currentGlucose] and target glucose (mg/dL or mmol/L).
  final GlucoseUnit glucoseUnit;

  /// Clinician prescribed therapy settings.
  final TherapySettings settings;

  /// Recent doses administered within the DIA window for IOB deduction.
  final List<DoseLogEntry> recentDoses;

  /// Current evaluation timestamp.
  final DateTime now;

  /// Lowest confidence level among foods in this meal.
  final DataConfidence minFoodConfidence;

  const DoseInput({
    required this.totalCarbsG,
    this.currentGlucose,
    this.glucoseUnit = GlucoseUnit.mgdl,
    required this.settings,
    this.recentDoses = const [],
    required this.now,
    this.minFoodConfidence = DataConfidence.officialVerified,
  });
}
