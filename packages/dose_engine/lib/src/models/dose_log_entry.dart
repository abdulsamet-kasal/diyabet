/// Represents a previously administered insulin dose used for Active Insulin (IOB) tracking.
class DoseLogEntry {
  /// The dose administered in units (U).
  final double units;

  /// The timestamp when the insulin was administered.
  final DateTime timestamp;

  /// The Duration of Insulin Action (DIA) in hours configured for this dose.
  final double diaHours;

  const DoseLogEntry({
    required this.units,
    required this.timestamp,
    required this.diaHours,
  });

  /// Calculates remaining active insulin (IOB) at [now] using linear decay.
  /// Formula: IOB = units * (1 - elapsedHours / diaHours)
  /// If elapsedHours >= diaHours or elapsedHours < 0, returns 0.0.
  double activeInsulinAt(DateTime now) {
    if (units <= 0 || diaHours <= 0) return 0.0;

    final elapsedMs = now.difference(timestamp).inMilliseconds;
    if (elapsedMs <= 0) {
      // Dose given at or in the future: fully active
      return units;
    }

    final elapsedHours = elapsedMs / (1000.0 * 60.0 * 60.0);
    if (elapsedHours >= diaHours) {
      return 0.0;
    }

    final fractionRemaining = 1.0 - (elapsedHours / diaHours);
    return units * fractionRemaining;
  }
}
