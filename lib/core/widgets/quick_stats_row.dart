import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../contracts/widget_contracts.dart';

/// Quick Stats Row for Dashboard
/// 
/// Shows 3 small stat cards: Streak, Tasks, and Water.
/// Refined with the Black + Blue theme.
class QuickStatsRow extends StatelessWidget {
  final DashboardData data;

  const QuickStatsRow({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatItem(
            context,
            value: '${data.journal.currentStreak}',
            label: 'Streak',
            icon: Icons.local_fire_department,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatItem(
            context,
            value: '${data.tasks.completedTasks}/${data.tasks.totalTasks}',
            label: 'Tasks',
            icon: Icons.check_circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatItem(
            context,
            value: '${(data.hydration.percentComplete * 100).toInt()}%',
            label: 'Water',
            icon: Icons.water_drop,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required String value,
    required String label,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primaryBlue, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textTertiary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
