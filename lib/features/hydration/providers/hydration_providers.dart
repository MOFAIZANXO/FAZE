import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:faze/features/hydration/services/hydration_service.dart';

// ─────────────────────────────────────────────
// PROVIDERS
// ─────────────────────────────────────────────

/// Current date (updates daily at midnight for auto-reset)
final currentDayProvider = StateProvider<DateTime>((ref) {
  // Watch for system clock changes or just simple periodic check
  // For a robust reset, we can use a Timer or stream
  return DateTime.now();
});

/// Today's hydration summary (auto-refreshes)
final hydrationSummaryProvider = Provider<AsyncValue<HydrationSummary>>((ref) {
  // Ensure we refresh when the day changes
  final day = ref.watch(currentDayProvider);
  return ref.watch(hydrationNotifierProvider);
});

/// 7-day history
final hydrationHistoryProvider = FutureProvider<List<DayGlasses>>((ref) async {
  return await HydrationService.getLast7DaysGlasses();
});

/// Current target (Fixed at 8 glasses)
final hydrationTargetProvider = Provider<int>((ref) => 8);

// ─────────────────────────────────────────────
// NOTIFIER (for actions)
// ─────────────────────────────────────────────

class HydrationNotifier extends AsyncNotifier<HydrationSummary> {
  @override
  Future<HydrationSummary> build() async {
    final target = ref.watch(hydrationTargetProvider);
    return await HydrationService.getSummary(targetGlasses: target);
  }

  /// User tapped + button
  Future<void> addGlass() async {
    final state = this.state.value;
    if (state == null || state.currentGlasses >= state.targetGlasses) {
      debugPrint('HydrationNotifier: Already at target. Skipping add.');
      return;
    }
    
    debugPrint('HydrationNotifier: Adding glass...');
    await HydrationService.addGlass();
    ref.invalidateSelf();
  }

  /// User tapped - button (undo)
  Future<void> removeGlass() async {
    final state = this.state.value;
    if (state == null || state.currentGlasses <= 0) {
      debugPrint('HydrationNotifier: Already at 0. Skipping remove.');
      return;
    }

    debugPrint('HydrationNotifier: Removing glass...');
    await HydrationService.removeLastGlass();
    ref.invalidateSelf();
  }

  /// Reset today's progress
  Future<void> resetTodayProgress() async {
    debugPrint('HydrationNotifier: Resetting today\'s progress...');
    await HydrationService.resetTodayProgress();
    ref.invalidateSelf();
  }

  /// Set exact number of glasses for today
  Future<void> setGlasses(int count) async {
    await HydrationService.setGlassesForToday(count);
    ref.invalidateSelf();
  }
}

final hydrationNotifierProvider =
    AsyncNotifierProvider<HydrationNotifier, HydrationSummary>(
  HydrationNotifier.new,
);