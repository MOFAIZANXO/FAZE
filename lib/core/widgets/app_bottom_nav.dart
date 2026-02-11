import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

/// Premium Bottom Navigation Bar
/// 
/// Features:
/// - Animated indicator line
/// - Haptic feedback
/// - Icon state changes (outlined → filled)
/// - Smooth transitions
class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cardBackground,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                index: 0,
                label: 'Home',
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
              ),
              _buildNavItem(
                context,
                index: 1,
                label: 'Daily',
                icon: Icons.wb_sunny_outlined,
                activeIcon: Icons.wb_sunny,
              ),
              _buildNavItem(
                context,
                index: 2,
                label: 'Tasks',
                icon: Icons.check_circle_outline,
                activeIcon: Icons.check_circle,
              ),
              _buildNavItem(
                context,
                index: 3,
                label: 'Journal',
                icon: Icons.book_outlined,
                activeIcon: Icons.book,
              ),
              _buildNavItem(
                context,
                index: 4,
                label: 'Stats',
                icon: Icons.insights_outlined,
                activeIcon: Icons.insights,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required String label,
    required IconData icon,
    required IconData activeIcon,
  }) {
    final isActive = currentIndex == index;
    final color = isActive ? AppColors.primaryBlue : AppColors.textTertiary;

    return Expanded(
      child: InkWell(
        onTap: () {
          if (index != currentIndex) {
            HapticFeedback.lightImpact();
            onTap(index);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: color,
              size: 24, // Slightly smaller for a cleaner look
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10, // Modern minimal typography
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 4),
            // Animated indicator line
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: isActive ? 16 : 0,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}