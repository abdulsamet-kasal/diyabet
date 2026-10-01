import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:dose_engine/dose_engine.dart';
import 'package:mobile/data/local/app_database.dart';
import 'package:mobile/data/repositories/food_repository.dart';
import 'package:mobile/data/repositories/therapy_settings_repository.dart';
import 'package:mobile/data/repositories/glucose_repository.dart';
import 'package:mobile/data/repositories/dose_repository.dart';

void main() {
  late AppDatabase db;
  late FoodRepository foodRepo;
  late TherapySettingsRepository settingsRepo;
  late GlucoseRepository glucoseRepo;
  late DoseRepository doseRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    foodRepo = FoodRepository(db: db, isReleaseMode: false);
    settingsRepo = TherapySettingsRepository(db: db);
    glucoseRepo = GlucoseRepository(db: db);
    doseRepo = DoseRepository(db: db);
  });

  tearDown(() async {
    await db.close();
  });

  test('Food repository seeds and searches foods with Turkish normalization', () async {
    await foodRepo.seedInitialFoodsIfNeeded();

    // Search with Turkish chars: 'ekmek'
    final ekmekResults = await foodRepo.searchFoods('ekmek');
    expect(ekmekResults, isNotEmpty);
    expect(ekmekResults.first.nameTr, contains('Beyaz Ekmek'));

    // Search normalized: 'elma'
    final elmaResults = await foodRepo.searchFoods('elma');
    expect(elmaResults, isNotEmpty);
    expect(elmaResults.first.nameTr, contains('Elma'));

    // Portions lookup
    final portions = await foodRepo.getPortionsForFood(ekmekResults.first.id);
    expect(portions, isNotEmpty);
    expect(portions.first.grams, greaterThan(0));
  });

  test('Release mode filters out is_sample food items', () async {
    await foodRepo.seedInitialFoodsIfNeeded();

    final releaseRepo = FoodRepository(db: db, isReleaseMode: true);
    final results = await releaseRepo.searchFoods('ekmek');
    expect(results, isEmpty); // Sample records must be hidden in release
  });

  test('Therapy settings repository saves and loads versioned settings', () async {
    const settings = TherapySettings(
      defaultIcr: 10.0,
      isf: 40.0,
      targetGlucose: 100.0,
      diaHours: 3.5,
      doseStep: 0.5,
      maxSingleDose: 15.0,
      confirmedWithClinician: true,
    );

    await settingsRepo.saveSettings(settings: settings);

    final loaded = await settingsRepo.loadSettings();
    expect(loaded, isNotNull);
    expect(loaded!.defaultIcr, 10.0);
    expect(loaded.isf, 40.0);
    expect(loaded.doseStep, 0.5);
    expect(loaded.confirmedWithClinician, isTrue);
  });

  test('Glucose repository logs values and calculates TIR', () async {
    final now = DateTime.now();
    await glucoseRepo.addGlucoseLog(valueMgDl: 110.0, context: 'fasting', measuredAt: now);
    await glucoseRepo.addGlucoseLog(valueMgDl: 150.0, context: 'postprandial', measuredAt: now);
    await glucoseRepo.addGlucoseLog(valueMgDl: 60.0, context: 'other', measuredAt: now); // low
    await glucoseRepo.addGlucoseLog(valueMgDl: 220.0, context: 'other', measuredAt: now); // high

    final logs = await glucoseRepo.getRecentLogs();
    expect(logs.length, 4);

    // 2 out of 4 are in range (70 - 180) -> 50%
    final tir = await glucoseRepo.calculateTimeInRange();
    expect(tir, 0.5);
  });

  test('Dose repository stores append-only logs and retrieves recent doses for IOB', () async {
    final now = DateTime.now();

    await doseRepo.logAppliedDose(
      appliedUnits: 3.5,
      appliedAt: now.subtract(const Duration(hours: 1)),
      inputSnapshot: {'diaHours': 4.0, 'totalCarbsG': 35.0},
      resultSnapshot: {'roundedUnits': 3.5},
    );

    final recentDoses = await doseRepo.getRecentDosesForIob(now: now, maxDiaHours: 4.0);
    expect(recentDoses.length, 1);
    expect(recentDoses.first.units, 3.5);
    expect(recentDoses.first.diaHours, 4.0);
  });
}
