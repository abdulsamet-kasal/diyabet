import 'dart:convert';
import '../local/app_database.dart';

class DataExportService {
  final AppDatabase db;

  const DataExportService(this.db);

  Future<Map<String, dynamic>> exportAllUserData({
    required String diabetesType,
    required String glucoseUnit,
    required bool usesSyringe,
  }) async {
    // 1. Fetch therapy settings history
    final settingsList = await db.select(db.localTherapySettings).get();

    // 2. Fetch all glucose logs
    final glucoseList = await db.select(db.localGlucoseLogs).get();

    // 3. Fetch all dose logs
    final doseList = await db.select(db.localDoseLogs).get();

    // 4. Fetch consent logs
    final consentList = await db.select(db.localConsentLogs).get();

    return {
      'metadata': {
        'app_name': 'GlikoRehber',
        'export_date': DateTime.now().toIso8601String(),
        'schema_version': '1.0.0',
        'legal_framework': '6698 Sayılı KVKK Madde 11 & GDPR Article 20 (Veri Taşınabilirliği)',
      },
      'profile': {
        'diabetes_type': diabetesType,
        'glucose_unit': glucoseUnit,
        'uses_syringe': usesSyringe,
      },
      'consent_logs': consentList
          .map((c) => {
                'id': c.id,
                'type': c.type,
                'text_version': c.textVersion,
                'accepted_at': c.acceptedAt.toIso8601String(),
              })
          .toList(),
      'therapy_settings_history': settingsList
          .map((s) => {
                'id': s.id,
                'icr_blocks': s.icrBlocksJson,
                'default_icr': s.defaultIcr,
                'isf': s.isf,
                'target_glucose': s.targetGlucose,
                'dia_hours': s.diaHours,
                'dose_step': s.doseStep,
                'max_single_dose': s.maxSingleDose,
                'allow_negative_correction': s.allowNegativeCorrection,
                'subtract_fiber': s.subtractFiber,
                'confirmed_with_clinician': s.confirmedWithClinician,
                'created_at': s.createdAt.toIso8601String(),
              })
          .toList(),
      'glucose_logs': glucoseList
          .map((g) => {
                'id': g.id,
                'value_mgdl': g.valueMgDl,
                'context': g.context,
                'measured_at': g.measuredAt.toIso8601String(),
                'note': g.note,
              })
          .toList(),
      'dose_logs_append_only': doseList
          .map((d) => {
                'id': d.id,
                'input_snapshot': d.inputSnapshot,
                'result_snapshot': d.resultSnapshot,
                'engine_version': d.engineVersion,
                'applied_units': d.appliedUnits,
                'applied_at': d.appliedAt.toIso8601String(),
              })
          .toList(),
    };
  }

  Future<String> exportToJsonString({
    required String diabetesType,
    required String glucoseUnit,
    required bool usesSyringe,
  }) async {
    final map = await exportAllUserData(
      diabetesType: diabetesType,
      glucoseUnit: glucoseUnit,
      usesSyringe: usesSyringe,
    );
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(map);
  }
}
