import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/services/prayer_time_service.dart';
import '../../../core/theme/app_theme.dart';

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({super.key});

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  // Lahore coordinates (update these if user is in different location)
  static const double latitude = 31.5204;
  static const double longitude = 74.3587;
  
  late Map<String, DateTime> prayerTimes;
  late Map<String, dynamic> nextPrayer;
  
  @override
  void initState() {
    super.initState();
    _loadPrayerTimes();
  }
  
  void _loadPrayerTimes() {
    setState(() {
      prayerTimes = PrayerTimeService.calculatePrayerTimes(
        latitude: latitude,
        longitude: longitude,
      );
      nextPrayer = PrayerTimeService.getNextPrayer(
        latitude: latitude,
        longitude: longitude,
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'Prayer Times',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.textPrimary),
            onPressed: _loadPrayerTimes,
            tooltip: 'Refresh prayer times',
          ),
        ],
      ),
      body: Hero(
        tag: 'hero-prayer',
        child: Material(
          color: Colors.transparent,
          child: RefreshIndicator(
            onRefresh: () async {
              _loadPrayerTimes();
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Location info
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border, width: 1),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: AppColors.primaryBlue, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Lahore, Pakistan',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        DateFormat('EEEE, MMM d').format(DateTime.now()),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Next Prayer Card (Premium Highlight)
                _buildNextPrayerCard(theme),
                
                const SizedBox(height: 32),
                
                // Section Title
                Text(
                  "Today's Schedule",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                
                // All Prayer Times
                _buildPrayerTimeCard('Fajr', Icons.wb_twilight, prayerTimes['fajr']!, AppColors.fajrColor),
                const SizedBox(height: 12),
                _buildPrayerTimeCard('Sunrise', Icons.wb_sunny_outlined, prayerTimes['sunrise']!, AppColors.textTertiary),
                const SizedBox(height: 12),
                _buildPrayerTimeCard('Dhuhr', Icons.wb_sunny, prayerTimes['dhuhr']!, AppColors.dhuhrColor),
                const SizedBox(height: 12),
                _buildPrayerTimeCard('Asr', Icons.cloud_outlined, prayerTimes['asr']!, AppColors.asrColor),
                const SizedBox(height: 12),
                _buildPrayerTimeCard('Maghrib', Icons.nights_stay_outlined, prayerTimes['maghrib']!, AppColors.maghribColor),
                const SizedBox(height: 12),
                _buildPrayerTimeCard('Isha', Icons.nights_stay, prayerTimes['isha']!, AppColors.ishaColor),
                
                const SizedBox(height: 32),
                
                // Calculation method info
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceBackground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Calculation: University of Islamic Sciences, Karachi • School: Hanafi',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textTertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildNextPrayerCard(ThemeData theme) {
    final timeRemaining = PrayerTimeService.formatTimeRemaining(
      nextPrayer['timeRemaining'] as Duration,
    );
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryBlue, AppColors.deepBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'UPCOMING',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                DateFormat('h:mm a').format(nextPrayer['time'] as DateTime),
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            nextPrayer['name'] as String,
            style: theme.textTheme.displaySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.timer_outlined, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                'in $timeRemaining',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildPrayerTimeCard(String name, IconData icon, DateTime time, Color accentColor) {
    final isNext = nextPrayer['name'] == name;
    final theme = Theme.of(context);
    final formatter = DateFormat('h:mm a');
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isNext ? AppColors.surfaceBackground : AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isNext ? AppColors.primaryBlue : AppColors.border,
          width: isNext ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: accentColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            name,
            style: theme.textTheme.titleMedium?.copyWith(
              color: isNext ? AppColors.textPrimary : AppColors.textSecondary,
              fontWeight: isNext ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            formatter.format(time),
            style: theme.textTheme.titleMedium?.copyWith(
              color: isNext ? AppColors.primaryBlue : AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}