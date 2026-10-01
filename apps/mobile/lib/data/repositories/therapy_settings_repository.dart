import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:dose_engine/dose_engine.dart';
import '../local/app_database.dart';

class TherapySettingsRepository {
  final AppDatabase db;

  TherapySettingsRepository({required this.db});

  /// Loads current active therapy settings, or null if unconfigured.
  Future<TherapySettings?> loadSettings() async {
    final entry = await (db.select(db.localTherapySettings)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(1))
        .getSingleOrNull();

    if (entry == null) return null;

    final icrBlocks = <IcrBlock>[];
    try {
      final List<dynamic> list = jsonDecode(entry.icrBlocksJson) as List<dynamic>;
      for (final item in list) {
        if (item is Map<String, dynamic>) {
          icrBlocks.add(
            IcrBlock(
              from: item['from'] as String,
              to: item['to'] as String,
              gPerUnit: (item['gPerUnit'] as num).toDouble(),
            ),
          );
        }
      }
    } catch (_) {}

    return TherapySettings(
      icrBlocks: icrBlocks,
      defaultIcr: entry.defaultIcr,
      isf: entry.isf,
      targetGlucose: entry.targetGlucose,
      diaHours: entry.diaHours,
      doseStep: entry.doseStep,
      maxSingleDose: entry.maxSingleDose,
      allowNegativeCorrection: entry.allowNegativeCorrection,
      subtractFiber: entry.subtractFiber,
      confirmedWithClinician: entry.confirmedWithClinician,
    );
  }

  /// Saves a new version of therapy settings (preserves versioned history).
  Future<void> saveSettings({
    required TherapySettings settings,
  }) async {
    final blocksJson = jsonEncode(
      settings.icrBlocks
          .map((b) => {'from': b.from, 'to': b.to, 'gPerUnit': b.gPerUnit})
          .toList(),
    );

    await db.into(db.localTherapySettings).insert(
          LocalTherapySettingsCompanion.insert(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            icrBlocksJson: Value(blocksJson),
            defaultIcr: Value(settings.defaultIcr),
            isf: Value(settings.isf),
            targetGlucose: Value(settings.targetGlucose),
            diaHours: Value(settings.diaHours),
            doseStep: Value(settings.doseStep),
            maxSingleDose: Value(settings.maxSingleDose),
            allowNegativeCorrection: Value(settings.allowNegativeCorrection),
            subtractFiber: Value(settings.subtractFiber),
            confirmedWithClinician: Value(settings.confirmedWithClinician),
            createdAt: Value(DateTime.now()),
          ),
        );
  }
}
