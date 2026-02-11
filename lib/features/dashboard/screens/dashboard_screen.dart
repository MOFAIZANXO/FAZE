import 'package:flutter/material.dart';
import '../../../core/contracts/widget_contracts.dart';
import '../services/dashboard_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/dashboard_prayer_widget.dart';
import '../../../core/widgets/dashboard_hydration_widget.dart';
import '../../../core/widgets/dashboard_tasks_widget.dart';
import '../../../core/widgets/dashboard_journal_widget.dart';
import '../../../core/widgets/dashboard_exercise_widget.dart';
import '../../../core/widgets/quick_stats_row.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late DashboardData _data;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _data = DashboardService.getDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'FAZE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadData,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => _loadData(),
        child: Stack(
          children: [
            // ✅ FIXED: Clean background glow blobs (no broken SelectionArea)
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

            // ── Main Content ──────────────────────────────
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Greeting
                  _buildGreeting(theme),
                  const SizedBox(height: 32),

                  // Quick Stats Row
                  QuickStatsRow(data: _data),
                  const SizedBox(height: 32),

                  // Overview title
                  Text(
                    "Today's Overview",
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Widget Grid
                  _buildOverviewGrid(),
                ],
              ),
            ),
          ],
        ),
      ),
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

  Widget _buildOverviewGrid() {
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
              DashboardPrayerWidgetCard(data: _data.prayer),
              DashboardHydrationWidgetCard(data: _data.hydration),
              DashboardTasksWidgetCard(data: _data.tasks),
              DashboardJournalWidgetCard(data: _data.journal),
              DashboardExerciseWidgetCard(data: _data.exercise),
            ],
          );
        } else {
          return Column(
            children: [
              DashboardPrayerWidgetCard(data: _data.prayer),
              const SizedBox(height: 16),
              DashboardHydrationWidgetCard(data: _data.hydration),
              const SizedBox(height: 16),
              DashboardTasksWidgetCard(data: _data.tasks),
              const SizedBox(height: 16),
              DashboardJournalWidgetCard(data: _data.journal),
              const SizedBox(height: 16),
              DashboardExerciseWidgetCard(data: _data.exercise),
            ],
          );
        }
      },
    );
  }
}