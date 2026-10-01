import 'package:supabase_flutter/supabase_flutter.dart';
import '../local/app_database.dart';

class SyncResult {
  final bool isSuccess;
  final bool isOffline;
  final int syncedGlucoseCount;
  final int syncedDoseCount;
  final String message;

  const SyncResult({
    required this.isSuccess,
    this.isOffline = false,
    this.syncedGlucoseCount = 0,
    this.syncedDoseCount = 0,
    required this.message,
  });
}

class SyncService {
  final SupabaseClient? client;

  const SyncService({this.client});

  bool get isConnected => client != null && client!.auth.currentUser != null;

  Future<SyncResult> syncAll({required AppDatabase db}) async {
    if (client == null) {
      return const SyncResult(
        isSuccess: true,
        isOffline: true,
        message: 'Çevrimdışı mod etkin. Verileriniz SQLite yerel veritabanında güvende.',
      );
    }

    final user = client!.auth.currentUser;
    if (user == null) {
      return const SyncResult(
        isSuccess: false,
        isOffline: true,
        message: 'Giriş yapılmamış. Senkronizasyon için oturum açılması bekleniyor.',
      );
    }

    try {
      // 1. Fetch local glucose logs
      final localGlucose = await db.select(db.localGlucoseLogs).get();
      int glucoseSynced = 0;

      for (final g in localGlucose) {
        await client!.from('glucose_logs').upsert({
          'id': g.id,
          'user_id': user.id,
          'value_mgdl': g.valueMgDl,
          'context': g.context,
          'measured_at': g.measuredAt.toIso8601String(),
          'note': g.note,
        });
        glucoseSynced++;
      }

      // 2. Fetch local append-only dose logs (INSERT ONLY, do not delete/update)
      final localDoses = await db.select(db.localDoseLogs).get();
      int doseSynced = 0;

      for (final d in localDoses) {
        await client!.from('dose_logs').upsert({
          'id': d.id,
          'user_id': user.id,
          'input_snapshot': d.inputSnapshot,
          'result_snapshot': d.resultSnapshot,
          'engine_version': d.engineVersion,
          'applied_units': d.appliedUnits,
          'applied_at': d.appliedAt.toIso8601String(),
        });
        doseSynced++;
      }

      return SyncResult(
        isSuccess: true,
        isOffline: false,
        syncedGlucoseCount: glucoseSynced,
        syncedDoseCount: doseSynced,
        message: '$glucoseSynced glikoz ve $doseSynced doz kaydı başarıyla bulutla eşitlendi.',
      );
    } catch (e) {
      return SyncResult(
        isSuccess: false,
        isOffline: false,
        message: 'Senkronizasyon hatası: $e',
      );
    }
  }
}
