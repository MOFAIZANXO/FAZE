import 'package:flutter/material.dart';
import '../../../core/contracts/widget_contracts.dart';
import '../services/dashboard_service.dart';

/// Dashboard Screen - Main home screen
/// 
/// Shows widget grid with all feature summaries:
/// - Next prayer
/// - Hydration progress
/// - Today's tasks
/// - Journal streak
/// - Exercise status
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late DashboardData _data;
  
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  
  void _loadData() {
    setState(() {
      _data = DashboardService.getDashboardData();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'FAZE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadData,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => _loadData(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              _buildGreeting(),
              const SizedBox(height: 24),
              
              // Quick Stats Row
              _buildQuickStats(),
              const SizedBox(height: 24),
              
              // Main Widget Grid
              Text(
                'Today\'s Overview',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              // AG will replace these with beautiful widgets
              _buildPrayerWidget(_data.prayer),
              const SizedBox(height: 12),
              _buildHydrationWidget(_data.hydration),
              const SizedBox(height: 12),
              _buildTasksWidget(_data.tasks),
              const SizedBox(height: 12),
              _buildJournalWidget(_data.journal),
              const SizedBox(height: 12),
              _buildExerciseWidget(_data.exercise),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildGreeting() {
    final hour = DateTime.now().hour;
    final greeting = hour < 12 
        ? 'Good Morning' 
        : hour < 17 
            ? 'Good Afternoon' 
            : 'Good Evening';
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          greeting,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Ready to make progress?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
  
  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            '${_data.journal.currentStreak}',
            'Day Streak',
            Icons.local_fire_department,
            Colors.orange,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            '${_data.tasks.completedTasks}/${_data.tasks.totalTasks}',
            'Tasks Done',
            Icons.check_circle,
            Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            '${(_data.hydration.percentComplete * 100).toInt()}%',
            'Hydrated',
            Icons.water_drop,
            Colors.blue,
          ),
        ),
      ],
    );
  }
  
  Widget _buildStatCard(String value, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
  
  // PLACEHOLDER WIDGETS - AG will make these beautiful
  
  Widget _buildPrayerWidget(DashboardPrayerWidget data) {
    return _buildPlaceholderCard(
      '🕌 Next Prayer',
      '${data.nextPrayerName} • ${data.timeRemaining}',
      Colors.blue,
    );
  }
  
  Widget _buildHydrationWidget(DashboardHydrationWidget data) {
    return _buildPlaceholderCard(
      '💧 Hydration',
      '${data.currentGlasses}/${data.targetGlasses} glasses',
      Colors.cyan,
    );
  }
  
  Widget _buildTasksWidget(DashboardTasksWidget data) {
    return _buildPlaceholderCard(
      '✅ Tasks',
      '${data.completedTasks}/${data.totalTasks} completed',
      Colors.green,
    );
  }
  
  Widget _buildJournalWidget(DashboardJournalWidget data) {
    return _buildPlaceholderCard(
      '📓 Journal',
      '${data.winsCompletedToday}/4 wins today',
      Colors.purple,
    );
  }
  
  Widget _buildExerciseWidget(DashboardExerciseWidget data) {
    return _buildPlaceholderCard(
      '🏋️ Exercise',
      '${data.weeklyWorkoutCount}/${data.weeklyGoal} workouts this week',
      Colors.orange,
    );
  }
  
  Widget _buildPlaceholderCard(String title, String subtitle, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
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
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: color, size: 16),
        ],
      ),
    );
  }
}