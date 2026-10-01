import 'package:drift/drift.dart';
import '../local/app_database.dart';

class GlucoseRepository {
  final AppDatabase db;

  GlucoseRepository({required this.db});

  static int _idCounter = 0;

  /// Adds a new blood glucose reading.
  Future<void> addGlucoseLog({
    required double valueMgDl,
    required String context,
    required DateTime measuredAt,
    String? note,
  }) async {
    final uniqueId = '${DateTime.now().microsecondsSinceEpoch}_${_idCounter++}';
    await db.into(db.localGlucoseLogs).insert(
          LocalGlucoseLogsCompanion.insert(
            id: uniqueId,
            valueMgDl: valueMgDl,
            context: context,
            measuredAt: measuredAt,
            note: Value(note),
          ),
        );
  }

  /// Gets recent glucose logs sorted descending.
  Future<List<LocalGlucoseLog>> getRecentLogs({int limit = 50}) async {
    return (db.select(db.localGlucoseLogs)
          ..orderBy([(t) => OrderingTerm.desc(t.measuredAt)])
          ..limit(limit))
        .get();
  }

  /// Calculates Time-in-Range (TIR) between [minTarget] and [maxTarget] (default 70-180 mg/dL).
  Future<double> calculateTimeInRange({
    double minTarget = 70.0,
    double maxTarget = 180.0,
  }) async {
    final logs = await getRecentLogs(limit: 100);
    if (logs.isEmpty) return 0.0;

    int inRangeCount = 0;
    for (final log in logs) {
      if (log.valueMgDl >= minTarget && log.valueMgDl <= maxTarget) {
        inRangeCount++;
      }
    }
    return inRangeCount / logs.length;
  }
}
