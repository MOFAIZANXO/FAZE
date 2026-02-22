import '../../../core/contracts/widget_contracts.dart';
import '../../../data/services/prayer_time_service.dart';
import '../../../features/hydration/services/hydration_service.dart';

/// Dashboard Service
/// 
/// Aggregates data from all feature services and provides
/// formatted data for dashboard widgets.
class DashboardService {
  
  /// Get complete dashboard data
  static Future<DashboardData> getDashboardData() async {
    return DashboardData(
      prayer: _getPrayerWidgetData(),
      hydration: await _getHydrationWidgetData(),  // ✅ Now async
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
  
  /// Hydration widget data (NOW USES REAL DATA)
  static Future<DashboardHydrationWidget> _getHydrationWidgetData() async {
    try {
      final summary = await HydrationService.getSummary(targetGlasses: 8);
      
      return DashboardHydrationWidget(
        currentGlasses: summary.currentGlasses,
        targetGlasses: summary.targetGlasses,
        percentComplete: summary.percentComplete,
        lastDrinkTime: summary.lastDrinkTime,
      );
    } catch (e) {
      // Fallback if hydration service fails
      print('Hydration service error: $e');
      return const DashboardHydrationWidget(
        currentGlasses: 0,
        targetGlasses: 8,
        percentComplete: 0,
        lastDrinkTime: null,
      );
    }
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