import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faze/core/contracts/widget_contracts.dart';
import 'package:faze/features/hydration/providers/hydration_providers.dart';
import 'package:faze/features/dashboard/services/dashboard_service.dart';

/// Provider for the aggregated dashboard data
/// 
/// This provider ensures the dashboard is reactive. 
/// It should be invalidated or watched in a way that it updates when
/// underlying features (like hydration) change.
final dashboardDataProvider = FutureProvider<DashboardData>((ref) async {
  debugPrint('dashboardDataProvider: Fetching data...');
  // We only watch the target to re-fetch if the goal changes
  final target = ref.watch(hydrationTargetProvider);
  
  final data = await DashboardService.getDashboardData(targetGlasses: target);
  debugPrint('dashboardDataProvider: Data fetched successfully.');
  return data;
});
