import 'dart:convert';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:mobile/data/local/app_database.dart';
import 'package:mobile/data/services/data_export_service.dart';
import 'package:mobile/data/services/sync_service.dart';
import 'package:mobile/data/services/security_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/data/providers/app_providers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late DataExportService exportService;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    exportService = DataExportService(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Faz 8: KVKK / GDPR Veri Taşınabilirliği (JSON Export)', () {
    test('DataExportService tüm tabloları kapsayan yapılandırılmış JSON üretir', () async {
      // 1. Insert sample glucose and dose logs into test in-memory db
      await db.into(db.localGlucoseLogs).insert(
            LocalGlucoseLogsCompanion.insert(
              id: 'test_gluc_1',
              valueMgDl: 145.0,
              context: 'tokluk',
              measuredAt: DateTime.now(),
            ),
          );

      await db.into(db.localDoseLogs).insert(
            LocalDoseLogsCompanion.insert(
              id: 'test_dose_1',
              appliedUnits: 4.5,
              appliedAt: DateTime.now(),
              inputSnapshot: '{"carbs": 45}',
              resultSnapshot: '{"totalUnits": 4.5}',
              engineVersion: const Value('1.0.0'),
            ),
          );

      final jsonStr = await exportService.exportToJsonString(
        diabetesType: 'type1',
        glucoseUnit: 'mgdl',
        usesSyringe: false,
      );

      expect(jsonStr, isNotEmpty);
      final decoded = jsonDecode(jsonStr) as Map<String, dynamic>;

      expect(decoded.containsKey('metadata'), isTrue);
      expect(decoded['metadata']['app_name'], equals('GlikoRehber'));
      expect(decoded['profile']['diabetes_type'], equals('type1'));
      expect(decoded['glucose_logs'], isNotEmpty);
      expect(decoded['dose_logs_append_only'], isNotEmpty);
    });
  });

  group('Faz 8: Supabase Offline-First Sync Service', () {
    test('SyncService çevrimdışı modda zarifçe çalışır ve veri kaybetmez', () async {
      const syncService = SyncService(client: null);
      expect(syncService.isConnected, isFalse);

      final result = await syncService.syncAll(db: db);
      expect(result.isSuccess, isTrue);
      expect(result.isOffline, isTrue);
      expect(result.message, contains('Çevrimdışı'));
    });
  });

  group('Faz 8: KVKK Unutulma Hakkı & Kalıcı Veri Silme (Hard Delete)', () {
    test('hardDeleteAllUserData tüm kullanıcı sağlık tablolarını ve durumunu sıfırlar', () async {
      // Insert test data
      await db.into(db.localGlucoseLogs).insert(
            LocalGlucoseLogsCompanion.insert(
              id: 'del_gluc_1',
              valueMgDl: 120.0,
              context: 'aclik',
              measuredAt: DateTime.now(),
            ),
          );

      final initialLogs = await db.select(db.localGlucoseLogs).get();
      expect(initialLogs, isNotEmpty);

      // Create container with overridden databaseProvider
      final container = ProviderContainer(
        overrides: [
          databaseProvider.overrideWithValue(db),
        ],
      );
      addTearDown(container.dispose);

      // Execute hard delete
      await container.read(userProfileProvider.notifier).hardDeleteAllUserData();

      final remainingLogs = await db.select(db.localGlucoseLogs).get();
      expect(remainingLogs, isEmpty);

      final state = container.read(userProfileProvider);
      expect(state.therapySettings, isNull);
    });
  });

  group('Faz 8: Güvenlik Servisi', () {
    test('SecurityService başlatılabilir', () {
      final security = SecurityService();
      expect(security, isNotNull);
    });
  });
}
