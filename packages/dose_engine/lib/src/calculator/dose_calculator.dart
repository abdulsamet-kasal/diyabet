import 'dart:math' as math;
import '../models/dose_input.dart';
import '../models/dose_result.dart';
import '../models/enums.dart';
import 'iob_calculator.dart';
import 'rounding.dart';

/// Pure Dart insulin dose calculation engine for GlikoRehber.
///
/// Implements deterministic, strictly validated clinical safety invariants:
/// - Hypoglycemia blocking (< 70 mg/dL)
/// - Pure Dart (zero UI, zero network, zero AI)
/// - Transparent mathematical breakdown
/// - Half-down conservative dose step rounding
/// - IOB deduction strictly from correction component
/// - Maximum single dose guard
class DoseCalculator {
  DoseCalculator._();

  static const double mmolLToMgDl = 18.0182;
  static const double severeHypoThresholdMgDl = 54.0;
  static const double hypoThresholdMgDl = 70.0;
  static const double highKetoneThresholdMgDl = 250.0;
  static const double criticalHighThresholdMgDl = 300.0;

  /// Calculates the recommended insulin dose based on [input].
  static DoseResult calculate(DoseInput input) {
    // -------------------------------------------------------------
    // Step 1: Input Validation
    // -------------------------------------------------------------
    if (input.totalCarbsG.isNaN ||
        input.totalCarbsG.isInfinite ||
        input.totalCarbsG < 0) {
      return DoseResult.invalidInput(
        reason:
            'Karbonhidrat miktarı 0 veya daha büyük geçerli bir sayı olmalıdır.',
      );
    }

    if (input.currentGlucose != null &&
        (input.currentGlucose!.isNaN ||
            input.currentGlucose!.isInfinite ||
            input.currentGlucose! < 0)) {
      return DoseResult.invalidInput(
        reason: 'Kan şekeri değeri 0\'dan büyük geçerli bir sayı olmalıdır.',
      );
    }

    final settings = input.settings;
    if (settings.doseStep <= 0 || settings.maxSingleDose <= 0) {
      return DoseResult.missingSettings(
        reason: 'Doz adımı ve maksimum tek doz tanımlanmalıdır.',
      );
    }

    final icr = settings.getIcrForTime(input.now);
    if (input.totalCarbsG > 0 && (icr == null || icr <= 0)) {
      return DoseResult.missingSettings(
        reason:
            'Bu saat dilimi için İnsülin/Karbonhidrat Oranı (ICR) tanımlanmamış.',
      );
    }

    if (input.currentGlucose != null) {
      if (settings.isf == null ||
          settings.isf! <= 0 ||
          settings.targetGlucose == null ||
          settings.targetGlucose! <= 0) {
        return DoseResult.missingSettings(
          reason: 'Düzeltme dozu için ISF ve Hedef glikoz tanımlanmalıdır.',
        );
      }
    }

    // If no carbs and no glucose provided
    if (input.totalCarbsG == 0 && input.currentGlucose == null) {
      return const DoseResult(
        status: DoseStatus.success,
        roundedUnits: 0.0,
        rawUnits: 0.0,
        mealUnits: 0.0,
        rawCorrectionUnits: 0.0,
        correctionUnits: 0.0,
        breakdown: ['Karbonhidrat girilmedi ve kan şekeri ölçümü yok: 0 U.'],
      );
    }

    final breakdown = <String>[];
    final warnings = <DoseWarning>[];
    final assumptions = <String>[];

    // -------------------------------------------------------------
    // Step 2: Unit Normalization
    // -------------------------------------------------------------
    double? glucoseMgDl;
    double? targetMgDl;
    double? isfMgDl;

    if (input.currentGlucose != null) {
      if (input.glucoseUnit == GlucoseUnit.mmoll) {
        glucoseMgDl = input.currentGlucose! * mmolLToMgDl;
        targetMgDl = settings.targetGlucose! * mmolLToMgDl;
        isfMgDl = settings.isf! * mmolLToMgDl;
        breakdown.add(
          'Birim dönüşümü: ${input.currentGlucose!.toStringAsFixed(1)} mmol/L = ${glucoseMgDl.toStringAsFixed(1)} mg/dL',
        );
      } else {
        glucoseMgDl = input.currentGlucose!;
        targetMgDl = settings.targetGlucose!;
        isfMgDl = settings.isf!;
      }
    }

    // -------------------------------------------------------------
    // Step 3: Hypoglycemia Block (Rule 3)
    // -------------------------------------------------------------
    if (glucoseMgDl != null) {
      if (glucoseMgDl < hypoThresholdMgDl) {
        if (glucoseMgDl < severeHypoThresholdMgDl) {
          warnings.add(DoseWarning.severeHypoglycemia);
          breakdown.add(
            'KRİTİK UYARI: Kan şekeri < 54 mg/dL! Ciddi hipoglisemi riski. 112 Acil Yardım çağrılmalıdır.',
          );
        } else {
          breakdown.add(
            'HİPOGLİSEMİ BLOĞU: Kan şekeri < 70 mg/dL (${glucoseMgDl.toStringAsFixed(1)} mg/dL). Doz hesaplanamaz.',
          );
        }
        warnings.add(DoseWarning.hypoglycemiaBlock);
        breakdown.add(
            '15-15 Kuralı uygulanmalıdır: 15g hızlı etkili karbonhidrat alıp 15 dakika bekleyiniz.');

        return DoseResult.blockedHypoglycemia(
          glucoseMgDl: glucoseMgDl,
          warnings: warnings,
          breakdown: breakdown,
        );
      }

      // High glucose warnings (Rule 4)
      if (glucoseMgDl >= criticalHighThresholdMgDl) {
        warnings.add(DoseWarning.hyperglycemiaCriticalPhysicianAlert);
        warnings.add(DoseWarning.hyperglycemiaHighKetoneAlert);
        breakdown.add(
          'YÜKSEK GLİKOZ: Kan şekeri >= 300 mg/dL. Keton kontrolü yapınız ve hekiminize danışınız.',
        );
      } else if (glucoseMgDl >= highKetoneThresholdMgDl) {
        warnings.add(DoseWarning.hyperglycemiaHighKetoneAlert);
        breakdown.add(
          'YÜKSEK GLİKOZ UYARISI: Kan şekeri >= 250 mg/dL. Keton seviyenizi kontrol ediniz.',
        );
      }
    }

    // -------------------------------------------------------------
    // Step 4: Meal Dose Calculation
    // -------------------------------------------------------------
    double mealUnits = 0.0;
    if (input.totalCarbsG > 0 && icr != null) {
      mealUnits = input.totalCarbsG / icr;
      breakdown.add(
        'Öğün Dozu: ${input.totalCarbsG.toStringAsFixed(1)} g Karb ÷ $icr (ICR) = ${mealUnits.toStringAsFixed(3)} U',
      );
    } else {
      breakdown.add('Öğün Dozu: 0.0 U (Karbonhidrat girilmedi)');
    }

    // -------------------------------------------------------------
    // Step 5: Correction Dose Calculation
    // -------------------------------------------------------------
    double rawCorrectionUnits = 0.0;
    double effectiveCorrectionUnits = 0.0;

    if (glucoseMgDl != null && targetMgDl != null && isfMgDl != null) {
      final delta = glucoseMgDl - targetMgDl;
      rawCorrectionUnits = delta / isfMgDl;

      if (rawCorrectionUnits < 0) {
        if (settings.allowNegativeCorrection) {
          effectiveCorrectionUnits = rawCorrectionUnits;
          warnings.add(DoseWarning.negativeCorrectionApplied);
          breakdown.add(
            'Negatif Düzeltme: (${glucoseMgDl.toStringAsFixed(1)} - ${targetMgDl.toStringAsFixed(1)}) ÷ ${isfMgDl.toStringAsFixed(1)} = ${rawCorrectionUnits.toStringAsFixed(3)} U (Öğün dozundan düşülüyor)',
          );
        } else {
          effectiveCorrectionUnits = 0.0;
          breakdown.add(
            'Glikoz hedefin altında (${glucoseMgDl.toStringAsFixed(1)} < ${targetMgDl.toStringAsFixed(1)} mg/dL). Negatif düzeltme kapalı olduğu için düzeltme dozu: 0 U.',
          );
        }
      } else {
        effectiveCorrectionUnits = rawCorrectionUnits;
        breakdown.add(
          'Düzeltme Dozu: (${glucoseMgDl.toStringAsFixed(1)} - ${targetMgDl.toStringAsFixed(1)}) ÷ ${isfMgDl.toStringAsFixed(1)} = ${effectiveCorrectionUnits.toStringAsFixed(3)} U',
        );
      }
    }

    // -------------------------------------------------------------
    // Step 6: Active Insulin (IOB) Deduction
    // -------------------------------------------------------------
    final totalIob = IobCalculator.calculateTotalIob(
      recentDoses: input.recentDoses,
      now: input.now,
      fallbackDiaHours: settings.diaHours,
    );

    double iobDeducted = 0.0;
    double netCorrectionUnits = effectiveCorrectionUnits;

    if (effectiveCorrectionUnits > 0 && totalIob > 0) {
      iobDeducted = math.min(effectiveCorrectionUnits, totalIob);
      netCorrectionUnits = effectiveCorrectionUnits - iobDeducted;
      breakdown.add(
        'Aktif İnsülin (IOB): Toplam ${totalIob.toStringAsFixed(2)} U aktif insülinden ${iobDeducted.toStringAsFixed(2)} U düzeltme dozundan düşüldü. Net düzeltme: ${netCorrectionUnits.toStringAsFixed(3)} U.',
      );
    } else if (totalIob > 0) {
      breakdown.add(
        'Aktif İnsülin (IOB): ${totalIob.toStringAsFixed(2)} U mevcut, ancak pozitif düzeltme dozu olmadığı için öğün dozundan düşülmedi.',
      );
    }

    // -------------------------------------------------------------
    // Step 7: Total Raw Dose
    // -------------------------------------------------------------
    final rawTotal = math.max(0.0, mealUnits + netCorrectionUnits);
    breakdown.add(
      'Ham Toplam: ${mealUnits.toStringAsFixed(3)} (Öğün) + ${netCorrectionUnits.toStringAsFixed(3)} (Net Düzeltme) = ${rawTotal.toStringAsFixed(3)} U',
    );

    // -------------------------------------------------------------
    // Step 8: Maximum Single Dose Limit Check (Rule 5)
    // -------------------------------------------------------------
    if (rawTotal > settings.maxSingleDose) {
      warnings.add(DoseWarning.maxSingleDoseExceeded);
      breakdown.add(
        'ÜST SINIR AŞILDI: Hesaplanan ham doz (${rawTotal.toStringAsFixed(2)} U), maksimum tek doz limitini (${settings.maxSingleDose.toStringAsFixed(1)} U) aşıyor! Doz gösterilmez. Lütfen girdilerinizi kontrol ediniz ve hekiminize danışınız.',
      );

      return DoseResult.blockedMaxDoseExceeded(
        rawUnits: rawTotal,
        maxDose: settings.maxSingleDose,
        warnings: warnings,
        breakdown: breakdown,
      );
    }

    // -------------------------------------------------------------
    // Step 9: Conservative Half-Down Rounding (Rule 11)
    // -------------------------------------------------------------
    final roundedUnits = roundToDoseStepHalfDown(rawTotal, settings.doseStep);
    breakdown.add(
      'Yuvarlama: ${rawTotal.toStringAsFixed(3)} U → ${settings.doseStep} U adımına göre yuvarlandı = $roundedUnits U (ortada aşağı kuralı)',
    );

    // -------------------------------------------------------------
    // Step 10: Food Data Confidence Check (Rule 6)
    // -------------------------------------------------------------
    bool requiresConfirmation = false;
    if (input.minFoodConfidence != DataConfidence.officialVerified &&
        input.minFoodConfidence != DataConfidence.labelVerified) {
      requiresConfirmation = true;
      warnings.add(DoseWarning.unverifiedFoodDataInMeal);
      breakdown.add(
        'GIDA UYARISI: Öğün doğrulanmamış besin verisi içeriyor. Lütfen paket etiketindeki değerleri kontrol ettiğinizi onaylayınız.',
      );
    }

    return DoseResult(
      status: DoseStatus.success,
      roundedUnits: roundedUnits,
      rawUnits: rawTotal,
      mealUnits: mealUnits,
      rawCorrectionUnits: rawCorrectionUnits,
      correctionUnits: netCorrectionUnits,
      iobDeducted: iobDeducted,
      totalIob: totalIob,
      warnings: warnings,
      breakdown: breakdown,
      assumptions: assumptions,
      requiresUserConfirmation: requiresConfirmation,
    );
  }
}
