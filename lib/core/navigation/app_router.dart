import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:faze/features/dashboard/screens/dashboard_screen.dart';
import 'package:faze/features/daily/screens/daily_rituals_screen.dart';
import 'package:faze/features/productivity/screens/productivity_screen.dart';
import 'package:faze/features/hydration/screens/hydration_screen.dart';
import 'package:faze/features/journal/screens/journal_screen.dart';
import 'package:faze/features/analytics/screens/analytics_screen.dart';
import 'package:faze/features/prayers/screens/prayer_times_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faze/features/hydration/providers/hydration_providers.dart';
import 'package:faze/core/widgets/app_bottom_nav.dart';

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
                pageBuilder: (context, state) => _fadeSlideTransition(
                  state: state,
                  child: const DashboardScreen(),
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
                pageBuilder: (context, state) => _fadeSlideTransition(
                  state: state,
                  child: const DailyRitualsScreen(),
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
                pageBuilder: (context, state) => _fadeSlideTransition(
                  state: state,
                  child: const ProductivityScreen(),
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
                pageBuilder: (context, state) => _fadeSlideTransition(
                  state: state,
                  child: const JournalScreen(),
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
                pageBuilder: (context, state) => _fadeSlideTransition(
                  state: state,
                  child: const AnalyticsScreen(),
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
        pageBuilder: (context, state) => _fadeSlideTransition(
          state: state,
          child: const PrayerTimesScreen(),
        ),
      ),
      GoRoute(
        path: '/hydration',
        name: 'hydration',
        pageBuilder: (context, state) => _fadeSlideTransition(
          state: state,
          child: const HydrationScreen(),
        ),
      ),
    ],
  );

  static CustomTransitionPage _fadeSlideTransition({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeIn).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.05),
              end: Offset.zero,
            ).animate(CurveTween(curve: Curves.easeOutCubic).animate(animation)),
            child: child,
          ),
        );
      },
    );
  }
}

/// Scaffold with Bottom Navigation
class ScaffoldWithBottomNav extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithBottomNav({
    super.key,
    required this.navigationShell,
  });

  @override
  ConsumerState<ScaffoldWithBottomNav> createState() => _ScaffoldWithBottomNavState();
}

class _ScaffoldWithBottomNavState extends ConsumerState<ScaffoldWithBottomNav> {
  late DateTime _lastCheckedDate;

  @override
  void initState() {
    super.initState();
    _lastCheckedDate = DateTime.now();
    _startMidnightTimer();
  }

  void _startMidnightTimer() {
    // Check every minute if the date has changed
    Future.delayed(const Duration(minutes: 1), () {
      if (!mounted) return;

      final now = DateTime.now();
      if (now.day != _lastCheckedDate.day) {
        // Day changed! Trigger reset for any daily logic
        ref.read(currentDayProvider.notifier).state = now;
        _lastCheckedDate = now;
      }
      _startMidnightTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: AppBottomNav(
        currentIndex: widget.navigationShell.currentIndex,
        onTap: (index) => widget.navigationShell.goBranch(
          index,
          initialLocation: index == widget.navigationShell.currentIndex,
        ),
      ),
    );
  }
}