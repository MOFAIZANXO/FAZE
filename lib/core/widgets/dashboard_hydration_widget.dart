import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faze/core/theme/app_theme.dart';
import 'package:faze/core/contracts/widget_contracts.dart';
import 'package:faze/features/hydration/providers/hydration_providers.dart';
import 'package:faze/core/widgets/wave_painter.dart';

/// Hydration Widget for Dashboard
/// 
/// Shows progress, glasses count, and live +/- controls.
/// Features a dynamic water wave background that fills the card.
class DashboardHydrationWidgetCard extends ConsumerStatefulWidget {
  final DashboardHydrationWidget data;

  const DashboardHydrationWidgetCard({
    super.key,
    required this.data,
  });

  @override
  ConsumerState<DashboardHydrationWidgetCard> createState() => _DashboardHydrationWidgetCardState();
}

class _DashboardHydrationWidgetCardState extends ConsumerState<DashboardHydrationWidgetCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch the live hydration summary for REAL-TIME updates
    final summaryAsync = ref.watch(hydrationSummaryProvider);
    
    // Prioritize the live summary data over the static widget.data
    // This fixed the "count not correct" issue.
    final summary = summaryAsync.valueOrNull;
    final currentGlasses = summary?.currentGlasses ?? widget.data.currentGlasses;
    final targetGlasses = summary?.targetGlasses ?? widget.data.targetGlasses;
    final percent = summary?.percentComplete ?? widget.data.percentComplete;

    return Hero(
      tag: 'hero-hydration',
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // 1. BACKGROUND: Animated Water Wave
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _waveController,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: WaterWavePainter(
                        fillPercent: percent,
                        wavePhase: _waveController.value,
                        colors: [
                          AppColors.primaryBlue.withOpacity(0.08),
                          AppColors.primaryBlue.withOpacity(0.2),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // 2. MIDDLE: Navigation Layer (InkWell that ignores children if they handle gestures)
              // Using Material + InkWell here for the "main" card tap
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Feedback.forTap(context);
                      context.push('/hydration');
                    },
                  ),
                ),
              ),

              // 3. TOP: Content & Controls (Non-greedy gesture handling)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header (Non-interactive)
                    IgnorePointer(
                      child: Row(
                        children: [
                          const Icon(Icons.water_drop, color: AppColors.primaryBlue, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Hydration',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '$currentGlasses/$targetGlasses glasses',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    
                    // Progress and Interactive Controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left side: Progress % (Non-interactive)
                        IgnorePointer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${(percent * 100).toInt()}%',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Complete',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: AppColors.textTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Right side: Quick Controls (These MUST be on top to catch taps)
                        Row(
                          children: [
                            _ControlButton(
                              icon: Icons.remove,
                              onPressed: currentGlasses > 0 
                                ? () {
                                    // Use read for the callback to avoid rebuilding during build
                                    ref.read(hydrationNotifierProvider.notifier).removeGlass();
                                  }
                                : null,
                            ),
                            const SizedBox(width: 12),
                            _ControlButton(
                              icon: Icons.add,
                              isPrimary: true,
                              onPressed: () {
                                ref.read(hydrationNotifierProvider.notifier).addGlass();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Helper Widget for +/- buttons
class _ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isPrimary;

  const _ControlButton({
    required this.icon,
    this.onPressed,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed != null ? () {
          Feedback.forTap(context);
          onPressed!();
        } : null,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isPrimary 
                ? AppColors.primaryBlue.withOpacity(0.2) 
                : AppColors.border.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isPrimary 
                  ? AppColors.primaryBlue.withOpacity(0.5) 
                  : AppColors.border.withOpacity(0.2),
            ),
          ),
          child: Icon(
            icon,
            key: Key('hydration_${icon == Icons.add ? "add" : "remove"}_btn'),
            color: onPressed != null 
                ? (isPrimary ? AppColors.primaryBlue : Colors.white70)
                : Colors.white24,
            size: 20,
          ),
        ),
      ),
    );
  }
}