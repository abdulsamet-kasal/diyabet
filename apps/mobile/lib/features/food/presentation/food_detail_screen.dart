import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/verification_badge.dart';
import '../../../core/widgets/carb_badge.dart';
import '../../../core/widgets/numeric_field.dart';
import '../../../data/local/app_database.dart';
import '../../../data/providers/app_providers.dart';
import '../../../data/providers/plate_provider.dart';

class FoodDetailScreen extends ConsumerStatefulWidget {
  final LocalFood food;

  const FoodDetailScreen({super.key, required this.food});

  @override
  ConsumerState<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends ConsumerState<FoodDetailScreen> {
  final TextEditingController _gramsController = TextEditingController(text: '100');
  double _grams = 100.0;
  List<LocalFoodPortion> _portions = [];
  LocalFoodPortion? _selectedPortion;

  @override
  void initState() {
    super.initState();
    _loadPortions();
  }

  void _loadPortions() async {
    final repo = ref.read(foodRepositoryProvider);
    final portions = await repo.getPortionsForFood(widget.food.id);
    if (mounted) {
      setState(() => _portions = portions);
    }
  }

  @override
  void dispose() {
    _gramsController.dispose();
    super.dispose();
  }

  void _onGramsChanged(double? val) {
    if (val != null && val >= 0) {
      setState(() {
        _grams = val;
        _selectedPortion = null;
      });
    }
  }

  void _onPortionSelected(LocalFoodPortion? portion) {
    if (portion != null) {
      setState(() {
        _selectedPortion = portion;
        _grams = portion.grams;
        _gramsController.text = portion.grams.toStringAsFixed(0);
      });
    }
  }

  void _addToPlate() {
    ref.read(plateProvider.notifier).addItem(
          widget.food,
          _grams,
          _selectedPortion?.labelTr,
        );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.food.nameTr} (${_grams.toStringAsFixed(0)} g) tabağa eklendi.'),
        action: SnackBarAction(
          label: 'Tabağa Git',
          onPressed: () => context.push('/plate'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final food = widget.food;
    final multiplier = _grams / 100.0;

    final carbs = food.carbsGPer100g * multiplier;
    final sugars = (food.sugarsGPer100g ?? 0.0) * multiplier;
    final fiber = (food.fiberGPer100g ?? 0.0) * multiplier;
    final protein = food.proteinGPer100g * multiplier;
    final fat = food.fatGPer100g * multiplier;
    final kcal = food.kcalPer100g * multiplier;

    // Glycemic Load: GL = (GI * carbsG) / 100
    final double? gl = food.gi != null ? (food.gi! * carbs) / 100.0 : null;

    return Scaffold(
      appBar: AppBar(title: Text(food.nameTr)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Top badges and metadata
            Row(
              children: [
                VerificationBadge(status: food.verification, sourceRef: food.sourceRef),
                const SizedBox(width: 8),
                if (food.category != null)
                  Chip(
                    padding: EdgeInsets.zero,
                    label: Text(food.category!, style: const TextStyle(fontSize: 11)),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            // Portion and Gram Selector Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Porsiyon ve Tüketim Miktarı', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 12),
                    if (_portions.isNotEmpty) ...[
                      DropdownButtonFormField<LocalFoodPortion>(
                        decoration: const InputDecoration(labelText: 'Hazır Porsiyon Ölçüsü'),
                        initialValue: _selectedPortion,
                        items: _portions.map((p) {
                          return DropdownMenuItem(
                            value: p,
                            child: Text('${p.labelTr} (${p.grams.toStringAsFixed(0)} g)'),
                          );
                        }).toList(),
                        onChanged: _onPortionSelected,
                      ),
                      const SizedBox(height: 12),
                    ],
                    NumericField(
                      controller: _gramsController,
                      labelText: 'Net Gramaj',
                      suffixText: 'gram (g)',
                      onChanged: _onGramsChanged,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Total Carbs Prominent Highlight
            Card(
              color: AppTheme.primaryTeal.withValues(alpha: 0.08),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bu Porsiyondaki Karbonhidrat', style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
                        const SizedBox(height: 4),
                        Text(
                          '${carbs.toStringAsFixed(1)} g',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryTeal,
                            fontFeatures: [FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ),
                    CarbBadge(carbsG: carbs),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Nutriments Breakdown Grid
            const Text('Besin Kompozisyonu Detayı', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.2,
              children: [
                _buildMacroCard('Kalori', '${kcal.toStringAsFixed(0)} kcal', Icons.local_fire_department),
                _buildMacroCard('Şeker', '${sugars.toStringAsFixed(1)} g', Icons.cookie_outlined),
                _buildMacroCard('Lif', '${fiber.toStringAsFixed(1)} g', Icons.eco_outlined),
                _buildMacroCard('Protein', '${protein.toStringAsFixed(1)} g', Icons.fitness_center),
                _buildMacroCard('Yağ', '${fat.toStringAsFixed(1)} g', Icons.opacity),
                if (food.gi != null)
                  _buildMacroCard(
                    'GI / GL',
                    'GI: ${food.gi} | GL: ${gl?.toStringAsFixed(1)}',
                    Icons.speed,
                  ),
              ],
            ),
            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: _grams > 0 ? _addToPlate : null,
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Öğün Tabağıma Ekle'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMacroCard(String title, String value, IconData icon) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Row(
          children: [
            Icon(icon, size: 24, color: AppTheme.primaryTeal),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                  Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
