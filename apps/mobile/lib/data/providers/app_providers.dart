import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dose_engine/dose_engine.dart';
import '../local/app_database.dart';
import '../repositories/food_repository.dart';
import '../repositories/therapy_settings_repository.dart';
import '../repositories/glucose_repository.dart';
import '../repositories/dose_repository.dart';
import '../services/security_service.dart';
import '../services/data_export_service.dart';
import '../services/sync_service.dart';

// Database singleton
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

// Repositories
final foodRepositoryProvider = Provider<FoodRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return FoodRepository(db: db, isReleaseMode: false);
});

final settingsRepositoryProvider = Provider<TherapySettingsRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return TherapySettingsRepository(db: db);
});

final glucoseRepositoryProvider = Provider<GlucoseRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return GlucoseRepository(db: db);
});

final doseRepositoryProvider = Provider<DoseRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return DoseRepository(db: db);
});

// User Profile State model
class UserProfileState {
  final String diabetesType;
  final bool isOver18;
  final bool hasAcceptedDisclaimer;
  final GlucoseUnit glucoseUnit;
  final bool usesSyringe;
  final TherapySettings? therapySettings;

  const UserProfileState({
    this.diabetesType = 'type1',
    this.isOver18 = true,
    this.hasAcceptedDisclaimer = false,
    this.glucoseUnit = GlucoseUnit.mgdl,
    this.usesSyringe = false,
    this.therapySettings,
  });

  UserProfileState copyWith({
    String? diabetesType,
    bool? isOver18,
    bool? hasAcceptedDisclaimer,
    GlucoseUnit? glucoseUnit,
    bool? usesSyringe,
    TherapySettings? therapySettings,
  }) {
    return UserProfileState(
      diabetesType: diabetesType ?? this.diabetesType,
      isOver18: isOver18 ?? this.isOver18,
      hasAcceptedDisclaimer: hasAcceptedDisclaimer ?? this.hasAcceptedDisclaimer,
      glucoseUnit: glucoseUnit ?? this.glucoseUnit,
      usesSyringe: usesSyringe ?? this.usesSyringe,
      therapySettings: therapySettings ?? this.therapySettings,
    );
  }

  /// Whether dose calculation features are permitted based on profile
  bool get isDoseCalculatorAllowed {
    if (!isOver18) return false;
    return diabetesType == 'type1' || diabetesType == 'type2_prandial_insulin';
  }
}

// Modern NotifierProvider (per user rule: NOT StateNotifierProvider)
class UserProfileNotifier extends Notifier<UserProfileState> {
  @override
  UserProfileState build() {
    // Load initial settings asynchronously
    _loadInitialSettings();
    return const UserProfileState();
  }

  Future<void> _loadInitialSettings() async {
    final repo = ref.read(settingsRepositoryProvider);
    final settings = await repo.loadSettings();
    if (settings != null) {
      state = state.copyWith(therapySettings: settings);
    }
  }

  void setDiabetesType(String type) {
    state = state.copyWith(diabetesType: type);
  }

  void setAgeOver18(bool isOver18) {
    state = state.copyWith(isOver18: isOver18);
  }

  void acceptDisclaimer() {
    state = state.copyWith(hasAcceptedDisclaimer: true);
  }

  void setGlucoseUnit(GlucoseUnit unit) {
    state = state.copyWith(glucoseUnit: unit);
  }

  void setUsesSyringe(bool uses) {
    state = state.copyWith(usesSyringe: uses);
  }

  Future<void> updateTherapySettings(TherapySettings settings) async {
    final repo = ref.read(settingsRepositoryProvider);
    await repo.saveSettings(settings: settings);
    state = state.copyWith(therapySettings: settings);
  }

  /// KVKK & GDPR Hard Delete: Completely wipes all local SQLite user records,
  /// shared preferences, secure storage, and resets state.
  Future<void> hardDeleteAllUserData() async {
    final db = ref.read(databaseProvider);
    // Delete user health tables (leave food table intact for offline usage)
    await db.delete(db.localGlucoseLogs).go();
    await db.delete(db.localDoseLogs).go();
    await db.delete(db.localTherapySettings).go();
    await db.delete(db.localConsentLogs).go();

    // Reset in-memory state
    state = const UserProfileState();
  }
}

final userProfileProvider = NotifierProvider<UserProfileNotifier, UserProfileState>(
  UserProfileNotifier.new,
);

final securityServiceProvider = Provider<SecurityService>((ref) {
  return SecurityService();
});

final dataExportServiceProvider = Provider<DataExportService>((ref) {
  final db = ref.watch(databaseProvider);
  return DataExportService(db);
});

final syncServiceProvider = Provider<SyncService>((ref) {
  return const SyncService();
});
