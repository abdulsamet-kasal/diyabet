/// Rounding utilities for conservative insulin dosing.
library;

/// Performs conservative half-down rounding to the specified [step].
///
/// Rules:
/// - Rounds to the nearest multiple of [step].
/// - If the value is exactly halfway between two steps, it rounds DOWN
///   to prevent hypoglycemia risk (e.g. with step 0.5: 4.75 -> 4.5).
/// - If value is <= 0, returns 0.0.
double roundToDoseStepHalfDown(double value, double step) {
  if (value <= 0.0 || step <= 0.0) return 0.0;

  // Normalize by step
  final quotient = value / step;
  final floorVal = quotient.floor();
  final remainder = quotient - floorVal;

  const epsilon = 1e-7;

  double stepsCount;
  if ((remainder - 0.5).abs() < epsilon) {
    // Exactly halfway: round DOWN
    stepsCount = floorVal.toDouble();
  } else if (remainder > 0.5) {
    stepsCount = (floorVal + 1).toDouble();
  } else {
    stepsCount = floorVal.toDouble();
  }

  // Multiply back and round to 4 decimal places to eliminate floating point artifacts
  final result = stepsCount * step;
  return double.parse(result.toStringAsFixed(4));
}
