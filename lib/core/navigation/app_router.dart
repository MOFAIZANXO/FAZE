import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/daily/screens/daily_rituals_screen.dart';
import '../../features/productivity/screens/productivity_screen.dart';
import '../../features/journal/screens/journal_screen.dart';
import '../../features/analytics/screens/analytics_screen.dart';
import '../../features/prayers/screens/prayer_times_screen.dart';

/// Main app router configuration
/// 
/// 5 main tabs accessible via bottom navigation:
/// - Dashboard (Home)
/// - Daily Rituals (Prayer, Hydration, Exercise)
/// - Productivity (Tasks, Notes, Birthdays)
/// - Journal (4 Wins)
/// - Analytics (Stats, Insights)
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // Bottom Navigation Routes (Main Tabs)
      GoRoute(
        path: '/',
        name: 'dashboard',
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          const DashboardScreen(),
        ),
      ),
      
      GoRoute(
        path: '/daily',
        name: 'daily',
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          const DailyRitualsScreen(),
        ),
      ),
      
      GoRoute(
        path: '/productivity',
        name: 'productivity',
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          const ProductivityScreen(),
        ),
      ),
      
      GoRoute(
        path: '/journal',
        name: 'journal',
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          const JournalScreen(),
        ),
      ),
      
      GoRoute(
        path: '/analytics',
        name: 'analytics',
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          const AnalyticsScreen(),
        ),
      ),
      
      // Feature Detail Routes
      GoRoute(
        path: '/prayer-times',
        name: 'prayer-times',
        pageBuilder: (context, state) => MaterialPage(
          child: const PrayerTimesScreen(),
        ),
      ),
      
      // Add more feature routes as we build them:
      // /tasks, /hydration, /exercise, /notes, /birthdays, /4-wins
    ],
  );
  
  /// Build page with fade transition
  static Page _buildPageWithTransition(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}

/// Navigation helper for quick access
class AppNavigation {
  static void goToDashboard(BuildContext context) {
    context.go('/');
  }
  
  static void goToDaily(BuildContext context) {
    context.go('/daily');
  }
  
  static void goToProductivity(BuildContext context) {
    context.go('/productivity');
  }
  
  static void goToJournal(BuildContext context) {
    context.go('/journal');
  }
  
  static void goToAnalytics(BuildContext context) {
    context.go('/analytics');
  }
  
  static void goToPrayerTimes(BuildContext context) {
    context.push('/prayer-times');
  }
}