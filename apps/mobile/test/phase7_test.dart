import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile/features/education/data/education_articles_data.dart';
import 'package:mobile/features/education/presentation/education_screen.dart';
import 'package:mobile/features/education/presentation/article_detail_screen.dart';
import 'package:mobile/features/emergency/presentation/emergency_screen.dart';
import 'package:mobile/features/reminders/data/reminder_notifier.dart';
import 'package:mobile/features/reminders/domain/reminder_item.dart';
import 'package:mobile/features/reminders/presentation/reminders_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('Faz 7: Eğitim Modülü Testleri', () {
    test('Eğitim makaleleri veri seti eksiksiz ve taslak rozetine sahip', () {
      expect(EducationArticlesData.articles.length, greaterThanOrEqualTo(8));
      for (final article in EducationArticlesData.articles) {
        expect(article.isDraft, isTrue); // Klinik onay yapılana kadar TASLAK
        expect(article.sources, isNotEmpty); // Kaynak rehberler tanımlı
      }
    });

    testWidgets('EducationScreen makaleleri listeler ve TASLAK rozetlerini gösterir',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: EducationScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Diyabet Eğitim Rehberi'), findsOneWidget);
      expect(find.text('TASLAK'), findsWidgets);
      expect(find.text('15-15 Kuralı ile Hipoglisemi Yönetimi'), findsOneWidget);
    });

    testWidgets('ArticleDetailScreen klinik uyarı ve kaynakları eksiksiz gösterir',
        (tester) async {
      tester.view.physicalSize = const Size(800, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final article = EducationArticlesData.articles.first;
      await tester.pumpWidget(
        MaterialApp(
          home: ArticleDetailScreen(article: article),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('TASLAK İÇERİK'), findsOneWidget);
      expect(find.text('Tıbbi Kaynaklar ve Rehberler'), findsOneWidget);
      expect(find.text(article.titleTr), findsNWidgets(2)); // AppBar and Body
    });
  });

  group('Faz 7: Acil Durum & 15-15 Kuralı Testleri', () {
    testWidgets('EmergencyScreen 15-15 adımlarını, 112 butonunu ve sayacı içerir',
        (tester) async {
      tester.view.physicalSize = const Size(800, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: EmergencyScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('15-15'), findsWidgets);
      expect(find.text('ACİL ÇAĞRI: 112\'Yİ ARA'), findsOneWidget);
      expect(find.textContaining('Bilinç Kaybı / Glukagon'), findsOneWidget);
      expect(find.text('15:00'), findsOneWidget); // 15 dk başlangıç
    });
  });

  group('Faz 7: Hatırlatıcılar Testleri', () {
    test('ReminderNotifier varsayılan hatırlatıcıları yükler ve işlem yapar', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final initial = container.read(reminderProvider);
      expect(initial.length, greaterThanOrEqualTo(3));

      // Toggle reminder
      final firstId = initial.first.id;
      final initialStatus = initial.first.isEnabled;
      await container.read(reminderProvider.notifier).toggleReminder(firstId);

      final updated = container.read(reminderProvider);
      expect(updated.firstWhere((e) => e.id == firstId).isEnabled, !initialStatus);

      // Add post-meal reminder
      final mealTime = DateTime(2026, 10, 1, 12, 0);
      await container.read(reminderProvider.notifier).schedulePostMealReminder(mealTime);

      final withPost = container.read(reminderProvider);
      expect(withPost.any((e) => e.type == ReminderType.postPrandial && e.hour == 14), isTrue);
    });

    testWidgets('RemindersScreen hatırlatıcıları listeler', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RemindersScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Ölçüm ve Tedavi Hatırlatıcıları'), findsOneWidget);
      expect(find.text('Aktif Hatırlatıcılar'), findsOneWidget);
      expect(find.byType(Switch), findsWidgets);
    });
  });
}
