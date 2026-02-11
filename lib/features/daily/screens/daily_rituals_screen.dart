import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Daily Rituals Screen
/// 
/// Combines:
/// - Prayer times
/// - Hydration tracker
/// - Exercise logger
class DailyRitualsScreen extends StatelessWidget {
  const DailyRitualsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Daily Rituals',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildFeatureCard(
            context,
            '🕌 Prayer Times',
            'View today\'s prayer schedule',
            Colors.blue,
            () => context.push('/prayer-times'),
          ),
          const SizedBox(height: 12),
          _buildFeatureCard(
            context,
            '💧 Hydration Tracker',
            'Track your water intake',
            Colors.cyan,
            () {
              // TODO: Navigate to hydration screen when built
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Coming soon!')),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildFeatureCard(
            context,
            '🏋️ Exercise Logger',
            'Log your workouts',
            Colors.orange,
            () {
              // TODO: Navigate to exercise screen when built
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Coming soon!')),
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
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: color, size: 20),
          ],
        ),
      ),
    );
  }
}