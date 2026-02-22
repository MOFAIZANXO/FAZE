import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/hydration_providers.dart';
import '../services/hydration_service.dart';

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

  @override
  Widget build(BuildContext context) {
    final summaryAsync = ref.watch(hydrationNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'AquaFlow',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white70),
            onPressed: () => _showTargetPicker(context, ref),
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildProgressCircle(summary),
          const SizedBox(height: 16),
          Text(
            summary.motivationMessage,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          _buildControls(context, ref, summary),
          const SizedBox(height: 32),
          _buildGlassRow(summary, ref),
          const SizedBox(height: 40),
          _buildStatsRow(summary),
          const SizedBox(height: 40),
          _buildWeeklyHistory(ref),
        ],
      ),
    );
  }

  Widget _buildProgressCircle(HydrationSummary summary) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer glow
        Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),

        // Animated water fill
        SizedBox(
          width: 200,
          height: 200,
          child: ClipOval(
            child: Stack(
              children: [
                // Dark background
                Container(
                  color: const Color(0xFF0A1628),
                ),

                // Water fill with wave
                AnimatedBuilder(
                  animation: _waveAnimation,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: WaterWavePainter(
                        fillPercent: summary.percentComplete,
                        wavePhase: _waveAnimation.value,
                      ),
                      size: const Size(200, 200),
                    );
                  },
                ),

                // Text overlay
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${summary.currentGlasses}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 52,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'of ${summary.targetGlasses}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      const Text(
                        'glasses',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
        IconButton(
          onPressed: summary.currentGlasses > 0
              ? () async {
                  HapticFeedback.lightImpact();
                  try {
                    await ref.read(hydrationNotifierProvider.notifier).removeGlass();
                  } catch (e) {
                    debugPrint('Remove glass error: $e'); // Silent error
                  }
                }
              : null,
          icon: const Icon(Icons.remove_circle_outline),
          iconSize: 40,
          color: summary.currentGlasses > 0 ? Colors.white54 : Colors.white24,
          disabledColor: Colors.white24,
        ),
        const SizedBox(width: 24),

        // Add button
        GestureDetector(
          onTapDown: (_) => _buttonController.forward(),
          onTapUp: (_) async {
            _buttonController.reverse();
            HapticFeedback.mediumImpact();

            final oldGlasses = summary.currentGlasses;
            await ref.read(hydrationNotifierProvider.notifier).addGlass();

            // Check if goal just reached
            if (oldGlasses < summary.targetGlasses &&
                (oldGlasses + 1) >= summary.targetGlasses) {
              await Future.delayed(const Duration(milliseconds: 300));
              if (mounted) _showCelebration(context);
            }
          },
          onTapCancel: () => _buttonController.reverse(),
          child: ScaleTransition(
            scale: _buttonScale,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: summary.goalReached
                      ? [Colors.green.shade400, Colors.green.shade700]
                      : [Colors.cyan.shade300, Colors.cyan.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: (summary.goalReached ? Colors.green : Colors.cyan)
                        .withOpacity(0.5),
                    blurRadius: 25,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    summary.goalReached ? '🎉' : '💧',
                    style: const TextStyle(fontSize: 36),
                  ),
                  Text(
                    summary.goalReached ? 'Done!' : '+1',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 24),
        const SizedBox(width: 40), // Spacer for symmetry
      ],
    );
  }

  Widget _buildGlassRow(HydrationSummary summary, WidgetRef ref) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: List.generate(
        summary.targetGlasses,
        (i) => _AnimatedGlass(
          index: i,
          isFilled: i < summary.currentGlasses,
          onTap: () async {
            HapticFeedback.lightImpact();
            final newCount = i + 1;
            await ref.read(hydrationNotifierProvider.notifier).setGlasses(newCount);
            
            // Celebration check for manual setting
            if (i < summary.targetGlasses && newCount >= summary.targetGlasses) {
               await Future.delayed(const Duration(milliseconds: 300));
               if (mounted) _showCelebration(context);
            }
          },
        ),
      ),
    );
  }

  Widget _buildStatsRow(HydrationSummary summary) {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            '${summary.currentStreak}🔥',
            'Day Streak',
            Colors.orange,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            summary.lastDrinkFormatted,
            'Last Drink',
            Colors.cyan,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            summary.weeklyAverage.toStringAsFixed(1),
            '7-day Avg',
            Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _statCard(String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: color, fontSize: 11),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyHistory(WidgetRef ref) {
    final historyAsync = ref.watch(hydrationHistoryProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'This Week',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        historyAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: Colors.cyan),
          ),
          error: (e, _) => const SizedBox.shrink(),
          data: (daysList) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: daysList.map((day) {
              final pct = day.glasses / 8; // Assuming 8 glass target
              final dayLabel = ['M', 'T', 'W', 'T', 'F', 'S', 'S']
                  [day.date.weekday - 1];

              return Column(
                children: [
                  Text(
                    '${(pct * 100).toInt()}%',
                    style: const TextStyle(color: Colors.white70, fontSize: 10),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 28,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.cyan.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.cyan.withOpacity(0.2)),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 28,
                        height: (60 * pct.clamp(0.0, 1.0)).toDouble(),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: pct >= 1.0
                                ? [Colors.cyan.shade300, Colors.cyan.shade700]
                                : [
                                    Colors.cyan.withOpacity(0.4),
                                    Colors.cyan.withOpacity(0.6),
                                  ],
                          ),
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: pct >= 1.0
                              ? [
                                  BoxShadow(
                                    color: Colors.cyan.withOpacity(0.3),
                                    blurRadius: 8,
                                  ),
                                ]
                              : null,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dayLabel,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _showTargetPicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Set Daily Target',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ...([6, 7, 8, 9, 10, 12].map(
              (n) => ListTile(
                title: Text(
                  '$n glasses',
                  style: const TextStyle(color: Colors.white),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.white54),
                onTap: () async {
                  try {
                    await ref.read(hydrationNotifierProvider.notifier).setTarget(n);
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    debugPrint('Set target error: $e');
                  }
                },
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class WaterWavePainter extends CustomPainter {
  final double fillPercent;
  final double wavePhase;

  WaterWavePainter({
    required this.fillPercent,
    required this.wavePhase,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final waterPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.cyan.withOpacity(0.7),
          Colors.cyan.shade700,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    final waterLevel = size.height * (1 - fillPercent);

    // Start path
    path.moveTo(0, waterLevel);

    // Create wave
    for (double x = 0; x <= size.width; x += 1) {
      final y = waterLevel +
          8 * sin((x / size.width * 2 * pi) + (wavePhase * 2 * pi));
      path.lineTo(x, y);
    }

    // Complete path
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, waterPaint);

    // Add wave shimmer
    final shimmerPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final shimmerPath = Path();
    shimmerPath.moveTo(0, waterLevel);
    for (double x = 0; x <= size.width; x += 1) {
      final y = waterLevel +
          8 * sin((x / size.width * 2 * pi) + (wavePhase * 2 * pi));
      shimmerPath.lineTo(x, y);
    }
    canvas.drawPath(shimmerPath, shimmerPaint);
  }

  @override
  bool shouldRepaint(WaterWavePainter old) =>
      old.fillPercent != fillPercent || old.wavePhase != wavePhase;
}

class _AnimatedGlass extends StatefulWidget {
  final int index;
  final bool isFilled;
  final VoidCallback onTap;

  const _AnimatedGlass({
    required this.index,
    required this.isFilled,
    required this.onTap,
  });

  @override
  State<_AnimatedGlass> createState() => _AnimatedGlassState();
}

class _AnimatedGlassState extends State<_AnimatedGlass>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.elasticOut,
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.isFilled
                ? Colors.cyan.withOpacity(0.2)
                : Colors.transparent,
            border: Border.all(
              color: widget.isFilled ? Colors.cyan : Colors.white24,
              width: 1.5,
            ),
          ),
          child: Icon(
            widget.isFilled ? Icons.water_drop : Icons.water_drop_outlined,
            color: widget.isFilled ? Colors.cyan : Colors.white24,
            size: 18,
          ),
        ),
      ),
    );
  }
}