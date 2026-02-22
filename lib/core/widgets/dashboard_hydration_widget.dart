import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../contracts/widget_contracts.dart';

/// Hydration Widget for Dashboard
/// 
/// Shows progress bar, glasses count, and water drop icons.
/// Features the theme's primary blue accent.
class DashboardHydrationWidgetCard extends StatelessWidget {
  final DashboardHydrationWidget data;

  const DashboardHydrationWidgetCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Feedback.forTap(context);
        context.push('/hydration');  // ✅ FIXED: Navigate to hydration screen
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
                  '${data.currentGlasses}/${data.targetGlasses} glasses',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: List.generate(data.targetGlasses, (index) {
                final isFilled = index < data.currentGlasses;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Icon(
                      Icons.water_drop,
                      color: isFilled ? AppColors.primaryBlue : AppColors.border,
                      size: 16,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: data.percentComplete,
                backgroundColor: AppColors.border,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '${(data.percentComplete * 100).toInt()}% complete',
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