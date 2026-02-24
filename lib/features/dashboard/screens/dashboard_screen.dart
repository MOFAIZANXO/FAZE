import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faze/core/contracts/widget_contracts.dart';
import 'package:faze/core/theme/app_theme.dart';
import 'package:faze/core/widgets/dashboard_prayer_widget.dart';
import 'package:faze/core/widgets/dashboard_hydration_widget.dart';
import 'package:faze/core/widgets/dashboard_tasks_widget.dart';
import 'package:faze/core/widgets/dashboard_journal_widget.dart';
import 'package:faze/core/widgets/dashboard_exercise_widget.dart';
import 'package:faze/core/widgets/quick_stats_row.dart';
import 'package:faze/features/dashboard/providers/dashboard_providers.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dashboardAsync = ref.watch(dashboardDataProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Image.asset(
          'assets/images/Logo.png',
          height: 32,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Text(
              'FAZE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () => ref.invalidate(dashboardDataProvider),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(dashboardDataProvider),
        child: dashboardAsync.when(
          data: (data) => _buildBody(theme, data),
          loading: () {
            // If we have previous data, keep showing it while loading (e.g. during a button tap)
            if (dashboardAsync.hasValue) {
              return _buildBody(theme, dashboardAsync.value!);
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Logo.png',
                    width: 120,
                    opacity: const AlwaysStoppedAnimation(0.5),
                  ),
                  const SizedBox(height: 24),
                  const CircularProgressIndicator(color: Colors.blue),
                ],
              ),
            );
          },
          error: (err, stack) {
            // Even on error, if we have data, show it but maybe with a snackbar or small indicator
            if (dashboardAsync.hasValue) {
              return _buildBody(theme, dashboardAsync.value!);
            }
            return _buildError(err);
          },
        ),
      ),
    );
  }

  Widget _buildError(Object err) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 16),
          const Text(
            'Failed to load dashboard',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            err.toString(),
            style: const TextStyle(color: Colors.white54, fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => ref.invalidate(dashboardDataProvider),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(ThemeData theme, DashboardData data) {

    return Stack(
      children: [
        // Background glows
        Positioned(
          top: -100,
          right: -50,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primaryBlue.withOpacity(0.08),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 200,
          left: -100,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primaryBlue.withOpacity(0.06),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          right: -150,
          child: Container(
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.deepBlue.withOpacity(0.05),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreeting(theme),
              const SizedBox(height: 32),
              QuickStatsRow(data: data),
              const SizedBox(height: 32),
              Text(
                "Today's Overview",
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildOverviewGrid(data),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGreeting(ThemeData theme) {
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? 'Good Morning'
        : hour < 17
            ? 'Good Afternoon'
            : 'Good Evening';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          greeting,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Ready to make progress?',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: AppColors.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewGrid(DashboardData data) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
            children: [
              DashboardPrayerWidgetCard(data: data.prayer),
              DashboardHydrationWidgetCard(data: data.hydration),
              DashboardTasksWidgetCard(data: data.tasks),
              DashboardJournalWidgetCard(data: data.journal),
              DashboardExerciseWidgetCard(data: data.exercise),
            ],
          );
        } else {
          return Column(
            children: [
              DashboardPrayerWidgetCard(data: data.prayer),
              const SizedBox(height: 16),
              DashboardHydrationWidgetCard(data: data.hydration),
              const SizedBox(height: 16),
              DashboardTasksWidgetCard(data: data.tasks),
              const SizedBox(height: 16),
              DashboardJournalWidgetCard(data: data.journal),
              const SizedBox(height: 16),
              DashboardExerciseWidgetCard(data: data.exercise),
            ],
          );
        }
      },
    );
  }
}