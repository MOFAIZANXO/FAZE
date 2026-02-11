import '../../../core/contracts/widget_contracts.dart';
import '../../../data/services/prayer_time_service.dart';

/// Dashboard Service
/// 
/// Aggregates data from all feature services and provides
/// formatted data for dashboard widgets.
class DashboardService {
  
  /// Get complete dashboard data
  static DashboardData getDashboardData() {
    return DashboardData(
      prayer: _getPrayerWidgetData(),
      hydration: _getHydrationWidgetData(),
      tasks: _getTasksWidgetData(),
      journal: _getJournalWidgetData(),
      exercise: _getExerciseWidgetData(),
      lastUpdated: DateTime.now(),
    );
  }
  
  /// Prayer widget data
  static DashboardPrayerWidget _getPrayerWidgetData() {
    // Get next prayer from prayer service
    final nextPrayer = PrayerTimeService.getNextPrayer(
      latitude: 31.5204,
      longitude: 74.3587,
    );
    
    return DashboardPrayerWidget(
      nextPrayerName: nextPrayer['name'] as String,
      nextPrayerTime: nextPrayer['time'] as DateTime,
      timeRemaining: PrayerTimeService.formatTimeRemaining(
        nextPrayer['timeRemaining'] as Duration,
      ),
      isCurrentlyPrayerTime: _isWithin15Minutes(
        nextPrayer['time'] as DateTime,
      ),
    );
  }
  
  /// Hydration widget data (placeholder - will be real when we build hydration)
  static DashboardHydrationWidget _getHydrationWidgetData() {
    // TODO: Get from HydrationService when built
    return const DashboardHydrationWidget(
      currentGlasses: 3,
      targetGlasses: 8,
      percentComplete: 0.375,
      lastDrinkTime: null,
    );
  }
  
  /// Tasks widget data (placeholder - will be real when we build tasks)
  static DashboardTasksWidget _getTasksWidgetData() {
    // TODO: Get from TaskService when built
    return const DashboardTasksWidget(
      totalTasks: 5,
      completedTasks: 2,
      overdueTaskCount: 1,
      topTaskTitles: [
        'Complete prayer feature',
        'Review code',
        'Plan next milestone',
      ],
    );
  }
  
  /// Journal widget data (placeholder - will be real when we build journal)
  static DashboardJournalWidget _getJournalWidgetData() {
    // TODO: Get from JournalService when built
    return DashboardJournalWidget(
      currentStreak: 3,
      completedToday: false,
      winsCompletedToday: 1,
      lastEntryDate: DateTime.now().subtract(const Duration(days: 1)),
    );
  }
  
  /// Exercise widget data (placeholder - will be real when we build exercise)
  static DashboardExerciseWidget _getExerciseWidgetData() {
    // TODO: Get from ExerciseService when built
    return const DashboardExerciseWidget(
      completedToday: false,
      todayWorkoutType: null,
      weeklyWorkoutCount: 2,
      weeklyGoal: 4,
    );
  }
  
  /// Helper: Check if time is within 15 minutes
  static bool _isWithin15Minutes(DateTime time) {
    final now = DateTime.now();
    final difference = time.difference(now).abs();
    return difference.inMinutes <= 15;
  }
}