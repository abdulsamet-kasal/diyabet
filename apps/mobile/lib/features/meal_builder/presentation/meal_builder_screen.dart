import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/carb_badge.dart';
import '../../../core/widgets/verification_badge.dart';
import '../../../data/providers/app_providers.dart';
import '../../../data/providers/plate_provider.dart';

class MealBuilderScreen extends ConsumerWidget {
  const MealBuilderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plate = ref.watch(plateProvider);
    final profile = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Öğün Tabağı'),
        actions: [
          if (plate.items.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Tabağı Temizle',
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Tabağı Temizle'),
                    content: const Text('Tabaktaki tüm besinler silinecektir. Onaylıyor musunuz?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Vazgeç')),
                      TextButton(
                        onPressed: () {
                          ref.read(plateProvider.notifier).clearPlate();
                          Navigator.pop(ctx);
                        },
                        child: const Text('Temizle', style: TextStyle(color: AppTheme.glucoseLow)),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top Summary Card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              color: AppTheme.primaryTeal.withValues(alpha: 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Toplam Karbonhidrat', style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                      const SizedBox(height: 4),
                      Text(
                        '${plate.totalCarbsG.toStringAsFixed(1)} g',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryTeal,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Değişim Birimi', style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryTeal,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${plate.exchangeUnits.toStringAsFixed(1)} DEĞİŞİM',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Plate Items List or Empty State
            Expanded(
              child: plate.items.isEmpty
                  ? Center(
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
                            icon: const Icon(Icons.search),
                            label: const Text('Besin Ara ve Ekle'),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: plate.items.length,
                      itemBuilder: (context, index) {
                        final item = plate.items[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.food.nameTr,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            '${item.grams.toStringAsFixed(0)} g',
                                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                                          ),
                                          if (item.portionLabel != null) ...[
                                            const SizedBox(width: 6),
                                            Text(
                                              '(${item.portionLabel})',
                                              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                                            ),
                                          ],
                                          const SizedBox(width: 8),
                                          VerificationBadge(status: item.food.verification),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                CarbBadge(carbsG: item.totalCarbsG, showExchange: false),
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline, color: AppTheme.glucoseLow),
                                  tooltip: 'Kaldır',
                                  onPressed: () => ref.read(plateProvider.notifier).removeItem(index),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  OutlinedButton.icon(
                    onPressed: () => context.push('/foods'),
                    icon: const Icon(Icons.add),
                    label: const Text('Daha Fazla Besin Ekle'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: plate.totalCarbsG > 0
                        ? () {
                            if (!profile.isDoseCalculatorAllowed) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Diyabet profilinizde veya yaş kısıtınızda doz hesaplayıcı kapalıdır. Yalnızca karbonhidrat takibi kullanılabilir.',
                                  ),
                                ),
                              );
                              return;
                            }
                            context.push('/dose');
                          }
                        : null,
                    child: Text(
                      profile.isDoseCalculatorAllowed
                          ? 'Bu Öğün İçin Doz Hesapla (${plate.totalCarbsG.toStringAsFixed(1)} g)'
                          : 'Öğün Karbonhidratını Kaydet',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
