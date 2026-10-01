import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

// 1. Food Table
class LocalFoods extends Table {
  TextColumn get id => text()();
  TextColumn get nameTr => text()();
  TextColumn get nameEn => text().nullable()();
  TextColumn get normalizedName => text()();
  TextColumn get category => text().nullable()();
  TextColumn get brand => text().nullable()();
  TextColumn get barcode => text().nullable()();
  TextColumn get preparation => text().withDefault(const Constant('as_sold'))();
  RealColumn get carbsGPer100g => real()();
  RealColumn get sugarsGPer100g => real().nullable()();
  RealColumn get fiberGPer100g => real().nullable()();
  RealColumn get proteinGPer100g => real().withDefault(const Constant(0.0))();
  RealColumn get fatGPer100g => real().withDefault(const Constant(0.0))();
  RealColumn get kcalPer100g => real().withDefault(const Constant(0.0))();
  IntColumn get gi => integer().nullable()();
  TextColumn get giSource => text().nullable()();
  TextColumn get sourceRef => text().nullable()();
  TextColumn get verification => text().withDefault(const Constant('community_unverified'))();
  BoolColumn get isSample => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// 2. Food Portions Table
class LocalFoodPortions extends Table {
  TextColumn get id => text()();
  TextColumn get foodId => text()();
  TextColumn get labelTr => text()();
  RealColumn get grams => real()();
  TextColumn get sourceRef => text()();

  @override
  Set<Column> get primaryKey => {id};
}

// 3. Glucose Logs Table
class LocalGlucoseLogs extends Table {
  TextColumn get id => text()();
  RealColumn get valueMgDl => real()();
  TextColumn get context => text()();
  DateTimeColumn get measuredAt => dateTime()();
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 4. Dose Logs Table (Append-only)
class LocalDoseLogs extends Table {
  TextColumn get id => text()();
  RealColumn get appliedUnits => real()();
  DateTimeColumn get appliedAt => dateTime()();
  TextColumn get inputSnapshot => text()();
  TextColumn get resultSnapshot => text()();
  TextColumn get engineVersion => text().withDefault(const Constant('1.0.0'))();

  @override
  Set<Column> get primaryKey => {id};
}

// 5. Consent Logs Table (Append-only)
class LocalConsentLogs extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()();
  TextColumn get textVersion => text()();
  DateTimeColumn get acceptedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// 6. Therapy Settings Table
class LocalTherapySettings extends Table {
  TextColumn get id => text()();
  TextColumn get icrBlocksJson => text().withDefault(const Constant('[]'))();
  RealColumn get defaultIcr => real().nullable()();
  RealColumn get isf => real().nullable()();
  RealColumn get targetGlucose => real().nullable()();
  RealColumn get diaHours => real().nullable()();
  RealColumn get doseStep => real().withDefault(const Constant(0.5))();
  RealColumn get maxSingleDose => real().withDefault(const Constant(15.0))();
  BoolColumn get allowNegativeCorrection => boolean().withDefault(const Constant(false))();
  BoolColumn get subtractFiber => boolean().withDefault(const Constant(false))();
  BoolColumn get confirmedWithClinician => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [
  LocalFoods,
  LocalFoodPortions,
  LocalGlucoseLogs,
  LocalDoseLogs,
  LocalConsentLogs,
  LocalTherapySettings,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 1;

  // Insert verified initial sample foods if database is empty
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'glikorehber.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
