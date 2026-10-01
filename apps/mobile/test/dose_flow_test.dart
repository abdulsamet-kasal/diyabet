import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/native.dart';
import 'package:dose_engine/dose_engine.dart';
import 'package:mobile/data/local/app_database.dart';
import 'package:mobile/data/providers/app_providers.dart';
import 'package:mobile/features/dose_calculator/presentation/dose_calculator_screen.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  testWidgets('DoseCalculatorScreen locks when user is under 18', (tester) async {
    final container = ProviderContainer(
      overrides: [
        databaseProvider.overrideWithValue(db),
      ],
    );
    container.read(userProfileProvider.notifier).setAgeOver18(false);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: DoseCalculatorScreen(),
        ),
      ),
    );

    expect(find.text('Doz Hesaplayıcı Kilitli'), findsOneWidget);
    expect(find.text('18 yaş altı kullanıcılar için v1 sürümünde doz hesaplama özelliği devre dışıdır.'), findsOneWidget);
  });

  testWidgets('DoseCalculatorScreen calculates dose when settings are present', (tester) async {
    final container = ProviderContainer(
      overrides: [
        databaseProvider.overrideWithValue(db),
      ],
    );
    container.read(userProfileProvider.notifier).setAgeOver18(true);
    container.read(userProfileProvider.notifier).setDiabetesType('type1');

    const settings = TherapySettings(
      defaultIcr: 10.0,
      isf: 40.0,
      targetGlucose: 100.0,
      doseStep: 0.5,
      maxSingleDose: 15.0,
      confirmedWithClinician: true,
    );
    await container.read(userProfileProvider.notifier).updateTherapySettings(settings);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: DoseCalculatorScreen(),
        ),
      ),
    );

    // Enter 45g carbs
    await tester.enterText(find.byType(TextFormField).first, '45');
    await tester.tap(find.text('Doz Önerisini Hesapla'));
    await tester.pumpAndSettle();

    // Expect 4.5 U
    expect(find.text('4.5'), findsOneWidget);
    expect(find.text('Uyguladım ve Günlüğe Kaydet'), findsOneWidget);
  });
}
