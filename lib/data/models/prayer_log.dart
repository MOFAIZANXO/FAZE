import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../../core/theme/app_theme.dart';

part 'prayer_log.g.dart';

@collection
class PrayerLog {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime date;

  @Enumerated(EnumType.name)
  late PrayerType prayerType;

  late DateTime scheduledTime;
  DateTime? completedAt;

  bool get completed => completedAt != null;

  bool get onTime {
    if (completedAt == null) return false;
    return completedAt!.difference(scheduledTime).inMinutes.abs() <= 15;
  }
}

enum PrayerType { fajr, dhuhr, asr, maghrib, isha }

extension PrayerTypeExtension on PrayerType {
  String get displayName {
    switch (this) {
      case PrayerType.fajr: return 'Fajr';
      case PrayerType.dhuhr: return 'Dhuhr';
      case PrayerType.asr: return 'Asr';
      case PrayerType.maghrib: return 'Maghrib';
      case PrayerType.isha: return 'Isha';
    }
  }

  String get arabicName {
    switch (this) {
      case PrayerType.fajr: return 'الفجر';
      case PrayerType.dhuhr: return 'الظهر';
      case PrayerType.asr: return 'العصر';
      case PrayerType.maghrib: return 'المغرب';
      case PrayerType.isha: return 'العشاء';
    }
  }

  String get emoji {
    switch (this) {
      case PrayerType.fajr: return '🌅';
      case PrayerType.dhuhr: return '☀️';
      case PrayerType.asr: return '🌤️';
      case PrayerType.maghrib: return '🌆';
      case PrayerType.isha: return '🌙';
    }
  }

  IconData get iconData {
    switch (this) {
      case PrayerType.fajr: return Icons.wb_twilight;
      case PrayerType.dhuhr: return Icons.wb_sunny;
      case PrayerType.asr: return Icons.wb_cloudy;
      case PrayerType.maghrib: return Icons.wb_twighlight;
      case PrayerType.isha: return Icons.nightlight_round;
    }
  }

  Color get color {
    switch (this) {
      case PrayerType.fajr: return AppColors.fajrColor;
      case PrayerType.dhuhr: return AppColors.dhuhrColor;
      case PrayerType.asr: return AppColors.asrColor;
      case PrayerType.maghrib: return AppColors.maghribColor;
      case PrayerType.isha: return AppColors.ishaColor;
    }
  }
}