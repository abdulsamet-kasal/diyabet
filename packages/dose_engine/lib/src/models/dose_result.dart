import 'enums.dart';

/// The immutable output produced by the dose calculation engine.
class DoseResult {
  /// Overall status of the calculation.
  final DoseStatus status;

  /// Final rounded insulin dose recommendation in units (U).
  /// Null if calculation is blocked or inputs/settings are invalid.
  final double? roundedUnits;

  /// Unrounded raw calculated units (U).
  final double? rawUnits;

  /// Meal component units (carbs / ICR).
  final double? mealUnits;

  /// Raw correction units before IOB deduction ((glucose - target) / ISF).
  final double? rawCorrectionUnits;

  /// Net correction units after IOB deduction.
  final double? correctionUnits;

  /// Units of active insulin (IOB) deducted from the correction component.
  final double iobDeducted;

  /// Total active insulin (IOB) present at calculation time.
  final double totalIob;

  /// Safety and clinical warnings triggered during evaluation.
  final List<DoseWarning> warnings;

  /// Human-readable step-by-step mathematical breakdown for complete UI transparency.
  final List<String> breakdown;

  /// Assumptions made during calculation.
  final List<String> assumptions;

  /// Whether the user must explicitly confirm package label data before proceeding.
  final bool requiresUserConfirmation;

  const DoseResult({
    required this.status,
    this.roundedUnits,
    this.rawUnits,
    this.mealUnits,
    this.rawCorrectionUnits,
    this.correctionUnits,
    this.iobDeducted = 0.0,
    this.totalIob = 0.0,
    this.warnings = const [],
    this.breakdown = const [],
    this.assumptions = const [],
    this.requiresUserConfirmation = false,
  });

  /// True if a valid dose recommendation was produced.
  bool get isSuccess => status == DoseStatus.success && roundedUnits != null;

  /// Optional U-100 syringe representation (1 mL = 100 U).
  /// Example: 5.5 U = 0.055 mL.
  double? get u100Milliliters =>
      roundedUnits != null ? roundedUnits! / 100.0 : null;

  /// Factory for missing or unconfigured therapy settings.
  factory DoseResult.missingSettings({
    required String reason,
    List<String> breakdown = const [],
  }) {
    return DoseResult(
      status: DoseStatus.missingSettings,
      breakdown: [
        'Eksik hekim ayarı: $reason',
        ...breakdown,
      ],
      warnings: const [],
    );
  }

  /// Factory for invalid or corrupt inputs (NaN, infinite, negative values).
  factory DoseResult.invalidInput({
    required String reason,
    List<String> breakdown = const [],
  }) {
    return DoseResult(
      status: DoseStatus.invalidInput,
      breakdown: [
        'Geçersiz girdi: $reason',
        ...breakdown,
      ],
      warnings: const [],
    );
  }

  /// Factory when dose is completely blocked due to hypoglycemia (< 70 mg/dL).
  factory DoseResult.blockedHypoglycemia({
    required double glucoseMgDl,
    required List<DoseWarning> warnings,
    required List<String> breakdown,
  }) {
    return DoseResult(
      status: DoseStatus.blockedHypoglycemia,
      warnings: warnings,
      breakdown: breakdown,
    );
  }

  /// Factory when dose exceeds max single dose limit.
  factory DoseResult.blockedMaxDoseExceeded({
    required double rawUnits,
    required double maxDose,
    required List<DoseWarning> warnings,
    required List<String> breakdown,
  }) {
    return DoseResult(
      status: DoseStatus.blockedMaxDoseExceeded,
      rawUnits: rawUnits,
      warnings: warnings,
      breakdown: breakdown,
    );
  }
}
