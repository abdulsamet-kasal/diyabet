import 'package:flutter/material.dart';
import 'package:dose_engine/dose_engine.dart';
import '../theme/app_theme.dart';
import 'warning_banner.dart';

/// Card presenting dose recommendation with formula transparency and warnings.
class DoseResultCard extends StatelessWidget {
  final DoseResult result;
  final bool usesSyringe;
  final VoidCallback? onApplyDose;
  final bool hasConfirmedUnverifiedFood;
  final ValueChanged<bool>? onToggleUnverifiedConfirmation;

  const DoseResultCard({
    super.key,
    required this.result,
    this.usesSyringe = false,
    this.onApplyDose,
    this.hasConfirmedUnverifiedFood = false,
    this.onToggleUnverifiedConfirmation,
  });

  @override
  Widget build(BuildContext context) {
    if (result.status == DoseStatus.blockedHypoglycemia) {
      return Card(
        color: Colors.red.shade50,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppTheme.glucoseLow, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.block, color: AppTheme.glucoseLow, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'HİPOGLİSEMİ NEDENİYLE DOZ ENGELLENDİ',
                      style: TextStyle(
                        color: AppTheme.glucoseSevere,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ...result.breakdown.map(
                (step) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Text('• $step', style: const TextStyle(fontSize: 13, height: 1.3)),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (result.status == DoseStatus.blockedMaxDoseExceeded) {
      return Card(
        color: Colors.orange.shade50,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppTheme.glucoseHigh, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.shield_outlined, color: AppTheme.glucoseHigh, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'MAKSİMUM TEK DOZ LİMİTİ AŞILDI',
                      style: TextStyle(
                        color: AppTheme.glucoseHigh,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Hesaplanan ham doz (${result.rawUnits?.toStringAsFixed(1)} U) belirlenen üst sınırı aşıyor. Lütfen girdilerinizi kontrol ediniz ve doktorunuza danışınız.',
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Önerilen İnsülin Dozu',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryTeal.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'ÖNERİ NİTELİĞİNDEDİR',
                    style: TextStyle(
                      color: AppTheme.primaryTeal,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Large Dose Number
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  result.roundedUnits?.toStringAsFixed(1) ?? '0.0',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryTeal,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Ünite (U)',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                if (usesSyringe && result.u100Milliliters != null) ...[
                  const Spacer(),
                  Text(
                    '(${result.u100Milliliters!.toStringAsFixed(3)} mL U-100)',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                ],
              ],
            ),
            const Divider(height: 24),

            // Mathematical breakdown (Formula transparency)
            const Text(
              'Hesaplama Adımları ve Formül Dökümü:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 6),
            ...result.breakdown.map(
              (step) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text(
                  step,
                  style: const TextStyle(fontSize: 12, height: 1.3),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Warnings
            if (result.warnings.contains(DoseWarning.hyperglycemiaCriticalPhysicianAlert))
              const WarningBanner(
                title: 'Kritik Yüksek Kan Şekeri (>= 300 mg/dL)',
                message: 'Keton kontrolü yapınız, bol su içiniz ve derhal doktorunuza danışınız.',
                level: WarningLevel.critical,
              ),

            if (result.warnings.contains(DoseWarning.hyperglycemiaHighKetoneAlert) &&
                !result.warnings.contains(DoseWarning.hyperglycemiaCriticalPhysicianAlert))
              const WarningBanner(
                title: 'Yüksek Kan Şekeri Uyarısı (>= 250 mg/dL)',
                message: 'İdrar veya kanda keton kontrolü yapmanız önerilir.',
                level: WarningLevel.warning,
              ),

            // Unverified food mandatory confirmation checkbox
            if (result.requiresUserConfirmation) ...[
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.accentAmber),
                ),
                child: CheckboxListTile(
                  value: hasConfirmedUnverifiedFood,
                  onChanged: (val) {
                    if (onToggleUnverifiedConfirmation != null) {
                      onToggleUnverifiedConfirmation!(val ?? false);
                    }
                  },
                  title: const Text(
                    'Paket etiketindeki besin değerlerini kontrol ettiğimi onaylıyorum.',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    'Öğün doğrulanmamış topluluk verisi içeriyor.',
                    style: TextStyle(fontSize: 11),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 14),

            // Fixed medical disclaimer
            Text(
              'Bu bir tıbbi tavsiye değildir. Uygulamadan önce doktorunuzun talimatlarıyla karşılaştırın.',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 14),

            // Action button (Uyguladım)
            ElevatedButton.icon(
              onPressed: (!result.requiresUserConfirmation || hasConfirmedUnverifiedFood) && onApplyDose != null
                  ? onApplyDose
                  : null,
              icon: const Icon(Icons.check),
              label: const Text('Uyguladım ve Günlüğe Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}
