import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Productivity',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildFeatureCard(
            '✅ Tasks',
            'Manage your to-do list',
            Colors.green,
            () {
              // TODO: Navigate to tasks screen when built
            },
          ),
          const SizedBox(height: 12),
          _buildFeatureCard(
            '📝 Quick Notes',
            'Capture ideas instantly',
            Colors.yellow.shade700,
            () {
              // TODO: Navigate to notes screen when built
            },
          ),
          const SizedBox(height: 12),
          _buildFeatureCard(
            '🎂 Birthdays',
            'Never miss a celebration',
            Colors.pink,
            () {
              // TODO: Navigate to birthdays screen when built
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildFeatureCard(
    String title,
    String subtitle,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: () {
        // Show coming soon for now
      },
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