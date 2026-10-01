import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dose_engine/dose_engine.dart';
import 'package:mobile/core/widgets/glucose_chip.dart';
import 'package:mobile/core/widgets/carb_badge.dart';
import 'package:mobile/core/widgets/verification_badge.dart';
import 'package:mobile/core/widgets/warning_banner.dart';
import 'package:mobile/core/widgets/numeric_field.dart';
import 'package:mobile/core/widgets/dose_result_card.dart';

void main() {
  testWidgets('GlucoseChip displays accessible icon, text, and value', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              GlucoseChip(valueMgDl: 65.0),
              GlucoseChip(valueMgDl: 110.0),
              GlucoseChip(valueMgDl: 220.0),
            ],
          ),
        ),
      ),
    );

    expect(find.text('65 mg/dL'), findsOneWidget);
    expect(find.text('(Düşük)'), findsOneWidget);

    expect(find.text('110 mg/dL'), findsOneWidget);
    expect(find.text('(Hedefte)'), findsOneWidget);

    expect(find.text('220 mg/dL'), findsOneWidget);
    expect(find.text('(Yüksek)'), findsOneWidget);
  });

  testWidgets('CarbBadge displays grams and exchanges', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CarbBadge(carbsG: 30.0),
        ),
      ),
    );

    expect(find.text('30.0 g Karb'), findsOneWidget);
    expect(find.text('(2.0 Değişim)'), findsOneWidget);
  });

  testWidgets('VerificationBadge displays proper status', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              VerificationBadge(status: 'official_verified'),
              VerificationBadge(status: 'community_unverified'),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Resmi Onaylı'), findsOneWidget);
    expect(find.text('Doğrulanmamış (Topluluk)'), findsOneWidget);
  });

  testWidgets('NumericField parses Turkish comma and dot', (tester) async {
    expect(NumericField.parseTurkishDouble('45,5'), 45.5);
    expect(NumericField.parseTurkishDouble('45.5'), 45.5);
    expect(NumericField.parseTurkishDouble('   120  '), 120.0);
    expect(NumericField.parseTurkishDouble('invalid'), isNull);
  });

  testWidgets('DoseResultCard displays formula breakdown and units', (tester) async {
    const result = DoseResult(
      status: DoseStatus.success,
      roundedUnits: 5.5,
      rawUnits: 5.5,
      mealUnits: 4.5,
      correctionUnits: 1.0,
      breakdown: [
        'Öğün: 45g ÷ 10 = 4.5 U',
        'Düzeltme: (180 - 100) ÷ 40 = 2.0 U - 1.0 IOB = 1.0 U',
      ],
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DoseResultCard(result: result),
        ),
      ),
    );

    expect(find.text('5.5'), findsOneWidget);
    expect(find.text('Ünite (U)'), findsOneWidget);
    expect(find.text('• Öğün: 45g ÷ 10 = 4.5 U'), findsNothing); // format in breakdown
    expect(find.text('Öğün: 45g ÷ 10 = 4.5 U'), findsOneWidget);
  });

  testWidgets('WarningBanner displays title and message with accessible level', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: WarningBanner(
            title: 'Kritik Uyarı',
            message: '15-15 Kuralını uygulayınız.',
            level: WarningLevel.critical,
          ),
        ),
      ),
    );

    expect(find.text('Kritik Uyarı'), findsOneWidget);
    expect(find.text('15-15 Kuralını uygulayınız.'), findsOneWidget);
  });
}
