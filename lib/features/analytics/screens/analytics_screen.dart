import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// Analytics Screen
/// 
/// Shows:
/// - Progress charts
/// - Completion rates
/// - Streaks
/// - Insights
class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'Analytics',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2), width: 2),
              ),
              child: const Icon(
                Icons.insights,
                color: AppColors.primaryBlue,
                size: 64,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Your Progress',
              style: theme.textTheme.displaySmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Comprehensive insights into your growth and performance metrics across all pillars.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 48),
            
            _buildStatCard(context, 'Prayer Completion', '85%', Icons.mosque),
            const SizedBox(height: 16),
            _buildStatCard(context, 'Task Discovery', '72%', Icons.check_circle_outline),
            const SizedBox(height: 16),
            _buildStatCard(context, 'Journaling Streak', '7 days', Icons.auto_awesome),
            const SizedBox(height: 16),
            _buildStatCard(context, 'Hydration Target', '90%', Icons.water_drop),
            const SizedBox(height: 16),
            _buildStatCard(context, 'Exercise Consistency', '3/4', Icons.fitness_center),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatCard(BuildContext context, String label, String value, IconData icon) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryBlue.withOpacity(0.7), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}