import 'package:flutter/material.dart';
import '../contracts/widget_contracts.dart';

/// Hydration Widget for Dashboard
/// 
/// Shows progress bar, glasses count, and water drop icons.
/// Features a cyan accent color and smooth progress animation.
class DashboardHydrationWidgetCard extends StatelessWidget {
  final DashboardHydrationWidget data;

  const DashboardHydrationWidgetCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xFF00BCD4);
    
    return GestureDetector(
      onTap: () {
        Feedback.forTap(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Hydration screen coming soon!')),
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
                const Icon(Icons.water_drop, color: accentColor, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Hydration',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  '${data.currentGlasses}/${data.targetGlasses} glasses',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: List.generate(data.targetGlasses, (index) {
                final isFilled = index < data.currentGlasses;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Icon(
                      Icons.water_drop,
                      color: isFilled ? accentColor : Colors.white12,
                      size: 18,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: data.percentComplete,
                backgroundColor: Colors.white10,
                valueColor: const AlwaysStoppedAnimation<Color>(accentColor),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '${(data.percentComplete * 100).toInt()}% complete',
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
