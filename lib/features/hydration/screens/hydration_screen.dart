import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/hydration_providers.dart';
import '../services/hydration_service.dart';

class HydrationScreen extends ConsumerWidget {
  const HydrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              Text(
                'Error loading hydration data',
                style: const TextStyle(color: Colors.white),
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
          _buildGlassRow(summary),
          const SizedBox(height: 32),
          _buildStatsRow(summary),
          const SizedBox(height: 32),
          _buildWeeklyHistory(ref),
        ],
      ),
    );
  }

  Widget _buildProgressCircle(HydrationSummary summary) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: CircularProgressIndicator(
            value: summary.percentComplete,
            strokeWidth: 12,
            backgroundColor: Colors.cyan.withOpacity(0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.cyan),
          ),
        ),
        Column(
          children: [
            const Text('💧', style: TextStyle(fontSize: 40)),
            Text(
              '${summary.currentGlasses}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 52,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'of ${summary.targetGlasses} glasses',
              style: const TextStyle(color: Colors.white60, fontSize: 14),
            ),
          ],
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
        // Remove button - only enabled if > 0 glasses
        IconButton(
          onPressed: summary.currentGlasses > 0
              ? () async {
                  HapticFeedback.lightImpact();
                  try {
                    await ref.read(hydrationNotifierProvider.notifier).removeGlass();
                  } catch (e) {
                    // Silently ignore errors (already at 0)
                    debugPrint('Remove glass error: $e');
                  }
                }
              : null,
          icon: const Icon(Icons.remove_circle_outline),
          iconSize: 40,
          color: summary.currentGlasses > 0 
              ? Colors.white54 
              : Colors.white24,
          disabledColor: Colors.white24,
        ),
        const SizedBox(width: 24),

        // Add button
        GestureDetector(
          onTap: () async {
            HapticFeedback.mediumImpact();
            try {
              await ref.read(hydrationNotifierProvider.notifier).addGlass();
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error adding glass: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.cyan.shade400, Colors.cyan.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.cyan.withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('💧', style: TextStyle(fontSize: 32)),
                Text(
                  '+1 Glass',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 24),
        const SizedBox(width: 40), // Spacer for symmetry
      ],
    );
  }

  Widget _buildGlassRow(HydrationSummary summary) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: List.generate(
        summary.targetGlasses,
        (i) => Icon(
          i < summary.currentGlasses
              ? Icons.water_drop
              : Icons.water_drop_outlined,
          color: i < summary.currentGlasses ? Colors.cyan : Colors.white24,
          size: 32,
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
            '${summary.weeklyAverage.toStringAsFixed(1)}',
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
                          color: pct >= 1.0
                              ? Colors.cyan
                              : Colors.cyan.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(6),
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