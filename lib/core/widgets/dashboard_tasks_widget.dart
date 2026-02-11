import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../contracts/widget_contracts.dart';

/// Tasks Widget for Dashboard
/// 
/// Shows top 3 tasks with checkboxes and completion progress.
/// Features the theme's primary blue accent.
class DashboardTasksWidgetCard extends StatelessWidget {
  final DashboardTasksWidget data;

  const DashboardTasksWidgetCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Feedback.forTap(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tasks screen coming soon!')),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.check_circle, color: AppColors.primaryBlue, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Today\'s Tasks',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  '${data.completedTasks}/${data.totalTasks} done',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...data.topTaskTitles.map((title) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.radio_button_unchecked,
                        color: AppColors.textTertiary,
                        size: 16,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )),
            if (data.totalTasks > 3)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 28),
                child: Text(
                  '+ ${data.totalTasks - 3} more tasks',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textTertiary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: data.totalTasks > 0 ? data.completedTasks / data.totalTasks : 0,
                backgroundColor: AppColors.border,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
                minHeight: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
