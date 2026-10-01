import 'package:test/test.dart';
import 'package:dose_engine/dose_engine.dart';

void main() {
  group('Section 4.3 - Mandatory Clinical Test Cases', () {
    final now = DateTime(2026, 10, 1, 12, 0);

    test('Case 1: Standard meal dose (45g carbs, ICR 10, no glucose -> 4.5 U)',
        () {
      final settings = const TherapySettings(
        defaultIcr: 10.0,
        doseStep: 0.5,
        maxSingleDose: 15.0,
      );

      final input = DoseInput(
        totalCarbsG: 45.0,
        settings: settings,
        now: now,
      );

      final result = DoseCalculator.calculate(input);

      expect(result.status, DoseStatus.success);
      expect(result.roundedUnits, 4.5);
      expect(result.mealUnits, 4.5);
      expect(result.correctionUnits, 0.0);
      expect(result.warnings, isEmpty);
    });

    test(
        'Case 2: Meal + Correction with IOB deduction (45g carbs, ICR 10, bg 180, target 100, ISF 40, IOB 1.0 -> 5.5 U)',
        () {
      final settings = const TherapySettings(
        defaultIcr: 10.0,
        isf: 40.0,
        targetGlucose: 100.0,
        diaHours: 4.0,
        doseStep: 0.5,
        maxSingleDose: 15.0,
      );

      // Dose of 2.0 U given 2 hours ago with 4h DIA -> remaining IOB = 2.0 * (1 - 2/4) = 1.0 U
      final recentDoses = [
        DoseLogEntry(
          units: 2.0,
          timestamp: now.subtract(const Duration(hours: 2)),
          diaHours: 4.0,
        ),
      ];

      final input = DoseInput(
        totalCarbsG: 45.0,
        currentGlucose: 180.0,
        settings: settings,
        recentDoses: recentDoses,
        now: now,
      );

      final result = DoseCalculator.calculate(input);

      expect(result.status, DoseStatus.success);
      expect(result.mealUnits, 4.5);
      expect(result.rawCorrectionUnits, 2.0); // (180 - 100) / 40 = 2.0
      expect(result.iobDeducted, 1.0);
      expect(result.correctionUnits, 1.0); // 2.0 - 1.0 = 1.0
      expect(result.roundedUnits, 5.5); // 4.5 + 1.0 = 5.5
    });

    test(
        'Case 3: Below target with negative correction disabled (30g, ICR 12, bg 90, target 100 -> 2.5 U)',
        () {
      final settings = const TherapySettings(
        defaultIcr: 12.0,
        isf: 40.0,
        targetGlucose: 100.0,
        diaHours: 4.0,
        doseStep: 0.5,
        maxSingleDose: 15.0,
        allowNegativeCorrection: false,
      );

      final input = DoseInput(
        totalCarbsG: 30.0,
        currentGlucose: 90.0,
        settings: settings,
        now: now,
      );

      final result = DoseCalculator.calculate(input);

      expect(result.status, DoseStatus.success);
      expect(result.mealUnits, 2.5); // 30 / 12 = 2.5
      expect(result.rawCorrectionUnits, -0.25); // (90 - 100) / 40 = -0.25
      expect(result.correctionUnits, 0.0); // Negative correction blocked
      expect(result.roundedUnits, 2.5);
    });

    test(
        'Case 4: Conservative half-down rounding (47.5g, ICR 10 -> raw 4.75 -> 4.5 U with step 0.5)',
        () {
      final settings = const TherapySettings(
        defaultIcr: 10.0,
        doseStep: 0.5,
        maxSingleDose: 15.0,
      );

      final input = DoseInput(
        totalCarbsG: 47.5,
        settings: settings,
        now: now,
      );

      final result = DoseCalculator.calculate(input);

      expect(result.status, DoseStatus.success);
      expect(result.rawUnits, 4.75);
      expect(result.roundedUnits, 4.5); // Half-down to 4.5 U
    });

    test(
        'Case 5: Hypoglycemia block (< 70 mg/dL: 60g, ICR 10, bg 65 -> BLOCK: no dose)',
        () {
      final settings = const TherapySettings(
        defaultIcr: 10.0,
        isf: 40.0,
        targetGlucose: 100.0,
        doseStep: 0.5,
        maxSingleDose: 15.0,
      );

      final input = DoseInput(
        totalCarbsG: 60.0,
        currentGlucose: 65.0,
        settings: settings,
        now: now,
      );

      final result = DoseCalculator.calculate(input);

      expect(result.status, DoseStatus.blockedHypoglycemia);
      expect(result.roundedUnits, isNull);
      expect(result.warnings, contains(DoseWarning.hypoglycemiaBlock));
      expect(result.warnings, isNot(contains(DoseWarning.severeHypoglycemia)));
    });

    test(
        'Case 5b: Severe hypoglycemia block (< 54 mg/dL -> SEVERE alert + BLOCK)',
        () {
      final settings = const TherapySettings(
        defaultIcr: 10.0,
        isf: 40.0,
        targetGlucose: 100.0,
        doseStep: 0.5,
        maxSingleDose: 15.0,
      );

      final input = DoseInput(
        totalCarbsG: 60.0,
        currentGlucose: 50.0,
        settings: settings,
        now: now,
      );

      final result = DoseCalculator.calculate(input);

      expect(result.status, DoseStatus.blockedHypoglycemia);
      expect(result.roundedUnits, isNull);
      expect(result.warnings, contains(DoseWarning.severeHypoglycemia));
      expect(result.warnings, contains(DoseWarning.hypoglycemiaBlock));
    });

    test(
        'Case 6: Pure correction dose (0g carbs, bg 200, target 100, ISF 50, step 1.0 -> 2 U)',
        () {
      final settings = const TherapySettings(
        defaultIcr: 10.0,
        isf: 50.0,
        targetGlucose: 100.0,
        doseStep: 1.0,
        maxSingleDose: 15.0,
      );

      final input = DoseInput(
        totalCarbsG: 0.0,
        currentGlucose: 200.0,
        settings: settings,
        now: now,
      );

      final result = DoseCalculator.calculate(input);

      expect(result.status, DoseStatus.success);
      expect(result.mealUnits, 0.0);
      expect(result.rawCorrectionUnits, 2.0);
      expect(result.correctionUnits, 2.0);
      expect(result.roundedUnits, 2.0);
    });

    test(
        'Case 7: Maximum single dose limit exceeded (120g, ICR 8 -> raw 15 > max 12 -> BLOCK)',
        () {
      final settings = const TherapySettings(
        defaultIcr: 8.0,
        doseStep: 1.0,
        maxSingleDose: 12.0,
      );

      final input = DoseInput(
        totalCarbsG: 120.0,
        settings: settings,
        now: now,
      );

      final result = DoseCalculator.calculate(input);

      expect(result.status, DoseStatus.blockedMaxDoseExceeded);
      expect(result.rawUnits, 15.0);
      expect(result.roundedUnits, isNull);
      expect(result.warnings, contains(DoseWarning.maxSingleDoseExceeded));
    });

    test(
        'Case 8: mmol/L unit conversion (45g, ICR 10, bg 10.0 mmol/L, target 5.5, ISF 2.2 -> 6.5 U)',
        () {
      final settings = const TherapySettings(
        defaultIcr: 10.0,
        isf: 2.2, // mmol/L per U
        targetGlucose: 5.5, // mmol/L
        doseStep: 0.5,
        maxSingleDose: 15.0,
      );

      final input = DoseInput(
        totalCarbsG: 45.0,
        currentGlucose: 10.0,
        glucoseUnit: GlucoseUnit.mmoll,
        settings: settings,
        now: now,
      );

      final result = DoseCalculator.calculate(input);

      expect(result.status, DoseStatus.success);
      expect(result.mealUnits, 4.5);
      // Correction = (10.0 - 5.5) / 2.2 = 4.5 / 2.2 = 2.04545 U
      // Total = 4.5 + 2.04545 = 6.54545 U -> round to 0.5 step -> 6.5 U
      expect(result.roundedUnits, 6.5);
    });

    test(
        'Case 9: High glucose warnings (45g, ICR 10, bg 300, target 100, ISF 40, step 0.5 -> 9.5 U + Ketone & Critical Warnings)',
        () {
      final settings = const TherapySettings(
        defaultIcr: 10.0,
        isf: 40.0,
        targetGlucose: 100.0,
        doseStep: 0.5,
        maxSingleDose: 15.0,
      );

      final input = DoseInput(
        totalCarbsG: 45.0,
        currentGlucose: 300.0,
        settings: settings,
        now: now,
      );

      final result = DoseCalculator.calculate(input);

      expect(result.status, DoseStatus.success);
      expect(result.mealUnits, 4.5);
      expect(result.rawCorrectionUnits, 5.0); // (300 - 100) / 40 = 5.0
      expect(result.roundedUnits, 9.5); // 4.5 + 5.0 = 9.5
      expect(result.warnings,
          contains(DoseWarning.hyperglycemiaCriticalPhysicianAlert));
      expect(
          result.warnings, contains(DoseWarning.hyperglycemiaHighKetoneAlert));
    });

    test(
        'Case 9b: High glucose warning 250-299 mg/dL triggers ketone alert only',
        () {
      final settings = const TherapySettings(
        defaultIcr: 10.0,
        isf: 40.0,
        targetGlucose: 100.0,
        doseStep: 0.5,
        maxSingleDose: 15.0,
      );

      final input = DoseInput(
        totalCarbsG: 45.0,
        currentGlucose: 260.0,
        settings: settings,
        now: now,
      );

      final result = DoseCalculator.calculate(input);

      expect(result.status, DoseStatus.success);
      expect(
          result.warnings, contains(DoseWarning.hyperglycemiaHighKetoneAlert));
      expect(result.warnings,
          isNot(contains(DoseWarning.hyperglycemiaCriticalPhysicianAlert)));
    });

    test('Case 10: Missing settings returns missingSettings status', () {
      // Missing ICR when carbs > 0
      final settingsWithoutIcr = const TherapySettings(
        doseStep: 0.5,
        maxSingleDose: 15.0,
      );

      final inputWithCarbs = DoseInput(
        totalCarbsG: 45.0,
        settings: settingsWithoutIcr,
        now: now,
      );

      final result = DoseCalculator.calculate(inputWithCarbs);
      expect(result.status, DoseStatus.missingSettings);
      expect(result.roundedUnits, isNull);

      // Missing ISF when glucose provided
      final settingsWithoutIsf = const TherapySettings(
        defaultIcr: 10.0,
        targetGlucose: 100.0,
        doseStep: 0.5,
        maxSingleDose: 15.0,
      );

      final inputWithGlucose = DoseInput(
        totalCarbsG: 0.0,
        currentGlucose: 180.0,
        settings: settingsWithoutIsf,
        now: now,
      );

      final result2 = DoseCalculator.calculate(inputWithGlucose);
      expect(result2.status, DoseStatus.missingSettings);
    });

    test('Zero carbs and no glucose returns 0 U success', () {
      final settings = const TherapySettings(
        defaultIcr: 10.0,
        doseStep: 0.5,
        maxSingleDose: 15.0,
      );

      final input = DoseInput(
        totalCarbsG: 0.0,
        settings: settings,
        now: now,
      );

      final result = DoseCalculator.calculate(input);
      expect(result.status, DoseStatus.success);
      expect(result.roundedUnits, 0.0);
    });

    test('Unverified food data triggers warning and requiresUserConfirmation',
        () {
      final settings = const TherapySettings(
        defaultIcr: 10.0,
        doseStep: 0.5,
        maxSingleDose: 15.0,
      );

      final input = DoseInput(
        totalCarbsG: 45.0,
        settings: settings,
        now: now,
        minFoodConfidence: DataConfidence.communityUnverified,
      );

      final result = DoseCalculator.calculate(input);
      expect(result.status, DoseStatus.success);
      expect(result.requiresUserConfirmation, isTrue);
      expect(result.warnings, contains(DoseWarning.unverifiedFoodDataInMeal));
    });

    test('Hourly ICR blocks select appropriate ratio', () {
      final morningBlock = IcrBlock(from: '06:00', to: '11:00', gPerUnit: 8.0);
      final eveningBlock = IcrBlock(from: '18:00', to: '22:00', gPerUnit: 12.0);

      final settings = TherapySettings(
        icrBlocks: [morningBlock, eveningBlock],
        defaultIcr: 10.0,
        doseStep: 0.5,
        maxSingleDose: 15.0,
      );

      // Morning test (08:30) -> ICR 8.0 -> 40g / 8 = 5.0 U
      final morningInput = DoseInput(
        totalCarbsG: 40.0,
        settings: settings,
        now: DateTime(2026, 10, 1, 8, 30),
      );
      final morningResult = DoseCalculator.calculate(morningInput);
      expect(morningResult.mealUnits, 5.0);

      // Evening test (19:00) -> ICR 12.0 -> 36g / 12 = 3.0 U
      final eveningInput = DoseInput(
        totalCarbsG: 36.0,
        settings: settings,
        now: DateTime(2026, 10, 1, 19, 0),
      );
      final eveningResult = DoseCalculator.calculate(eveningInput);
      expect(eveningResult.mealUnits, 3.0);

      // Afternoon fallback (14:00) -> default ICR 10.0 -> 30g / 10 = 3.0 U
      final afternoonInput = DoseInput(
        totalCarbsG: 30.0,
        settings: settings,
        now: DateTime(2026, 10, 1, 14, 0),
      );
      final afternoonResult = DoseCalculator.calculate(afternoonInput);
      expect(afternoonResult.mealUnits, 3.0);
    });

    test('Negative correction applied when enabled in settings', () {
      final settings = const TherapySettings(
        defaultIcr: 10.0,
        isf: 40.0,
        targetGlucose: 120.0,
        doseStep: 0.5,
        maxSingleDose: 15.0,
        allowNegativeCorrection: true,
      );

      final input = DoseInput(
        totalCarbsG: 50.0, // 5.0 U meal dose
        currentGlucose: 80.0, // (80 - 120) / 40 = -1.0 U
        settings: settings,
        now: now,
      );

      final result = DoseCalculator.calculate(input);
      expect(result.status, DoseStatus.success);
      expect(result.mealUnits, 5.0);
      expect(result.correctionUnits, -1.0);
      expect(result.rawUnits, 4.0); // 5.0 + (-1.0) = 4.0
      expect(result.roundedUnits, 4.0);
      expect(result.warnings, contains(DoseWarning.negativeCorrectionApplied));
    });

    test('Invalid input handling (NaN and negative numbers)', () {
      final settings = const TherapySettings(
        defaultIcr: 10.0,
        doseStep: 0.5,
        maxSingleDose: 15.0,
      );

      final resultNan = DoseCalculator.calculate(
        DoseInput(
          totalCarbsG: double.nan,
          settings: settings,
          now: now,
        ),
      );
      expect(resultNan.status, DoseStatus.invalidInput);

      final resultNegative = DoseCalculator.calculate(
        DoseInput(
          totalCarbsG: -10.0,
          settings: settings,
          now: now,
        ),
      );
      expect(resultNegative.status, DoseStatus.invalidInput);
    });

    test('U-100 syringe mL helper calculation', () {
      final settings = const TherapySettings(
        defaultIcr: 10.0,
        doseStep: 0.5,
        maxSingleDose: 15.0,
      );

      final input = DoseInput(
        totalCarbsG: 55.0, // 5.5 U
        settings: settings,
        now: now,
      );

      final result = DoseCalculator.calculate(input);
      expect(result.roundedUnits, 5.5);
      expect(result.u100Milliliters, 0.055);
    });
  });
}
