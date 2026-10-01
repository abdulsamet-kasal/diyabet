import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/carb_badge.dart';
import '../../../core/widgets/verification_badge.dart';
import '../../../data/local/app_database.dart';
import '../../../data/providers/app_providers.dart';
import 'food_detail_screen.dart';
import 'add_food_screen.dart';

class FoodSearchScreen extends ConsumerStatefulWidget {
  const FoodSearchScreen({super.key});

  @override
  ConsumerState<FoodSearchScreen> createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends ConsumerState<FoodSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<LocalFood> _searchResults = [];
  bool _isLoading = false;
  String? _selectedCategory;

  final List<String> _categories = [
    'Tümü',
    'Tahıllar',
    'Meyveler',
    'Sebzeler',
    'Süt Ürünleri',
    'Baklagiller',
    'Paketli Ürünler',
  ];

  @override
  void initState() {
    super.initState();
    _performSearch('');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) async {
    setState(() => _isLoading = true);
    final repo = ref.read(foodRepositoryProvider);
    await repo.seedInitialFoodsIfNeeded();

    final results = await repo.searchFoods(query);
    if (mounted) {
      setState(() {
        if (_selectedCategory != null && _selectedCategory != 'Tümü') {
          _searchResults = results
              .where((f) => f.category != null && f.category!.contains(_selectedCategory!))
              .toList();
        } else {
          _searchResults = results;
        }
        _isLoading = false;
      });
    }
  }

  void _showBarcodeDialog() {
    final barcodeController = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.qr_code_scanner, color: AppTheme.primaryTeal),
            SizedBox(width: 8),
            Text('Barkod Arama'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Paketli ürünün barkod numarasını giriniz veya kamerayla tarayınız.',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: barcodeController,
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Barkod No',
                hintText: 'Örn. 869000000001',
                prefixIcon: Icon(Icons.qr_code),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('İptal')),
          ElevatedButton(
            onPressed: () async {
              final code = barcodeController.text.trim();
              Navigator.pop(ctx);
              if (code.isEmpty) return;

              final repo = ref.read(foodRepositoryProvider);
              final found = await repo.findByBarcode(code);
              if (mounted) {
                if (found != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => FoodDetailScreen(food: found)),
                  );
                } else {
                  // Not found -> prompt to add manually from label
                  showDialog<void>(
                    context: context,
                    builder: (alertCtx) => AlertDialog(
                      title: const Text('Ürün Bulunamadı'),
                      content: Text(
                        '$code barkodlu ürün yerel veritabanında bulunamadı. Paket etiketindeki değerleri elle eklemek ister misiniz?',
                      ),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(alertCtx), child: const Text('Vazgeç')),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(alertCtx);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => AddFoodScreen(initialBarcode: code)),
                            ).then((_) => _performSearch(_searchController.text));
                          },
                          child: const Text('Etiketten Ekle'),
                        ),
                      ],
                    ),
                  );
                }
              }
            },
            child: const Text('Ara'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Besin Arama & Cetvel'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            tooltip: 'Barkod Ara / Tara',
            onPressed: _showBarcodeDialog,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Elle Besin Ekle',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddFoodScreen()),
              ).then((_) => _performSearch(_searchController.text));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Besin adı ara (örn. Elma, Ekmek, Pilav)',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _performSearch('');
                        },
                      )
                    : null,
              ),
              onChanged: _performSearch,
            ),
          ),

          // Category Chips Horizontal Scroll
          SizedBox(
            height: 42,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = (_selectedCategory == cat) || (_selectedCategory == null && cat == 'Tümü');
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(cat, style: const TextStyle(fontSize: 12)),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = selected ? cat : null;
                      });
                      _performSearch(_searchController.text);
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          // Search Results List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _searchResults.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
                            const SizedBox(height: 12),
                            const Text('Besin bulunamadı', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 6),
                            const Text('Paket etiketinden yeni besin ekleyebilirsiniz.'),
                            const SizedBox(height: 14),
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const AddFoodScreen()),
                                ).then((_) => _performSearch(''));
                              },
                              icon: const Icon(Icons.add),
                              label: const Text('Yeni Besin Ekle'),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final food = _searchResults[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                            child: ListTile(
                              title: Text(food.nameTr, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Wrap(
                                  spacing: 6,
                                  runSpacing: 4,
                                  children: [
                                    CarbBadge(carbsG: food.carbsGPer100g, showExchange: false),
                                    VerificationBadge(status: food.verification),
                                    if (food.kcalPer100g > 0)
                                      Text(
                                        '${food.kcalPer100g.toStringAsFixed(0)} kcal',
                                        style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                                      ),
                                  ],
                                ),
                              ),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => FoodDetailScreen(food: food),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
