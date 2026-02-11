import 'package:flutter/material.dart';
import '../contracts/widget_contracts.dart';

/// Exercise Widget for Dashboard
/// 
/// Shows weekly workout progress with dots.
/// Features an orange accent color.
class DashboardExerciseWidgetCard extends StatelessWidget {
  final DashboardExerciseWidget data;

  const DashboardExerciseWidgetCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xFFFF9800);

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
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: accentColor.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.fitness_center, color: accentColor, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Exercise',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: data.completedToday 
                        ? Colors.green.withOpacity(0.2) 
                        : Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    data.completedToday ? 'COMPLETED' : 'PENDING',
                    style: TextStyle(
                      color: data.completedToday ? Colors.green : Colors.white38,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'This Week: ${data.weeklyWorkoutCount}/${data.weeklyGoal} workouts',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: List.generate(data.weeklyGoal, (index) {
                final isCompleted = index < data.weeklyWorkoutCount;
                return Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: isCompleted ? accentColor : Colors.white12,
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
                  backgroundColor: accentColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 8),
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
