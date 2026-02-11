import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';

class PrayerTimeService {
  /// Calculate accurate prayer times for a given date and location
  /// 
  /// Uses University of Islamic Sciences, Karachi method (most accurate for Pakistan)
  /// Fajr angle: 18°, Isha angle: 18°
  /// Asr calculation: Hanafi (shadow = 2x object length)
  static Map<String, DateTime> calculatePrayerTimes({
    required double latitude,
    required double longitude,
    DateTime? date,
  }) {
    final now = date ?? DateTime.now();
    
    // Create coordinates for the location
    final coordinates = Coordinates(latitude, longitude);
    
    // Set calculation parameters for Karachi method (most accurate for Pakistan)
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi; // Hanafi school for Asr calculation
    
    // Calculate prayer times
    final prayerTimes = PrayerTimes.today(coordinates, params);
    
    // Return all prayer times
    return {
      'fajr': prayerTimes.fajr,
      'sunrise': prayerTimes.sunrise,
      'dhuhr': prayerTimes.dhuhr,
      'asr': prayerTimes.asr,
      'maghrib': prayerTimes.maghrib,
      'isha': prayerTimes.isha,
    };
  }
  
  /// Get formatted prayer times as strings
  static Map<String, String> getFormattedPrayerTimes({
    required double latitude,
    required double longitude,
    DateTime? date,
  }) {
    final times = calculatePrayerTimes(
      latitude: latitude,
      longitude: longitude,
      date: date,
    );
    
    final formatter = DateFormat('h:mm a');
    
    return {
      'fajr': formatter.format(times['fajr']!),
      'sunrise': formatter.format(times['sunrise']!),
      'dhuhr': formatter.format(times['dhuhr']!),
      'asr': formatter.format(times['asr']!),
      'maghrib': formatter.format(times['maghrib']!),
      'isha': formatter.format(times['isha']!),
    };
  }
  
  /// Get the next prayer name and time
  static Map<String, dynamic> getNextPrayer({
    required double latitude,
    required double longitude,
  }) {
    final times = calculatePrayerTimes(
      latitude: latitude,
      longitude: longitude,
    );
    
    final now = DateTime.now();
    
    // Check each prayer in order
    final prayers = [
      {'name': 'Fajr', 'time': times['fajr']!},
      {'name': 'Sunrise', 'time': times['sunrise']!},
      {'name': 'Dhuhr', 'time': times['dhuhr']!},
      {'name': 'Asr', 'time': times['asr']!},
      {'name': 'Maghrib', 'time': times['maghrib']!},
      {'name': 'Isha', 'time': times['isha']!},
    ];
    
    // Find the next prayer
    for (final prayer in prayers) {
      if (now.isBefore(prayer['time'] as DateTime)) {
        return {
          'name': prayer['name'],
          'time': prayer['time'],
          'timeRemaining': (prayer['time'] as DateTime).difference(now),
        };
      }
    }
    
    // If all prayers passed, next is Fajr tomorrow
    final tomorrowTimes = calculatePrayerTimes(
      latitude: latitude,
      longitude: longitude,
      date: DateTime.now().add(const Duration(days: 1)),
    );
    
    return {
      'name': 'Fajr',
      'time': tomorrowTimes['fajr']!,
      'timeRemaining': tomorrowTimes['fajr']!.difference(now),
    };
  }
  
  /// Format time remaining as "2h 15m" or "45m"
  static String formatTimeRemaining(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
  
  /// Check if it's currently prayer time (within 15 minutes)
  static bool isCurrentlyPrayerTime({
    required String prayerName,
    required DateTime prayerTime,
  }) {
    final now = DateTime.now();
    final difference = now.difference(prayerTime).abs();
    return difference.inMinutes <= 15;
  }
}

// Example usage for Lahore:
// 
// void main() {
//   final times = PrayerTimeService.calculatePrayerTimes(
//     latitude: 31.5204,
//     longitude: 74.3587,
//   );
//   
//   print('Fajr: ${DateFormat('h:mm a').format(times['fajr']!)}');
//   print('Dhuhr: ${DateFormat('h:mm a').format(times['dhuhr']!)}');
//   
//   final next = PrayerTimeService.getNextPrayer(
//     latitude: 31.5204,
//     longitude: 74.3587,
//   );
//   
//   print('Next prayer: ${next['name']} in ${PrayerTimeService.formatTimeRemaining(next['timeRemaining'])}');
// }