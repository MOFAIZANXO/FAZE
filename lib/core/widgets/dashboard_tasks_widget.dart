import 'package:flutter/material.dart';
import '../contracts/widget_contracts.dart';

/// Tasks Widget for Dashboard
/// 
/// Shows top 3 tasks with checkboxes and completion progress.
/// Features a green accent color.
class DashboardTasksWidgetCard extends StatelessWidget {
  final DashboardTasksWidget data;

  const DashboardTasksWidgetCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xFF4CAF50);

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
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: accentColor.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.check_circle, color: accentColor, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Today\'s Tasks',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  '${data.completedTasks}/${data.totalTasks} done',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...data.topTaskTitles.map((title) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.radio_button_unchecked,
                        color: Colors.white30,
                        size: 18,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
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
                padding: const EdgeInsets.only(top: 4, left: 30),
                child: Text(
                  '+ ${data.totalTasks - 3} more tasks',
                  style: const TextStyle(
                    color: Colors.white30,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: data.totalTasks > 0 ? data.completedTasks / data.totalTasks : 0,
                backgroundColor: Colors.white10,
                valueColor: const AlwaysStoppedAnimation<Color>(accentColor),
                minHeight: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
