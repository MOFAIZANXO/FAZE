import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:faze/data/services/database_service.dart';
import 'package:faze/data/models/hydration_log.dart';

/// AquaFlow Hydration Service
/// 
/// Uses your existing HydrationLog model (timestamp + amountMl)
class HydrationService {
  static Future<Isar> _getDb() => DatabaseService.getIsar();

  // ─────────────────────────────────────────────
  // READ
  // ─────────────────────────────────────────────

  /// Get today's total glasses (250ml = 1 glass)
  static Future<int> getTodayGlasses() async {
    final logs = await getTodayLogs();
    final totalMl = logs.fold<int>(0, (sum, log) => sum + log.amountMl);
    return (totalMl / 250).floor(); // 250ml = 1 glass
  }

  /// Get all logs for today
  static Future<List<HydrationLog>> getTodayLogs() async {
    final start = _startOfDay(DateTime.now());
    final end = _endOfDay(DateTime.now());
    final db = await _getDb();

    return await db.hydrationLogs
        .filter()
        .timestampBetween(start, end)
        .sortByTimestampDesc()
        .findAll();
  }

  /// Get logs for last N days
  static Future<List<HydrationLog>> getLastNDays(int days) async {
    final start = _startOfDay(
      DateTime.now().subtract(Duration(days: days - 1)),
    );
    final db = await _getDb();
    return await db.hydrationLogs
        .filter()
        .timestampGreaterThan(start, include: true)
        .sortByTimestampDesc()
        .findAll();
  }

  /// Reset all progress for today
  static Future<void> resetTodayProgress() async {
    final todayLogs = await getTodayLogs();
    final db = await _getDb();
    
    await db.writeTxn(() async {
      for (final log in todayLogs) {
        await db.hydrationLogs.delete(log.id);
      }
    });
  }

  /// Stream today's logs (auto-updates UI)
  static Stream<List<HydrationLog>> watchTodayLogs() async* {
    final start = _startOfDay(DateTime.now());
    final end = _endOfDay(DateTime.now());
    final db = await _getDb();

    yield* db.hydrationLogs
        .filter()
        .timestampBetween(start, end)
        .watch(fireImmediately: true);
  }

  // ─────────────────────────────────────────────
  // WRITE
  // ─────────────────────────────────────────────

  /// Add one glass of water (250ml)
  static Future<void> addGlass() async {
    final log = HydrationLog()
      ..timestamp = DateTime.now()
      ..amountMl = 250;

    final db = await _getDb();
    await db.writeTxn(() async {
      await db.hydrationLogs.put(log);
    });
  }

  /// Remove last glass (undo)
  static Future<void> removeLastGlass() async {
    try {
      final logs = await getTodayLogs();
      if (logs.isEmpty) {
        debugPrint('HydrationService.removeLastGlass: No logs found, returning.');
        return;
      }

      final lastLog = logs.first;
      final db = await _getDb();
      
      await db.writeTxn(() async {
        final success = await db.hydrationLogs.delete(lastLog.id);
        if (success) {
          debugPrint('HydrationService: Deleted log ${lastLog.id}');
        } else {
          debugPrint('HydrationService: Log ${lastLog.id} not found in DB during deletion');
        }
      });
    } catch (e) {
      debugPrint('HydrationService.removeLastGlass error: $e');
    }
  }

  /// Set exact number of glasses for today
  static Future<void> setGlassesForToday(int glasses) async {
    // Clear today's logs
    final todayLogs = await getTodayLogs();
    final db = await _getDb();
    
    await db.writeTxn(() async {
      for (final log in todayLogs) {
        await db.hydrationLogs.delete(log.id);
      }
    });

    // Add new logs
    final now = DateTime.now();
    final logs = List.generate(
      glasses,
      (i) => HydrationLog()
        ..timestamp = now.subtract(Duration(minutes: i))
        ..amountMl = 250,
    );

    await db.writeTxn(() async {
      await db.hydrationLogs.putAll(logs);
    });
  }

  // ─────────────────────────────────────────────
  // ANALYTICS
  // ─────────────────────────────────────────────

  /// Get 7-day average glasses per day
  static Future<double> getWeeklyAverage() async {
    final logs = await getLastNDays(7);
    if (logs.isEmpty) return 0;

    // Group by day
    final dayTotals = <DateTime, int>{};
    for (final log in logs) {
      final day = _dateOnly(log.timestamp);
      dayTotals[day] = (dayTotals[day] ?? 0) + log.amountMl;
    }

    final avgMl = dayTotals.values.fold<int>(0, (a, b) => a + b) / 7;
    return avgMl / 250; // Convert to glasses
  }

  /// Get current streak (consecutive days goal was reached)
  static Future<int> getCurrentStreak({int targetGlasses = 8}) async {
    final logs = await getLastNDays(30);
    if (logs.isEmpty) return 0;

    // Group by day
    final dayGlasses = <DateTime, int>{};
    for (final log in logs) {
      final day = _dateOnly(log.timestamp);
      final glasses = (log.amountMl / 250).floor();
      final current = dayGlasses[day] ?? 0;
      dayGlasses[day] = current + glasses;
    }

    int streak = 0;
    final today = _dateOnly(DateTime.now());

    for (int i = 0; i < 30; i++) {
      final checkDate = today.subtract(Duration(days: i));
      final glasses = dayGlasses[checkDate] ?? 0;

      if (glasses >= targetGlasses) {
        streak++;
      } else {
        break;
      }
    }

    return streak;
  }

  /// Get completion rate for last N days (0-100)
  static Future<int> getCompletionRate({
    int days = 7,
    int targetGlasses = 8,
  }) async {
    final logs = await getLastNDays(days);
    if (logs.isEmpty) return 0;

    final dayGlasses = <DateTime, int>{};
    for (final log in logs) {
      final day = _dateOnly(log.timestamp);
      final glasses = (log.amountMl / 250).floor();
      final current = dayGlasses[day] ?? 0;
      dayGlasses[day] = current + glasses;
    }

    final completedDays = dayGlasses.values
        .where((glasses) => glasses >= targetGlasses)
        .length;

    return ((completedDays / days) * 100).round();
  }

  /// Get summary for dashboard widget
  static Future<HydrationSummary> getSummary({int targetGlasses = 8}) async {
    final currentGlasses = await getTodayGlasses();
    final streak = await getCurrentStreak(targetGlasses: targetGlasses);
    final weeklyAvg = await getWeeklyAverage();
    final todayLogs = await getTodayLogs();

    return HydrationSummary(
      currentGlasses: currentGlasses,
      targetGlasses: targetGlasses,
      percentComplete: (currentGlasses / targetGlasses).clamp(0.0, 1.0),
      goalReached: currentGlasses >= targetGlasses,
      remainingGlasses: (targetGlasses - currentGlasses).clamp(0, targetGlasses),
      currentStreak: streak,
      weeklyAverage: weeklyAvg,
      lastDrinkTime: todayLogs.isNotEmpty ? todayLogs.first.timestamp : null,
    );
  }

  /// Get daily glasses for last 7 days (for chart)
  static Future<List<DayGlasses>> getLast7DaysGlasses() async {
    final logs = await getLastNDays(7);

    final dayGlasses = <DateTime, int>{};
    for (final log in logs) {
      final day = _dateOnly(log.timestamp);
      final glasses = (log.amountMl / 250).floor();
      final current = dayGlasses[day] ?? 0;
      dayGlasses[day] = current + glasses;
    }

    return List.generate(7, (i) {
      final date = _dateOnly(DateTime.now()).subtract(Duration(days: 6 - i));
      return DayGlasses(
        date: date,
        glasses: dayGlasses[date] ?? 0,
      );
    });
  }

  // ─────────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────────

  static DateTime _dateOnly(DateTime dt) =>
      DateTime(dt.year, dt.month, dt.day);

  static DateTime _startOfDay(DateTime dt) =>
      DateTime(dt.year, dt.month, dt.day, 0, 0, 0);

  static DateTime _endOfDay(DateTime dt) =>
      DateTime(dt.year, dt.month, dt.day, 23, 59, 59);
}

// ═════════════════════════════════════════════════════════════════
// DATA CLASSES
// ═════════════════════════════════════════════════════════════════

/// Summary data for UI
class HydrationSummary {
  final int currentGlasses;
  final int targetGlasses;
  final double percentComplete;
  final bool goalReached;
  final int remainingGlasses;
  final int currentStreak;
  final double weeklyAverage;
  final DateTime? lastDrinkTime;

  const HydrationSummary({
    required this.currentGlasses,
    required this.targetGlasses,
    required this.percentComplete,
    required this.goalReached,
    required this.remainingGlasses,
    required this.currentStreak,
    required this.weeklyAverage,
    this.lastDrinkTime,
  });

  String get lastDrinkFormatted {
    if (lastDrinkTime == null) return 'Not yet today';
    final diff = DateTime.now().difference(lastDrinkTime!);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return 'Yesterday';
  }

  String get motivationMessage {
    if (goalReached) return '🎉 Goal reached! Amazing!';
    if (percentComplete >= 0.75) return '💪 Almost there! $remainingGlasses to go!';
    if (percentComplete >= 0.5) return '👍 Halfway there! Keep going!';
    if (percentComplete >= 0.25) return '💧 Good start! $remainingGlasses more glasses!';
    return '🌊 Stay hydrated! Drink up!';
  }
}

/// Day glasses for chart
class DayGlasses {
  final DateTime date;
  final int glasses;

  const DayGlasses({
    required this.date,
    required this.glasses,
  });
}