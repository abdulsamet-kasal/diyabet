import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../constants/clinical_constants.dart';

/// Badge displaying carbohydrate grams and exchange units.
class CarbBadge extends StatelessWidget {
  final double carbsG;
  final bool showExchange;

  const CarbBadge({
    super.key,
    required this.carbsG,
    this.showExchange = true,
  });

  @override
  Widget build(BuildContext context) {
    final exchange = carbsG / ClinicalConstants.defaultCarbExchangeG;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppTheme.primaryTeal.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.primaryTeal.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.bakery_dining, size: 16, color: AppTheme.primaryTeal),
          const SizedBox(width: 6),
          Text(
            '${carbsG.toStringAsFixed(1)} g Karb',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: AppTheme.primaryTeal,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
          if (showExchange) ...[
            const SizedBox(width: 6),
            Text(
              '(${exchange.toStringAsFixed(1)} Değişim)',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
