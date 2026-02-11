import 'package:flutter/material.dart';
import '../contracts/widget_contracts.dart';

/// Journal Widget for Dashboard
/// 
/// Shows streak counter with fire animation and daily progress dots.
/// Features a purple gradient background.
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
    const accentColor = Color(0xFF9C27B0);
    
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
          gradient: const LinearGradient(
            colors: [Color(0xFF7B1FA2), Color(0xFF4A148C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4A148C).withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.book, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Journal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
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
                        color: Colors.orange.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Text('🔥', style: TextStyle(fontSize: 14)),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.data.currentStreak} Day Streak',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Today\'s Progress',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
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
                    color: isCompleted ? Colors.white : Colors.white10,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isCompleted ? Colors.white : Colors.white24,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check,
                      color: isCompleted ? const Color(0xFF4A148C) : Colors.transparent,
                      size: 16,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            Text(
              '${widget.data.winsCompletedToday}/4 wins completed',
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
