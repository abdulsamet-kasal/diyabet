import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobile/app.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('tr_TR', null);
  });

  testWidgets('GlikoRehber smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: GlikoRehberApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('GlikoRehber'), findsOneWidget);
    expect(find.text('HİPOGLİSEMİ YARDIMI (15-15)'), findsOneWidget);
  });
}
