/// Data contracts for all dashboard widgets and feature screens
/// 
/// These define the exact shape of data that the UI needs.
/// Backend provides data in this format, frontend consumes it.

// ============================================================================
// DASHBOARD WIDGETS
// ============================================================================
import 'package:flutter/material.dart';

/// Data for the next prayer widget on dashboard
class DashboardPrayerWidget {
  final String nextPrayerName;
  final DateTime nextPrayerTime;
  final String timeRemaining; // e.g., "2h 15m"
  final bool isCurrentlyPrayerTime; // Within 15 min
  
  const DashboardPrayerWidget({
    required this.nextPrayerName,
    required this.nextPrayerTime,
    required this.timeRemaining,
    required this.isCurrentlyPrayerTime,
  });
}

/// Data for hydration widget on dashboard
class DashboardHydrationWidget {
  final int currentGlasses;
  final int targetGlasses;
  final double percentComplete; // 0.0 - 1.0
  final DateTime? lastDrinkTime;
  
  const DashboardHydrationWidget({
    required this.currentGlasses,
    required this.targetGlasses,
    required this.percentComplete,
    this.lastDrinkTime,
  });
}

/// Data for tasks widget on dashboard
class DashboardTasksWidget {
  final int totalTasks;
  final int completedTasks;
  final int overdueTaskCount;
  final List<String> topTaskTitles; // Max 3
  
  const DashboardTasksWidget({
    required this.totalTasks,
    required this.completedTasks,
    required this.overdueTaskCount,
    required this.topTaskTitles,
  });
}

/// Data for journal widget on dashboard
class DashboardJournalWidget {
  final int currentStreak;
  final bool completedToday;
  final int winsCompletedToday; // 0-4
  final DateTime? lastEntryDate;
  
  const DashboardJournalWidget({
    required this.currentStreak,
    required this.completedToday,
    required this.winsCompletedToday,
    this.lastEntryDate,
  });
}

/// Data for exercise widget on dashboard
class DashboardExerciseWidget {
  final bool completedToday;
  final String? todayWorkoutType; // e.g., "Cardio", "Strength"
  final int weeklyWorkoutCount;
  final int weeklyGoal;
  
  const DashboardExerciseWidget({
    required this.completedToday,
    this.todayWorkoutType,
    required this.weeklyWorkoutCount,
    required this.weeklyGoal,
  });
}

/// Complete dashboard data - aggregates all widgets
class DashboardData {
  final DashboardPrayerWidget prayer;
  final DashboardHydrationWidget hydration;
  final DashboardTasksWidget tasks;
  final DashboardJournalWidget journal;
  final DashboardExerciseWidget exercise;
  final DateTime lastUpdated;
  
  const DashboardData({
    required this.prayer,
    required this.hydration,
    required this.tasks,
    required this.journal,
    required this.exercise,
    required this.lastUpdated,
  });
}

// ============================================================================
// NAVIGATION
// ============================================================================

/// Bottom navigation tab data
class NavTabData {
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String route;
  
  const NavTabData({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.route,
  });
}

/// All 5 navigation tabs
class AppTabs {
  static const dashboard = NavTabData(
    label: 'Home',
    icon: Icons.home_outlined,
    activeIcon: Icons.home,
    route: '/',
  );
  
  static const daily = NavTabData(
    label: 'Daily',
    icon: Icons.wb_sunny_outlined,
    activeIcon: Icons.wb_sunny,
    route: '/daily',
  );
  
  static const productivity = NavTabData(
    label: 'Tasks',
    icon: Icons.check_circle_outline,
    activeIcon: Icons.check_circle,
    route: '/productivity',
  );
  
  static const journal = NavTabData(
    label: 'Journal',
    icon: Icons.book_outlined,
    activeIcon: Icons.book,
    route: '/journal',
  );
  
  static const analytics = NavTabData(
    label: 'Stats',
    icon: Icons.insights_outlined,
    activeIcon: Icons.insights,
    route: '/analytics',
  );
  
  static const List<NavTabData> all = [
    dashboard,
    daily,
    productivity,
    journal,
    analytics,
  ];
}

// ============================================================================
// DAILY RITUALS SCREEN
// ============================================================================

/// Data for daily rituals screen (combines prayer, hydration, exercise)
class DailyRitualsData {
  final DashboardPrayerWidget prayerSummary;
  final DashboardHydrationWidget hydrationSummary;
  final DashboardExerciseWidget exerciseSummary;
  
  const DailyRitualsData({
    required this.prayerSummary,
    required this.hydrationSummary,
    required this.exerciseSummary,
  });
}

// ============================================================================
// PRODUCTIVITY SCREEN
// ============================================================================

/// Data for productivity screen (combines tasks, notes, birthdays)
class ProductivityData {
  final DashboardTasksWidget tasksSummary;
  final int totalNotes;
  final int upcomingBirthdays; // Next 7 days
  
  const ProductivityData({
    required this.tasksSummary,
    required this.totalNotes,
    required this.upcomingBirthdays,
  });
}

// ============================================================================
// ANALYTICS SCREEN
// ============================================================================

/// Data for analytics/stats screen
class AnalyticsData {
  final int prayerCompletionRate; // 0-100
  final int taskCompletionRate; // 0-100
  final int journalStreak;
  final int hydrationAverage; // Avg glasses per day
  final int weeklyWorkouts;
  
  const AnalyticsData({
    required this.prayerCompletionRate,
    required this.taskCompletionRate,
    required this.journalStreak,
    required this.hydrationAverage,
    required this.weeklyWorkouts,
  });
}