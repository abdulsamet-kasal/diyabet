import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/numeric_field.dart';
import '../../../data/local/app_database.dart';
import '../../../data/providers/app_providers.dart';
import '../../../data/repositories/food_repository.dart';

class AddFoodScreen extends ConsumerStatefulWidget {
  final String? initialBarcode;

  const AddFoodScreen({super.key, this.initialBarcode});

  @override
  ConsumerState<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends ConsumerState<AddFoodScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _carbsController = TextEditingController();
  final _sugarsController = TextEditingController();
  final _fiberController = TextEditingController();
  final _proteinController = TextEditingController();
  final _fatController = TextEditingController();
  final _kcalController = TextEditingController();

  final _portionLabelController = TextEditingController(text: '1 Porsiyon');
  final _portionGramsController = TextEditingController(text: '100');

  final String _preparation = 'as_sold';

  @override
  void initState() {
    super.initState();
    if (widget.initialBarcode != null) {
      _barcodeController.text = widget.initialBarcode!;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _barcodeController.dispose();
    _carbsController.dispose();
    _sugarsController.dispose();
    _fiberController.dispose();
    _proteinController.dispose();
    _fatController.dispose();
    _kcalController.dispose();
    _portionLabelController.dispose();
    _portionGramsController.dispose();
    super.dispose();
  }

  void _saveFood() async {
    if (!_formKey.currentState!.validate()) return;

    final carbs = NumericField.parseTurkishDouble(_carbsController.text) ?? 0.0;
    final sugars = NumericField.parseTurkishDouble(_sugarsController.text);
    final fiber = NumericField.parseTurkishDouble(_fiberController.text);
    final protein = NumericField.parseTurkishDouble(_proteinController.text) ?? 0.0;
    final fat = NumericField.parseTurkishDouble(_fatController.text) ?? 0.0;
    final kcal = NumericField.parseTurkishDouble(_kcalController.text) ?? 0.0;

    // Quality check: sugars <= carbs, fiber <= carbs
    if (sugars != null && sugars > carbs) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hata: Şeker miktarı toplam karbonhidrattan büyük olamaz.')),
      );
      return;
    }
    if (fiber != null && fiber > carbs) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hata: Lif miktarı toplam karbonhidrattan büyük olamaz.')),
      );
      return;
    }

    final foodId = 'user_food_${DateTime.now().microsecondsSinceEpoch}';
    final repo = ref.read(foodRepositoryProvider);

    final portions = <LocalFoodPortionsCompanion>[];
    final portionGrams = NumericField.parseTurkishDouble(_portionGramsController.text);
    if (portionGrams != null && portionGrams > 0) {
      portions.add(
        LocalFoodPortionsCompanion.insert(
          id: 'portion_${DateTime.now().microsecondsSinceEpoch}',
          foodId: foodId,
          labelTr: _portionLabelController.text.trim().isNotEmpty ? _portionLabelController.text.trim() : '1 Porsiyon',
          grams: portionGrams,
          sourceRef: 'Kullanıcı Girişi',
        ),
      );
    }

    await repo.insertFood(
      LocalFoodsCompanion.insert(
        id: foodId,
        nameTr: _nameController.text.trim(),
        nameEn: drift.Value(_brandController.text.trim().isNotEmpty ? _brandController.text.trim() : null),
        normalizedName: FoodRepository.normalizeTurkish(_nameController.text),
        category: const drift.Value('Paketli Ürünler'),
        brand: drift.Value(_brandController.text.trim().isNotEmpty ? _brandController.text.trim() : null),
        barcode: drift.Value(_barcodeController.text.trim().isNotEmpty ? _barcodeController.text.trim() : null),
        preparation: drift.Value(_preparation),
        carbsGPer100g: carbs,
        sugarsGPer100g: drift.Value(sugars),
        fiberGPer100g: drift.Value(fiber),
        proteinGPer100g: drift.Value(protein),
        fatGPer100g: drift.Value(fat),
        kcalPer100g: drift.Value(kcal),
        verification: const drift.Value('user_entered'),
        isSample: const drift.Value(false),
      ),
      portions,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Besin başarıyla kaydedildi.')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paket Etiketinden Besin Ekle')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Card(
                color: Colors.blue.shade50,
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: AppTheme.primaryTeal),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Lütfen paket üzerindeki 100 gram tablosunda yer alan değerleri giriniz.',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Ürün Adı *', hintText: 'Örn. Bitter Çikolata %70'),
                validator: (val) => val == null || val.trim().isEmpty ? 'Ürün adı zorunludur' : null,
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _brandController,
                      decoration: const InputDecoration(labelText: 'Marka', hintText: 'Örn. Ülker, Eti'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _barcodeController,
                      decoration: const InputDecoration(labelText: 'Barkod (Opsiyonel)'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              const Text('100 Gram Başına Besin Değerleri', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 10),

              NumericField(
                controller: _carbsController,
                labelText: 'Toplam Karbonhidrat (100g) *',
                hintText: 'Örn. 54.0',
                suffixText: 'gram (g)',
                customValidator: (val) => val == null || val.trim().isEmpty ? 'Karbonhidrat zorunludur' : null,
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: NumericField(
                      controller: _sugarsController,
                      labelText: 'Şeker',
                      suffixText: 'g',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: NumericField(
                      controller: _fiberController,
                      labelText: 'Lif',
                      suffixText: 'g',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: NumericField(
                      controller: _proteinController,
                      labelText: 'Protein',
                      suffixText: 'g',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: NumericField(
                      controller: _fatController,
                      labelText: 'Yağ',
                      suffixText: 'g',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              NumericField(
                controller: _kcalController,
                labelText: 'Enerji / Kalori',
                suffixText: 'kcal',
              ),
              const SizedBox(height: 16),

              const Text('Porsiyon Ölçüsü (Opsiyonel)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _portionLabelController,
                      decoration: const InputDecoration(labelText: 'Porsiyon Adı', hintText: '1 Paket / 2 Dilim'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: NumericField(
                      controller: _portionGramsController,
                      labelText: 'Porsiyon Gramajı',
                      suffixText: 'g',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              ElevatedButton.icon(
                onPressed: _saveFood,
                icon: const Icon(Icons.save),
                label: const Text('Besini Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
