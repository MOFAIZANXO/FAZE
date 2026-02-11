import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'core/theme/app_theme.dart';
import 'data/services/database_service.dart';
import 'data/services/prayer_time_service.dart';
import 'data/models/prayer_log.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await DatabaseService.initialize();
  runApp(const ProviderScope(child: FazeApp()));
}

class FazeApp extends StatelessWidget {
  const FazeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FAZE',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const PrayerTestScreen(),
    );
  }
}

class PrayerTestScreen extends StatefulWidget {
  const PrayerTestScreen({super.key});

  @override
  State<PrayerTestScreen> createState() => _PrayerTestScreenState();
}

class _PrayerTestScreenState extends State<PrayerTestScreen> {
  PrayerTimes? _times;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    final t = PrayerTimeService.calculatePrayerTimes(
      latitude: 31.5497,
      longitude: 74.3436,
      date: DateTime.now(),
      method: CalculationMethod.karachi,
    );
    setState(() => _times = t);
  }

  String _fmt(DateTime t) {
    final h = t.hour > 12 ? t.hour - 12 : (t.hour == 0 ? 12 : t.hour);
    final m = t.minute.toString().padLeft(2, '0');
    final p = t.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $p';
  }

  @override
  Widget build(BuildContext context) {
    if (_times == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('FAZE - Prayer Times')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: _times!.getAllPrayers().entries.map((e) {
          final isNext = _times!.getNextPrayerType() == e.key;
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: isNext ? AppColors.primaryBlue : AppColors.cardBackground,
              borderRadius: BorderRadius.circular(16),
              border: isNext
                  ? null
                  : Border.all(color: AppColors.surfaceBackground),
            ),
            child: ListTile(
              leading: Text(e.key.emoji, style: const TextStyle(fontSize: 28)),
              title: Text(
                e.key.displayName,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: isNext ? FontWeight.bold : FontWeight.normal,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                e.key.arabicName,
                style: TextStyle(color: AppColors.textSecondary),
              ),
              trailing: Text(
                _fmt(e.value),
                style: TextStyle(
                  color: isNext ? Colors.white : AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}