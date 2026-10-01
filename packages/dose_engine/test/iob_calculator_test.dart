import 'package:test/test.dart';
import 'package:dose_engine/dose_engine.dart';

void main() {
  group('IOB Calculator and Linear Decay Invariants', () {
    final baseTime = DateTime(2026, 10, 1, 12, 0);

    test('IOB is 100% active immediately after injection', () {
      final dose = DoseLogEntry(
        units: 4.0,
        timestamp: baseTime,
        diaHours: 4.0,
      );

      final iob = dose.activeInsulinAt(baseTime);
      expect(iob, 4.0);
    });

    test('IOB decreases monotonically over time', () {
      final dose = DoseLogEntry(
        units: 4.0,
        timestamp: baseTime,
        diaHours: 4.0,
      );

      double previousIob = 4.0;
      for (int minutes = 15; minutes <= 240; minutes += 15) {
        final checkTime = baseTime.add(Duration(minutes: minutes));
        final currentIob = dose.activeInsulinAt(checkTime);

        expect(currentIob, lessThanOrEqualTo(previousIob));
        expect(currentIob, greaterThanOrEqualTo(0.0));
        previousIob = currentIob;
      }
    });

    test('IOB is exactly half at half DIA', () {
      final dose = DoseLogEntry(
        units: 6.0,
        timestamp: baseTime,
        diaHours: 4.0,
      );

      final midTime = baseTime.add(const Duration(hours: 2));
      final iob = dose.activeInsulinAt(midTime);
      expect(iob, 3.0);
    });

    test('IOB is 0 after DIA duration elapses', () {
      final dose = DoseLogEntry(
        units: 5.0,
        timestamp: baseTime,
        diaHours: 3.5,
      );

      final afterDia = baseTime.add(const Duration(hours: 3, minutes: 31));
      final iob = dose.activeInsulinAt(afterDia);
      expect(iob, 0.0);
    });

    test('Multiple recent doses are aggregated correctly', () {
      final doses = [
        DoseLogEntry(
          units: 2.0,
          timestamp: baseTime.subtract(const Duration(hours: 1)),
          diaHours: 4.0, // Remaining: 2.0 * (1 - 1/4) = 1.5 U
        ),
        DoseLogEntry(
          units: 4.0,
          timestamp: baseTime.subtract(const Duration(hours: 2)),
          diaHours: 4.0, // Remaining: 4.0 * (1 - 2/4) = 2.0 U
        ),
      ];

      final totalIob = IobCalculator.calculateTotalIob(
        recentDoses: doses,
        now: baseTime,
      );

      expect(totalIob, 3.5); // 1.5 + 2.0 = 3.5 U
    });
  });
}
