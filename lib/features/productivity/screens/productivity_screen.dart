import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// Productivity Screen
/// 
/// Combines:
/// - Tasks
/// - Quick Notes
/// - Birthday Tracker
class ProductivityScreen extends StatelessWidget {
  const ProductivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'Productivity',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildFeatureCard(
            context,
            'Tasks',
            'Manage your daily to-do list',
            Icons.check_circle_outline,
            () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tasks management coming soon!')),
              );
            },
          ),
          const SizedBox(height: 16),
          _buildFeatureCard(
            context,
            'Quick Notes',
            'Capture ideas and thoughts instantly',
            Icons.note_alt_outlined,
            () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notes feature coming soon!')),
              );
            },
          ),
          const SizedBox(height: 16),
          _buildFeatureCard(
            context,
            'Birthdays',
            'Track and celebrate special days',
            Icons.cake_outlined,
            () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Birthday tracker coming soon!')),
              );
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    final theme = Theme.of(context);
    
    return Material(
      color: AppColors.cardBackground,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: AppColors.primaryBlue.withOpacity(0.1),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primaryBlue,
                  size: 24,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.textTertiary,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}