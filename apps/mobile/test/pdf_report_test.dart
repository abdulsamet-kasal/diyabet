import 'package:flutter_test/flutter_test.dart';
import 'package:dose_engine/dose_engine.dart';
import 'package:mobile/data/local/app_database.dart';
import 'package:mobile/data/services/pdf_report_service.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  test('PdfReportService generates valid PDF bytes with settings and logs', () async {
    const settings = TherapySettings(
      defaultIcr: 10.0,
      isf: 40.0,
      targetGlucose: 100.0,
      diaHours: 4.0,
      doseStep: 0.5,
      maxSingleDose: 15.0,
      confirmedWithClinician: true,
    );

    final now = DateTime.now();
    final glucoseLogs = [
      LocalGlucoseLog(
        id: '1',
        valueMgDl: 120.0,
        context: 'fasting',
        measuredAt: now,
        note: 'Sabah açlık',
      ),
      LocalGlucoseLog(
        id: '2',
        valueMgDl: 165.0,
        context: 'postprandial',
        measuredAt: now,
      ),
    ];

    final doseLogs = [
      LocalDoseLog(
        id: '1',
        appliedUnits: 4.5,
        appliedAt: now,
        inputSnapshot: '{}',
        resultSnapshot: '{}',
        engineVersion: '1.0.0',
      ),
    ];

    final bytes = await PdfReportService.generatePhysicianReport(
      diabetesType: 'type1',
      unit: GlucoseUnit.mgdl,
      settings: settings,
      glucoseLogs: glucoseLogs,
      doseLogs: doseLogs,
      tirPercentage: 0.85,
    );

    expect(bytes, isNotEmpty);
    expect(bytes.length, greaterThan(1000)); // Non-trivial PDF output
  });
}
