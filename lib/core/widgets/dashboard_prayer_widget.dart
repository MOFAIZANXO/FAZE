import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../contracts/widget_contracts.dart';
import '../theme/app_theme.dart';

/// Beautiful Prayer Widget for Dashboard
/// 
/// Shows next prayer name, time, and animated countdown.
/// Features a blue gradient background and pulse animation near prayer time.
class DashboardPrayerWidgetCard extends StatefulWidget {
  final DashboardPrayerWidget data;

  const DashboardPrayerWidgetCard({
    super.key,
    required this.data,
  });

  @override
  State<DashboardPrayerWidgetCard> createState() => _DashboardPrayerWidgetCardState();
}

class _DashboardPrayerWidgetCardState extends State<DashboardPrayerWidgetCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    if (widget.data.isCurrentlyPrayerTime) {
      _pulseController.repeat(reverse: true);
    }

    // Update countdown every minute if needed (though data comes from service)
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _pulseAnimation,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Feedback.forTap(context);
            context.push('/prayer-times');
          },
          borderRadius: BorderRadius.circular(16),
          splashColor: AppColors.primaryBlue.withOpacity(0.1),
          highlightColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryBlue, AppColors.deepBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryBlue.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.mosque, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'NEXT PRAYER',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'ACTIVE',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      widget.data.nextPrayerName.toUpperCase(),
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                    ),
                    Text(
                      _formatTime(widget.data.nextPrayerTime),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      'in ${widget.data.timeRemaining}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withOpacity(0.8),
                          ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: _calculateProgress(),
                          backgroundColor: Colors.white.withOpacity(0.1),
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                          minHeight: 4,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour > 12 ? time.hour - 12 : (time.hour == 0 ? 12 : time.hour);
    final period = time.hour >= 12 ? 'PM' : 'AM';
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }

  double _calculateProgress() {
    // This is a simplified progress. In a real app, you'd calculate 
    // progress between previous and next prayer.
    // For now, let's just show a static-ish filled state or mock it.
    return 0.7; // 70% progress as per design direction
  }
}
