import '../models/dose_log_entry.dart';

/// Calculator for active insulin (Insulin on Board - IOB).
class IobCalculator {
  IobCalculator._();

  /// Calculates total remaining active insulin from a list of recent doses at [now].
  ///
  /// Uses linear decay:
  ///   remaining = dose * (1 - elapsedHours / DIA)
  /// If elapsedHours >= DIA, remaining = 0.
  static double calculateTotalIob({
    required List<DoseLogEntry> recentDoses,
    required DateTime now,
    double? fallbackDiaHours,
  }) {
    if (recentDoses.isEmpty) return 0.0;

    double totalIob = 0.0;
    for (final entry in recentDoses) {
      final dia =
          entry.diaHours > 0 ? entry.diaHours : (fallbackDiaHours ?? 0.0);
      if (dia <= 0) continue;

      final doseEntry = DoseLogEntry(
        units: entry.units,
        timestamp: entry.timestamp,
        diaHours: dia,
      );

      final active = doseEntry.activeInsulinAt(now);
      if (active > 0) {
        totalIob += active;
      }
    }

    return double.parse(totalIob.toStringAsFixed(4));
  }
}
