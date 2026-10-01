import 'package:flutter/material.dart';

/// Form input field supporting Turkish decimal comma (,) and international dot (.)
///
/// Ensures strict validation and never silently fails into 0.0.
class NumericField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final String? suffixText;
  final Widget? prefixIcon;
  final bool allowDecimals;
  final double? min;
  final double? max;
  final ValueChanged<double?>? onChanged;
  final String? Function(String?)? customValidator;

  const NumericField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.suffixText,
    this.prefixIcon,
    this.allowDecimals = true,
    this.min,
    this.max,
    this.onChanged,
    this.customValidator,
  });

  /// Utility to safely parse either comma or dot separated numbers
  static double? parseTurkishDouble(String text) {
    final cleaned = text.trim().replaceAll(',', '.');
    if (cleaned.isEmpty) return null;
    return double.tryParse(cleaned);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(
        decimal: allowDecimals,
        signed: false,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        suffixText: suffixText,
        prefixIcon: prefixIcon,
      ),
      onChanged: (text) {
        if (onChanged != null) {
          final val = parseTurkishDouble(text);
          onChanged!(val);
        }
      },
      validator: (text) {
        if (text == null || text.trim().isEmpty) {
          return null; // Empty handled by caller required checks
        }

        final parsed = parseTurkishDouble(text);
        if (parsed == null) {
          return 'Geçersiz sayı (Örn. 45 veya 4,5)';
        }

        if (min != null && parsed < min!) {
          return 'Değer en az $min olmalıdır';
        }

        if (max != null && parsed > max!) {
          return 'Değer en fazla $max olmalıdır';
        }

        if (customValidator != null) {
          return customValidator!(text);
        }

        return null;
      },
    );
  }
}
