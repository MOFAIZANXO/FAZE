import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/daily/screens/daily_rituals_screen.dart';
import '../../features/productivity/screens/productivity_screen.dart';
import '../../features/hydration/screens/hydration_screen.dart';
import '../../features/journal/screens/journal_screen.dart';
import '../../features/analytics/screens/analytics_screen.dart';
import '../../features/prayers/screens/prayer_times_screen.dart';
import '../widgets/app_bottom_nav.dart';

/// Main app router with StatefulShellRoute for bottom navigation
/// 
/// This keeps each tab's state preserved when switching between tabs
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // Main Shell with Bottom Navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithBottomNav(navigationShell: navigationShell);
        },
        branches: [
          // Tab 1: Dashboard
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                name: 'dashboard',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: DashboardScreen(),
                ),
              ),
            ],
          ),
          
          // Tab 2: Daily Rituals
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/daily',
                name: 'daily',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: DailyRitualsScreen(),
                ),
              ),
            ],
          ),
          
          // Tab 3: Productivity
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/productivity',
                name: 'productivity',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: ProductivityScreen(),
                ),
              ),
            ],
          ),
          
          // Tab 4: Journal
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/journal',
                name: 'journal',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: JournalScreen(),
                ),
              ),
            ],
          ),
          
          // Tab 5: Analytics
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/analytics',
                name: 'analytics',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: AnalyticsScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
      
      // Full-screen routes (outside bottom nav)
      GoRoute(
        path: '/prayer-times',
        name: 'prayer-times',
        pageBuilder: (context, state) => const MaterialPage(
          child: PrayerTimesScreen(),
        ),
      ),
      GoRoute(
        path: '/hydration',
        name: 'hydration',
        pageBuilder: (context, state) => const MaterialPage(
          child: HydrationScreen(),
        ),
      ),
    ],
  );
}

/// Scaffold with Bottom Navigation
class ScaffoldWithBottomNav extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithBottomNav({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNav(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}