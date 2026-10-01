import 'package:go_router/go_router.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/food/presentation/food_search_screen.dart';
import '../../features/meal_builder/presentation/meal_builder_screen.dart';
import '../../features/dose_calculator/presentation/dose_calculator_screen.dart';
import '../../features/glucose_log/presentation/glucose_log_screen.dart';
import '../../features/history_reports/presentation/reports_screen.dart';
import '../../features/emergency/presentation/emergency_screen.dart';
import '../../features/education/presentation/education_screen.dart';
import '../../features/reminders/presentation/reminders_screen.dart';
import '../../features/profile_settings/presentation/settings_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/foods',
      builder: (context, state) => const FoodSearchScreen(),
    ),
    GoRoute(
      path: '/plate',
      builder: (context, state) => const MealBuilderScreen(),
    ),
    GoRoute(
      path: '/dose',
      builder: (context, state) => const DoseCalculatorScreen(),
    ),
    GoRoute(
      path: '/glucose',
      builder: (context, state) => const GlucoseLogScreen(),
    ),
    GoRoute(
      path: '/reports',
      builder: (context, state) => const ReportsScreen(),
    ),
    GoRoute(
      path: '/emergency',
      builder: (context, state) => const EmergencyScreen(),
    ),
    GoRoute(
      path: '/education',
      builder: (context, state) => const EducationScreen(),
    ),
    GoRoute(
      path: '/reminders',
      builder: (context, state) => const RemindersScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
