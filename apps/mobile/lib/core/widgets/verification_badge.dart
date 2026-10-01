import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Visual badge showing data verification confidence and source legitimacy.
class VerificationBadge extends StatelessWidget {
  final String status;
  final String? sourceRef;

  const VerificationBadge({
    super.key,
    required this.status,
    this.sourceRef,
  });

  @override
  Widget build(BuildContext context) {
    final Color color;
    final IconData icon;
    final String label;

    switch (status) {
      case 'official_verified':
        color = Colors.green.shade700;
        icon = Icons.verified;
        label = 'Resmi Onaylı';
        break;
      case 'label_verified':
        color = Colors.teal.shade700;
        icon = Icons.fact_check;
        label = 'Etiket Doğrulanmış';
        break;
      case 'user_entered':
        color = Colors.blue.shade700;
        icon = Icons.person;
        label = 'Kullanıcı Girişi';
        break;
      case 'sample_only':
        color = Colors.purple.shade700;
        icon = Icons.science;
        label = 'Örnek Veri';
        break;
      case 'community_unverified':
      default:
        color = AppTheme.accentAmber;
        icon = Icons.warning_amber_rounded;
        label = 'Doğrulanmamış (Topluluk)';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (sourceRef != null && sourceRef!.isNotEmpty) ...[
            const SizedBox(width: 4),
            Text(
              '($sourceRef)',
              style: TextStyle(
                color: color.withValues(alpha: 0.8),
                fontSize: 10,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
