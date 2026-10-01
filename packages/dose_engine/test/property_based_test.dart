import 'package:test/test.dart';
import 'package:dose_engine/dose_engine.dart';

void main() {
  group('Safety Invariants & Property-Based Checks', () {
    final now = DateTime(2026, 10, 1, 12, 0);

    test(
        'Invariant 1: Recommended dose is NEVER negative for any non-negative inputs',
        () {
      final settings = const TherapySettings(
        defaultIcr: 10.0,
        isf: 40.0,
        targetGlucose: 120.0,
        doseStep: 0.5,
        maxSingleDose: 20.0,
        allowNegativeCorrection: true,
      );

      // Test a wide range of carbs and blood sugars (above and below target, but >= 70 mg/dL)
      for (double carbs = 0.0; carbs <= 150.0; carbs += 15.0) {
        for (double bg = 70.0; bg <= 350.0; bg += 30.0) {
          final result = DoseCalculator.calculate(
            DoseInput(
              totalCarbsG: carbs,
              currentGlucose: bg,
              settings: settings,
              now: now,
            ),
          );

          if (result.roundedUnits != null) {
            expect(result.roundedUnits!, greaterThanOrEqualTo(0.0));
          }
          if (result.rawUnits != null) {
            expect(result.rawUnits!, greaterThanOrEqualTo(0.0));
          }
        }
      }
    });

    test('Invariant 2: Monotonicity - Increasing carbs never decreases dose',
        () {
      final settings = const TherapySettings(
        defaultIcr: 10.0,
        isf: 40.0,
        targetGlucose: 100.0,
        doseStep: 0.1,
        maxSingleDose: 30.0,
      );

      double previousDose = 0.0;
      for (double carbs = 0.0; carbs <= 100.0; carbs += 5.0) {
        final result = DoseCalculator.calculate(
          DoseInput(
            totalCarbsG: carbs,
            currentGlucose: 150.0,
            settings: settings,
            now: now,
          ),
        );

        if (result.isSuccess) {
          expect(result.roundedUnits!, greaterThanOrEqualTo(previousDose));
          previousDose = result.roundedUnits!;
        }
      }
    });

    test('Invariant 3: Symmetry of mmol/L and mg/dL conversion', () {
      const isfMgDl = 40.0;
      const targetMgDl = 100.0;
      const currentBgMgDl = 180.0;

      // Equivalent mmol/L values
      const factor = 18.0182;
      const isfMmol = isfMgDl / factor;
      const targetMmol = targetMgDl / factor;
      const currentBgMmol = currentBgMgDl / factor;

      final settingsMgDl = const TherapySettings(
        defaultIcr: 10.0,
        isf: isfMgDl,
        targetGlucose: targetMgDl,
        doseStep: 0.1,
        maxSingleDose: 15.0,
      );

      final settingsMmol = const TherapySettings(
        defaultIcr: 10.0,
        isf: isfMmol,
        targetGlucose: targetMmol,
        doseStep: 0.1,
        maxSingleDose: 15.0,
      );

      final resultMgDl = DoseCalculator.calculate(
        DoseInput(
          totalCarbsG: 50.0,
          currentGlucose: currentBgMgDl,
          glucoseUnit: GlucoseUnit.mgdl,
          settings: settingsMgDl,
          now: now,
        ),
      );

      final resultMmol = DoseCalculator.calculate(
        DoseInput(
          totalCarbsG: 50.0,
          currentGlucose: currentBgMmol,
          glucoseUnit: GlucoseUnit.mmoll,
          settings: settingsMmol,
          now: now,
        ),
      );

      expect(resultMgDl.roundedUnits, equals(resultMmol.roundedUnits));
      expect(
        (resultMgDl.rawUnits! - resultMmol.rawUnits!).abs(),
        lessThan(0.001),
      );
    });

    test('Invariant 4: Conservative half-down rounding edge cases', () {
      // Step 0.5: exactly at 4.75 -> 4.5
      expect(roundToDoseStepHalfDown(4.75, 0.5), 4.5);
      // Step 0.5: 4.74 -> 4.5
      expect(roundToDoseStepHalfDown(4.74, 0.5), 4.5);
      // Step 0.5: 4.76 -> 5.0
      expect(roundToDoseStepHalfDown(4.76, 0.5), 5.0);

      // Step 1.0: 3.5 -> 3.0
      expect(roundToDoseStepHalfDown(3.5, 1.0), 3.0);
      // Step 1.0: 3.49 -> 3.0
      expect(roundToDoseStepHalfDown(3.49, 1.0), 3.0);
      // Step 1.0: 3.51 -> 4.0
      expect(roundToDoseStepHalfDown(3.51, 1.0), 4.0);

      // Zero or negative
      expect(roundToDoseStepHalfDown(0.0, 0.5), 0.0);
      expect(roundToDoseStepHalfDown(-2.5, 0.5), 0.0);
    });
  });
}
