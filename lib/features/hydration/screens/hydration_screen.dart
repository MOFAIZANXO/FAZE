import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faze/features/hydration/providers/hydration_providers.dart';
import 'package:faze/features/hydration/services/hydration_service.dart';
import 'package:faze/core/widgets/wave_painter.dart';

class HydrationScreen extends ConsumerStatefulWidget {
  const HydrationScreen({super.key});

  @override
  ConsumerState<HydrationScreen> createState() => _HydrationScreenState();
}

class _HydrationScreenState extends ConsumerState<HydrationScreen>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  late Animation<double> _waveAnimation;
  late AnimationController _buttonController;
  late Animation<double> _buttonScale;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _waveAnimation = Tween<double>(begin: 0, end: 1).animate(_waveController);

    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _buttonScale = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _waveController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  void _showCelebration(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 600),
          curve: Curves.elasticOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.green.shade700,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '🎉',
                      style: TextStyle(fontSize: 64),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Daily Goal Reached!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Great job staying hydrated!',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );

    // Auto-dismiss after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted && Navigator.canPop(context)) Navigator.pop(context);
    });
  }

  void _showResetConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF121212),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Reset Progress', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Are you sure you want to clear today\'s hydration progress?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () {
              ref.read(hydrationNotifierProvider.notifier).resetTodayProgress();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Progress reset for today'),
                  backgroundColor: Color(0xFF01579B),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Reset', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final summaryAsync = ref.watch(hydrationNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Hydration',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.white70),
            tooltip: 'Reset Today',
            onPressed: () => _showResetConfirmation(context, ref),
          ),
        ],
      ),
      body: summaryAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: Colors.cyan),
        ),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              const Text(
                'Error loading hydration data',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                e.toString(),
                style: const TextStyle(color: Colors.white54, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        data: (summary) => _buildContent(context, ref, summary),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    HydrationSummary summary,
  ) {
    return Hero(
      tag: 'hero-hydration',
      child: Material(
        color: Colors.transparent,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildProgressSquare(summary),
              const SizedBox(height: 24),
              _buildControls(context, ref, summary),
              const SizedBox(height: 32),
              Text(
                summary.motivationMessage,
                style: TextStyle(
                  color: const Color(0xFF4FC3F7).withOpacity(0.8),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              _buildWeeklyHistory(ref),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressSquare(HydrationSummary summary) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Square Background with Water fill
            Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                color: const Color(0xFF0A1628),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Stack(
                  children: [
                    // Water fill with wave
                    AnimatedBuilder(
                      animation: _waveAnimation,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: WaterWavePainter(
                            fillPercent: summary.percentComplete.clamp(0.01, 1.0),
                            wavePhase: _waveAnimation.value,
                          ),
                          size: const Size(280, 280),
                        );
                      },
                    ),
                    
                    // Glass Overlay Effect
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.05),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Text overlay
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${summary.currentGlasses}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 84,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '/ ${summary.targetGlasses}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Last Drink prominent stat
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.access_time_filled, color: Color(0xFF4FC3F7), size: 16),
              const SizedBox(width: 8),
              Text(
                'Last Drink: ${summary.lastDrinkFormatted}',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildControls(
    BuildContext context,
    WidgetRef ref,
    HydrationSummary summary,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Minus button
        _minimalControlButton(
          icon: Icons.remove_rounded,
          onTap: summary.currentGlasses > 0
              ? () async {
                  HapticFeedback.lightImpact();
                  await ref.read(hydrationNotifierProvider.notifier).removeGlass();
                }
              : null,
          enabled: summary.currentGlasses > 0,
        ),
        
        const SizedBox(width: 48),

        // Plus button
        _minimalControlButton(
          icon: Icons.add_rounded,
          isPrimary: true,
          onTap: summary.currentGlasses < summary.targetGlasses
              ? () async {
                  HapticFeedback.mediumImpact();
                  final oldGlasses = summary.currentGlasses;
                  await ref.read(hydrationNotifierProvider.notifier).addGlass();

                  if (oldGlasses < summary.targetGlasses &&
                      (oldGlasses + 1) >= summary.targetGlasses) {
                    await Future.delayed(const Duration(milliseconds: 300));
                    if (mounted) _showCelebration(context);
                  }
                }
              : null,
          enabled: summary.currentGlasses < summary.targetGlasses,
        ),
      ],
    );
  }

  Widget _minimalControlButton({
    required IconData icon,
    required VoidCallback? onTap,
    bool enabled = true,
    bool isPrimary = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: isPrimary 
              ? const Color(0xFF0288D1) 
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isPrimary 
                ? const Color(0xFF4FC3F7).withOpacity(0.5) 
                : Colors.white.withOpacity(0.1),
          ),
          boxShadow: isPrimary ? [
            BoxShadow(
              color: const Color(0xFF0288D1).withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 2,
            )
          ] : null,
        ),
        child: Icon(
          icon,
          color: enabled ? Colors.white : Colors.white24,
          size: 32,
        ),
      ),
    );
  }
  Widget _buildWeeklyHistory(WidgetRef ref) {
    final historyAsync = ref.watch(hydrationHistoryProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Weekly History',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),
        historyAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: Color(0xFF0288D1)),
          ),
          error: (e, _) => const SizedBox.shrink(),
          data: (daysList) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: daysList.map((day) {
              const target = 8; 
              final pct = day.glasses / target;
              final dayLabel = ['M', 'T', 'W', 'T', 'F', 'S', 'S'][day.date.weekday - 1];

              return Column(
                children: [
                  Text(
                    '${(pct * 100).toInt()}%',
                    style: TextStyle(
                      color: (pct >= 1.0 ? const Color(0xFF4FC3F7) : Colors.white)
                          .withOpacity(0.6),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: 32,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeOutCubic,
                          width: double.infinity,
                          height: (80 * pct.clamp(0.0, 1.0)).toDouble(),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color(0xFF4FC3F7),
                                const Color(0xFF0288D1),
                                const Color(0xFF01579B),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: pct >= 1.0
                                ? [
                                    BoxShadow(
                                      color: const Color(0xFF0288D1).withOpacity(0.3),
                                      blurRadius: 10,
                                      spreadRadius: 1,
                                    ),
                                  ]
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dayLabel,
                    style: TextStyle(
                      color: day.date.day == DateTime.now().day
                          ? const Color(0xFF4FC3F7)
                          : Colors.white54,
                      fontSize: 12,
                      fontWeight: day.date.day == DateTime.now().day
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
