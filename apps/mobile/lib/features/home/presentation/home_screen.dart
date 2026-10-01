import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: l10n.settings,
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Prominent Emergency Hypo Card Button (Always accessible)
            Card(
              color: AppTheme.glucoseLow,
              child: InkWell(
                onTap: () => context.push('/emergency'),
                borderRadius: BorderRadius.circular(12),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 18.0),
                  child: Row(
                    children: [
                      Icon(Icons.warning_amber_rounded, color: Colors.white, size: 36),
                      SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'HİPOGLİSEMİ YARDIMI (15-15)',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Şeker < 70 mg/dL acil müdahale rehberi',
                              style: TextStyle(color: Colors.white70, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Quick Actions Grid
            const Text(
              'Hızlı Eylemler',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
              children: [
                _QuickActionCard(
                  icon: Icons.calculate_outlined,
                  title: 'Doz Hesapla',
                  subtitle: 'Öğün + Düzeltme',
                  onTap: () => context.push('/dose'),
                ),
                _QuickActionCard(
                  icon: Icons.restaurant_menu,
                  title: 'Öğün Tabağı',
                  subtitle: 'Karb sayımı',
                  onTap: () => context.push('/plate'),
                ),
                _QuickActionCard(
                  icon: Icons.search,
                  title: 'Besin Ara / Barkod',
                  subtitle: 'Karbonhidrat cetveli',
                  onTap: () => context.push('/foods'),
                ),
                _QuickActionCard(
                  icon: Icons.bloodtype_outlined,
                  title: 'Glikoz Günlüğü',
                  subtitle: 'Ölçüm kaydet',
                  onTap: () => context.push('/glucose'),
                ),
                _QuickActionCard(
                  icon: Icons.bar_chart,
                  title: 'Raporlar (PDF)',
                  subtitle: 'Doktor dökümü',
                  onTap: () => context.push('/reports'),
                ),
                _QuickActionCard(
                  icon: Icons.school_outlined,
                  title: 'Eğitim Rehberi',
                  subtitle: 'Diyabet bilgileri',
                  onTap: () => context.push('/education'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: AppTheme.primaryTeal),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
