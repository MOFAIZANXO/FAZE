import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/hydration_service.dart';

// ─────────────────────────────────────────────
// PROVIDERS
// ─────────────────────────────────────────────

/// Today's hydration summary (auto-refreshes)
final hydrationSummaryProvider = FutureProvider<HydrationSummary>((ref) async {
  final target = ref.watch(hydrationTargetProvider);
  return await HydrationService.getSummary(targetGlasses: target);
});

/// 7-day history
final hydrationHistoryProvider = FutureProvider<List<DayGlasses>>((ref) async {
  return await HydrationService.getLast7DaysGlasses();
});

/// Current target (stored in SharedPreferences)
final hydrationTargetProvider = StateProvider<int>((ref) => 8);

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
    await HydrationService.addGlass();
    ref.invalidateSelf();
  }

  /// User tapped - button (undo)
  Future<void> removeGlass() async {
    await HydrationService.removeLastGlass();
    ref.invalidateSelf();
  }

  /// User changed daily target
  Future<void> setTarget(int glasses) async {
    ref.read(hydrationTargetProvider.notifier).state = glasses;
    
    // Save to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('hydration_target', glasses);
    
    ref.invalidateSelf();
  }
}

final hydrationNotifierProvider =
    AsyncNotifierProvider<HydrationNotifier, HydrationSummary>(
  HydrationNotifier.new,
);