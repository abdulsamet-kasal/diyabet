import 'package:flutter/material.dart';
import '../constants/clinical_constants.dart';
import '../theme/app_theme.dart';

/// Accessible glucose indicator chip using color, symbol, and text.
///
/// WCAG compliant: Does NOT rely on color alone.
/// Shows:
/// - ▼ Düşük (< 70 mg/dL)
/// - ● Hedefte (70 - 180 mg/dL)
/// - ▲ Yüksek (> 180 mg/dL)
class GlucoseChip extends StatelessWidget {
  final double valueMgDl;
  final bool isMmol;

  const GlucoseChip({
    super.key,
    required this.valueMgDl,
    this.isMmol = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color color;
    final IconData icon;
    final String statusLabel;

    if (valueMgDl < ClinicalConstants.severeHypoglycemiaMgDl) {
      color = AppTheme.glucoseSevere;
      icon = Icons.arrow_downward_rounded;
      statusLabel = 'Çok Düşük (Kritik)';
    } else if (valueMgDl < ClinicalConstants.hypoglycemiaThresholdMgDl) {
      color = AppTheme.glucoseLow;
      icon = Icons.arrow_downward_rounded;
      statusLabel = 'Düşük';
    } else if (valueMgDl > ClinicalConstants.hyperglycemiaWarningMgDl) {
      color = AppTheme.glucoseHigh;
      icon = Icons.arrow_upward_rounded;
      statusLabel = 'Çok Yüksek';
    } else if (valueMgDl > 180.0) {
      color = AppTheme.glucoseHigh;
      icon = Icons.arrow_upward_rounded;
      statusLabel = 'Yüksek';
    } else {
      color = AppTheme.glucoseTarget;
      icon = Icons.check_circle_outline;
      statusLabel = 'Hedefte';
    }

    final displayValue = isMmol
        ? (valueMgDl / ClinicalConstants.mmolLToMgDlFactor).toStringAsFixed(1)
        : valueMgDl.toStringAsFixed(0);
    final unitLabel = isMmol ? 'mmol/L' : 'mg/dL';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Text(
            '$displayValue $unitLabel',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '($statusLabel)',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
