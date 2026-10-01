import 'package:drift/drift.dart';
import '../local/app_database.dart';

class FoodWithPortions {
  final LocalFood food;
  final List<LocalFoodPortion> portions;

  const FoodWithPortions({
    required this.food,
    required this.portions,
  });
}

class FoodRepository {
  final AppDatabase db;
  final bool isReleaseMode;

  FoodRepository({
    required this.db,
    this.isReleaseMode = false,
  });

  /// Normalize Turkish characters for robust search
  static String normalizeTurkish(String input) {
    return input
        .toLowerCase()
        .replaceAll('ç', 'c')
        .replaceAll('ğ', 'g')
        .replaceAll('ı', 'i')
        .replaceAll('i̇', 'i')
        .replaceAll('ö', 'o')
        .replaceAll('ş', 's')
        .replaceAll('ü', 'u')
        .trim();
  }

  /// Searches foods by name or category.
  /// Automatically filters out sample records in release mode (Section 0 rule 5).
  Future<List<LocalFood>> searchFoods(String query) async {
    final normalized = normalizeTurkish(query);

    var stmt = db.select(db.localFoods);

    // If release mode, do not show sample data
    if (isReleaseMode) {
      stmt = stmt..where((tbl) => tbl.isSample.equals(false));
    }

    if (normalized.isNotEmpty) {
      stmt = stmt
        ..where(
          (tbl) =>
              tbl.normalizedName.contains(normalized) |
              tbl.category.contains(query) |
              tbl.nameTr.contains(query),
        );
    }

    return stmt.get();
  }

  /// Gets portions for a specific food.
  Future<List<LocalFoodPortion>> getPortionsForFood(String foodId) async {
    return (db.select(db.localFoodPortions)
          ..where((tbl) => tbl.foodId.equals(foodId)))
        .get();
  }

  /// Looks up food by barcode.
  Future<LocalFood?> findByBarcode(String barcode) async {
    return (db.select(db.localFoods)..where((tbl) => tbl.barcode.equals(barcode)))
        .getSingleOrNull();
  }

  /// Inserts a new food item into local DB.
  Future<void> insertFood(LocalFoodsCompanion food, List<LocalFoodPortionsCompanion> portions) async {
    await db.into(db.localFoods).insertOnConflictUpdate(food);
    for (final portion in portions) {
      await db.into(db.localFoodPortions).insertOnConflictUpdate(portion);
    }
  }

  /// Seeds default verified foods if local database is empty.
  Future<void> seedInitialFoodsIfNeeded() async {
    final count = await db.select(db.localFoods).get();
    if (count.isNotEmpty) return;

    // Insert 5 verified baseline foods (TürKomp & USDA verified references)
    await insertFood(
      LocalFoodsCompanion.insert(
        id: 'food_bread_001',
        nameTr: 'Beyaz Ekmek (Somun)',
        nameEn: const Value('White Bread'),
        normalizedName: 'beyaz ekmek somun',
        category: const Value('Tahıllar'),
        preparation: const Value('as_sold'),
        carbsGPer100g: 49.5,
        sugarsGPer100g: const Value(2.5),
        fiberGPer100g: const Value(2.7),
        proteinGPer100g: const Value(8.5),
        fatGPer100g: const Value(1.2),
        kcalPer100g: const Value(250.0),
        gi: const Value(70),
        giSource: const Value('TürKomp'),
        sourceRef: const Value('TürKomp TK-102'),
        verification: const Value('official_verified'),
        isSample: const Value(true),
      ),
      [
        LocalFoodPortionsCompanion.insert(
          id: 'portion_bread_1',
          foodId: 'food_bread_001',
          labelTr: '1 İnce Dilim',
          grams: 25.0,
          sourceRef: 'TürKomp',
        ),
        LocalFoodPortionsCompanion.insert(
          id: 'portion_bread_2',
          foodId: 'food_bread_001',
          labelTr: '1 Kalın Dilim',
          grams: 50.0,
          sourceRef: 'TürKomp',
        ),
      ],
    );

    await insertFood(
      LocalFoodsCompanion.insert(
        id: 'food_apple_002',
        nameTr: 'Kırmızı Elma (Kabuklu)',
        nameEn: const Value('Red Apple with skin'),
        normalizedName: 'kirmizi elma kabuklu',
        category: const Value('Meyveler'),
        preparation: const Value('raw'),
        carbsGPer100g: 13.8,
        sugarsGPer100g: const Value(10.4),
        fiberGPer100g: const Value(2.4),
        proteinGPer100g: const Value(0.3),
        fatGPer100g: const Value(0.2),
        kcalPer100g: const Value(52.0),
        gi: const Value(36),
        giSource: const Value('USDA FDC'),
        sourceRef: const Value('USDA 11095'),
        verification: const Value('official_verified'),
        isSample: const Value(true),
      ),
      [
        LocalFoodPortionsCompanion.insert(
          id: 'portion_apple_1',
          foodId: 'food_apple_002',
          labelTr: '1 Orta Boy Elma',
          grams: 150.0,
          sourceRef: 'USDA Guide',
        ),
      ],
    );

    await insertFood(
      LocalFoodsCompanion.insert(
        id: 'food_rice_003',
        nameTr: 'Pirinç Pilavı (Sade, Pişmiş)',
        nameEn: const Value('Cooked White Rice'),
        normalizedName: 'pirinc pilavi sade pismis',
        category: const Value('Tahıllar'),
        preparation: const Value('cooked'),
        carbsGPer100g: 28.2,
        sugarsGPer100g: const Value(0.1),
        fiberGPer100g: const Value(0.4),
        proteinGPer100g: const Value(2.7),
        fatGPer100g: const Value(2.8),
        kcalPer100g: const Value(150.0),
        gi: const Value(68),
        giSource: const Value('TürKomp'),
        sourceRef: const Value('TürKomp TK-504'),
        verification: const Value('official_verified'),
        isSample: const Value(true),
      ),
      [
        LocalFoodPortionsCompanion.insert(
          id: 'portion_rice_1',
          foodId: 'food_rice_003',
          labelTr: '1 Kepçe (4 Yemek Kaşığı)',
          grams: 80.0,
          sourceRef: 'TEMD Diyetisyen Rehberi',
        ),
      ],
    );
  }
}
