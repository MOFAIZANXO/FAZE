import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../contracts/widget_contracts.dart';

/// Exercise Widget for Dashboard
/// 
/// Shows weekly workout progress with dots.
/// Features the theme's primary blue accent.
class DashboardExerciseWidgetCard extends StatelessWidget {
  final DashboardExerciseWidget data;

  const DashboardExerciseWidgetCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Feedback.forTap(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Exercise screen coming soon!')),
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
                const Icon(Icons.fitness_center, color: AppColors.primaryBlue, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Exercise',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: data.completedToday 
                        ? AppColors.success.withOpacity(0.1) 
                        : AppColors.textTertiary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    data.completedToday ? 'COMPLETED' : 'PENDING',
                    style: TextStyle(
                      color: data.completedToday ? AppColors.success : AppColors.textTertiary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'This Week: ${data.weeklyWorkoutCount}/${data.weeklyGoal} workouts',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: List.generate(data.weeklyGoal, (index) {
                final isCompleted = index < data.weeklyWorkoutCount;
                return Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: isCompleted ? AppColors.primaryBlue : AppColors.border,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Feedback.forTap(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Workout logger coming soon!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('LOG WORKOUT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
