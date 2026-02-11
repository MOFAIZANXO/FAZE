import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../contracts/widget_contracts.dart';

/// Journal Widget for Dashboard
/// 
/// Shows streak counter with fire animation and daily progress dots.
/// Features the theme's primary blue accent.
class DashboardJournalWidgetCard extends StatefulWidget {
  final DashboardJournalWidget data;

  const DashboardJournalWidgetCard({
    super.key,
    required this.data,
  });

  @override
  State<DashboardJournalWidgetCard> createState() => _DashboardJournalWidgetCardState();
}

class _DashboardJournalWidgetCardState extends State<DashboardJournalWidgetCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _fireController;
  late Animation<double> _fireAnimation;

  @override
  void initState() {
    super.initState();
    _fireController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fireAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _fireController, curve: Curves.easeInOut),
    );

    if (widget.data.currentStreak > 5) {
      _fireController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _fireController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Feedback.forTap(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Journal screen coming soon!')),
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
                const Icon(Icons.book, color: AppColors.primaryBlue, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Journal',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                if (widget.data.currentStreak > 0)
                  ScaleTransition(
                    scale: _fireAnimation,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Text('🔥', style: TextStyle(fontSize: 12)),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.data.currentStreak} Day Streak',
                            style: const TextStyle(
                              color: Colors.orange,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Today\'s Progress',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: List.generate(4, (index) {
                final isCompleted = index < widget.data.winsCompletedToday;
                return Container(
                  width: 32,
                  height: 32,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: isCompleted ? AppColors.primaryBlue : AppColors.surfaceBackground,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isCompleted ? AppColors.primaryBlue : AppColors.border,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check,
                      color: isCompleted ? Colors.white : Colors.transparent,
                      size: 16,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            Text(
              '${widget.data.winsCompletedToday}/4 wins completed',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
