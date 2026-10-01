import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:dose_engine/dose_engine.dart';
import '../local/app_database.dart';

class DoseRepository {
  final AppDatabase db;

  DoseRepository({required this.db});

  static int _idCounter = 0;

  /// Records an administered insulin dose (strictly append-only).
  Future<void> logAppliedDose({
    required double appliedUnits,
    required DateTime appliedAt,
    required Map<String, dynamic> inputSnapshot,
    required Map<String, dynamic> resultSnapshot,
    String engineVersion = '1.0.0',
  }) async {
    final uniqueId = '${DateTime.now().microsecondsSinceEpoch}_${_idCounter++}';
    await db.into(db.localDoseLogs).insert(
          LocalDoseLogsCompanion.insert(
            id: uniqueId,
            appliedUnits: appliedUnits,
            appliedAt: appliedAt,
            inputSnapshot: jsonEncode(inputSnapshot),
            resultSnapshot: jsonEncode(resultSnapshot),
            engineVersion: Value(engineVersion),
          ),
        );
  }

  /// Fetches recent doses administered within the DIA hours window for IOB calculation.
  Future<List<DoseLogEntry>> getRecentDosesForIob({
    required DateTime now,
    required double maxDiaHours,
  }) async {
    final earliestTime = now.subtract(Duration(minutes: (maxDiaHours * 60).ceil()));

    final rows = await (db.select(db.localDoseLogs)
          ..where((t) => t.appliedAt.isBiggerOrEqualValue(earliestTime))
          ..orderBy([(t) => OrderingTerm.desc(t.appliedAt)]))
        .get();

    return rows.map((r) {
      double dia = maxDiaHours;
      try {
        final snap = jsonDecode(r.inputSnapshot) as Map<String, dynamic>;
        final diaVal = snap['diaHours'];
        if (diaVal is num && diaVal > 0) {
          dia = diaVal.toDouble();
        }
      } catch (_) {}

      return DoseLogEntry(
        units: r.appliedUnits,
        timestamp: r.appliedAt,
        diaHours: dia,
      );
    }).toList();
  }

  /// Gets recent dose logs for review and doctor report.
  Future<List<LocalDoseLog>> getRecentDoseLogs({int limit = 50}) async {
    return (db.select(db.localDoseLogs)
          ..orderBy([(t) => OrderingTerm.desc(t.appliedAt)])
          ..limit(limit))
        .get();
  }
}
