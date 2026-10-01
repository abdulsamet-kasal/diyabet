import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum WarningLevel {
  info,
  warning,
  critical,
}

class WarningBanner extends StatelessWidget {
  final String title;
  final String message;
  final WarningLevel level;
  final VoidCallback? onAction;
  final String? actionLabel;

  const WarningBanner({
    super.key,
    required this.title,
    required this.message,
    this.level = WarningLevel.warning,
    this.onAction,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColor;
    final Color borderColor;
    final Color textColor;
    final IconData icon;

    switch (level) {
      case WarningLevel.critical:
        bgColor = Colors.red.shade50;
        borderColor = AppTheme.glucoseLow;
        textColor = AppTheme.glucoseSevere;
        icon = Icons.error_outline;
        break;
      case WarningLevel.warning:
        bgColor = Colors.amber.shade50;
        borderColor = AppTheme.accentAmber;
        textColor = Colors.amber.shade900;
        icon = Icons.warning_amber_rounded;
        break;
      case WarningLevel.info:
        bgColor = Colors.blue.shade50;
        borderColor = Colors.blue.shade300;
        textColor = Colors.blue.shade900;
        icon = Icons.info_outline;
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: borderColor, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            message,
            style: TextStyle(color: textColor.withValues(alpha: 0.9), fontSize: 13, height: 1.3),
          ),
          if (onAction != null && actionLabel != null) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onAction,
                style: TextButton.styleFrom(foregroundColor: textColor),
                child: Text(actionLabel!, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
