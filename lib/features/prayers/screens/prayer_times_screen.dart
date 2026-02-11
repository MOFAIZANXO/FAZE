import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/services/prayer_time_service.dart';

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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Prayer Times',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadPrayerTimes,
            tooltip: 'Refresh prayer times',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadPrayerTimes();
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Location info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.blue, size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    'Lahore, Pakistan',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const Spacer(),
                  Text(
                    DateFormat('EEEE, MMM d').format(DateTime.now()),
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Next Prayer Card
            _buildNextPrayerCard(),
            
            const SizedBox(height: 24),
            
            // All Prayer Times
            _buildPrayerTimeCard('Fajr', '🌅', prayerTimes['fajr']!),
            const SizedBox(height: 12),
            _buildPrayerTimeCard('Sunrise', '🌄', prayerTimes['sunrise']!),
            const SizedBox(height: 12),
            _buildPrayerTimeCard('Dhuhr', '☀️', prayerTimes['dhuhr']!),
            const SizedBox(height: 12),
            _buildPrayerTimeCard('Asr', '🌤️', prayerTimes['asr']!),
            const SizedBox(height: 12),
            _buildPrayerTimeCard('Maghrib', '🌆', prayerTimes['maghrib']!),
            const SizedBox(height: 12),
            _buildPrayerTimeCard('Isha', '🌙', prayerTimes['isha']!),
            
            const SizedBox(height: 24),
            
            // Calculation method info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Calculation: University of Islamic Sciences, Karachi\nSchool: Hanafi',
                style: TextStyle(color: Colors.white54, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildNextPrayerCard() {
    final timeRemaining = PrayerTimeService.formatTimeRemaining(
      nextPrayer['timeRemaining'] as Duration,
    );
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.blue.shade900],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'NEXT PRAYER',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                nextPrayer['name'] as String,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                DateFormat('h:mm a').format(nextPrayer['time'] as DateTime),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.timer_outlined, color: Colors.white70, size: 16),
              const SizedBox(width: 6),
              Text(
                'in $timeRemaining',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildPrayerTimeCard(String name, String emoji, DateTime time) {
    final isNext = nextPrayer['name'] == name;
    final formatter = DateFormat('h:mm a');
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isNext 
            ? Colors.blue.withOpacity(0.2)
            : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isNext 
              ? Colors.blue.withOpacity(0.5)
              : Colors.transparent,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 28),
          ),
          const SizedBox(width: 16),
          Text(
            name,
            style: TextStyle(
              color: isNext ? Colors.white : Colors.white70,
              fontSize: 18,
              fontWeight: isNext ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            formatter.format(time),
            style: TextStyle(
              color: isNext ? Colors.white : Colors.white70,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}