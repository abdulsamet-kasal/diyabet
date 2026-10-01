/// Hourly block for time-dependent Insulin-to-Carbohydrate Ratio (ICR).
class IcrBlock {
  /// Start time in format "HH:mm" (24h, inclusive).
  final String from;

  /// End time in format "HH:mm" (24h, exclusive).
  final String to;

  /// Grams of carbohydrate covered by 1 unit of insulin (> 0).
  final double gPerUnit;

  const IcrBlock({
    required this.from,
    required this.to,
    required this.gPerUnit,
  });

  /// Checks if given [timeOfDay] (as "HH:mm") falls into this block.
  bool containsTime(int hour, int minute) {
    final currentMinutes = hour * 60 + minute;
    final fromParts = from.split(':');
    final toParts = to.split(':');
    if (fromParts.length != 2 || toParts.length != 2) return false;

    final fromMinutes = int.parse(fromParts[0]) * 60 + int.parse(fromParts[1]);
    final toMinutes = int.parse(toParts[0]) * 60 + int.parse(toParts[1]);

    if (fromMinutes <= toMinutes) {
      return currentMinutes >= fromMinutes && currentMinutes < toMinutes;
    } else {
      // Overnight block (e.g., 22:00 to 06:00)
      return currentMinutes >= fromMinutes || currentMinutes < toMinutes;
    }
  }
}

/// Clinician-prescribed therapy settings required for dose calculations.
class TherapySettings {
  /// Time-dependent ICR blocks.
  final List<IcrBlock> icrBlocks;

  /// Default ICR when no block matches, or when simple constant ICR is used (> 0).
  final double? defaultIcr;

  /// Insulin Sensitivity Factor (ISF): glucose drop per 1 unit of insulin (> 0).
  final double? isf;

  /// Target blood glucose (> 0).
  final double? targetGlucose;

  /// Duration of Insulin Action (DIA) in hours (e.g. 3.0 to 5.0 hours, > 0).
  final double? diaHours;

  /// Minimum dose increment supported by the user's pen/syringe (e.g., 0.1, 0.5, 1.0).
  final double doseStep;

  /// Maximum permitted single bolus dose (U).
  final double maxSingleDose;

  /// Whether negative correction is permitted when glucose is below target.
  /// DEFAULT: false (safety invariant).
  final bool allowNegativeCorrection;

  /// Whether fiber is subtracted from total carbohydrates.
  /// DEFAULT: false.
  final bool subtractFiber;

  /// Explicit clinician confirmation status.
  final bool confirmedWithClinician;

  const TherapySettings({
    this.icrBlocks = const [],
    this.defaultIcr,
    this.isf,
    this.targetGlucose,
    this.diaHours,
    required this.doseStep,
    required this.maxSingleDose,
    this.allowNegativeCorrection = false,
    this.subtractFiber = false,
    this.confirmedWithClinician = false,
  });

  /// Finds the effective ICR for a given [dateTime].
  /// Returns null if neither matching block nor default ICR exists.
  double? getIcrForTime(DateTime dateTime) {
    for (final block in icrBlocks) {
      if (block.containsTime(dateTime.hour, dateTime.minute)) {
        return block.gPerUnit;
      }
    }
    return defaultIcr;
  }

  /// Validates whether all mandatory fields for meal calculation are set.
  bool hasValidMealSettings(DateTime dateTime) {
    final icr = getIcrForTime(dateTime);
    return icr != null && icr > 0 && doseStep > 0 && maxSingleDose > 0;
  }

  /// Validates whether correction settings are set.
  bool hasValidCorrectionSettings() {
    return isf != null &&
        isf! > 0 &&
        targetGlucose != null &&
        targetGlucose! > 0;
  }
}
