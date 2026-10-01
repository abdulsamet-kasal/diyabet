import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class MealBuilderScreen extends StatefulWidget {
  const MealBuilderScreen({super.key});

  @override
  State<MealBuilderScreen> createState() => _MealBuilderScreenState();
}

class _MealBuilderScreenState extends State<MealBuilderScreen> {
  final double _totalCarbsG = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Öğün Tabağı')),
      body: SafeArea(
        child: Column(
          children: [
            // Top Summary Card
            Container(
              padding: const EdgeInsets.all(20),
              color: AppTheme.primaryTeal.withValues(alpha: 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Toplam Karbonhidrat', style: TextStyle(fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text(
                        '${_totalCarbsG.toStringAsFixed(1)} g',
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.primaryTeal),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Değişim Birimi', style: TextStyle(fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text(
                        '${(_totalCarbsG / 15.0).toStringAsFixed(1)} DEĞİŞİM',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.restaurant_outlined, size: 64, color: Colors.grey.shade400),
                    const SizedBox(height: 12),
                    const Text('Tabağınız henüz boş', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 6),
                    const Text('Besin arayarak veya barkod okutarak tabağınıza ekleyin.'),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () => context.push('/foods'),
                      icon: const Icon(Icons.add),
                      label: const Text('Besin Ekle'),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _totalCarbsG > 0 ? () => context.push('/dose') : null,
                child: const Text('Bu Öğün İçin Doz Hesapla'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
