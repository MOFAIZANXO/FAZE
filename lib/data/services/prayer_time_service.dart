import 'dart:math';
import '../models/prayer_log.dart';

class PrayerTimeService {
  static PrayerTimes calculatePrayerTimes({
    required double latitude,
    required double longitude,
    required DateTime date,
    CalculationMethod method = CalculationMethod.karachi,
  }) {
    return _PrayerCalc(latitude, longitude, date, method).calculate();
  }
}

class _PrayerCalc {
  final double lat;
  final double lng;
  final DateTime date;
  final CalculationMethod method;

  _PrayerCalc(this.lat, this.lng, this.date, this.method);

  PrayerTimes calculate() {
    final tz = date.timeZoneOffset.inHours +
        (date.timeZoneOffset.inMinutes % 60) / 60.0;
    final jd = _jd();
    final eqt = _eqTime(jd);
    final dec = _declination(jd);
    final noon = 12.0 + tz - lng / 15.0 - eqt / 60.0;
    
    final fajr = noon - _hourAngle(dec, -(90 + method.fajrAngle)) / 15.0;
    final sunrise = noon - _hourAngle(dec, -0.833) / 15.0;
    final dhuhr = noon;
    final asrAlt = -_toDeg(atan(1.0 / (1.0 + tan(_toRad((lat - dec).abs())))));
    final asr = noon + _hourAngle(dec, asrAlt) / 15.0;
    final maghrib = noon + _hourAngle(dec, -0.833) / 15.0;
    final isha = method == CalculationMethod.makkah
        ? maghrib + 1.5
        : noon + _hourAngle(dec, -(90 + method.ishaAngle)) / 15.0;

    return PrayerTimes(
      fajr: _dt(fajr),
      sunrise: _dt(sunrise),
      dhuhr: _dt(dhuhr),
      asr: _dt(asr),
      maghrib: _dt(maghrib),
      isha: _dt(isha),
      date: date,
    );
  }

  double _jd() {
    final y = date.year;
    final m = date.month;
    final d = date.day;
    if (m <= 2) {
      return (365.25 * (y - 1)).floor() +
          (30.6001 * (m + 13)).floor() +
          d + 1720994.5;
    }
    return (365.25 * y).floor() +
        (30.6001 * (m + 1)).floor() +
        d + 1720994.5;
  }

  double _eqTime(double jd) {
    final t = (jd - 2451545.0) / 36525.0;
    final l0 = 280.46646 + 36000.76983 * t;
    final m = 357.52911 + 35999.05029 * t;
    final c = (1.914602 - 0.004817 * t) * sin(_toRad(m)) +
        (0.019993 - 0.000101 * t) * sin(_toRad(2 * m)) +
        0.000289 * sin(_toRad(3 * m));
    final eps = 23.439 - 0.0000004 * t;
    final y = tan(_toRad(eps / 2)) * tan(_toRad(eps / 2));
    final e = 0.016708634 - 0.000042037 * t;
    final eq = y * sin(_toRad(2 * l0)) -
        2 * e * sin(_toRad(m)) +
        4 * e * y * sin(_toRad(m)) * cos(_toRad(2 * l0)) -
        0.5 * y * y * sin(_toRad(4 * l0)) -
        1.25 * e * e * sin(_toRad(2 * m));
    return _toDeg(eq) * 4;
  }

  double _declination(double jd) {
    final t = (jd - 2451545.0) / 36525.0;
    final l0 = 280.46646 + 36000.76983 * t;
    final m = 357.52911 + 35999.05029 * t;
    final c = (1.914602 - 0.004817 * t) * sin(_toRad(m)) +
        (0.019993 - 0.000101 * t) * sin(_toRad(2 * m)) +
        0.000289 * sin(_toRad(3 * m));
    final lambda = l0 + c;
    final eps = 23.439 - 0.0000004 * t;
    return _toDeg(asin(sin(_toRad(eps)) * sin(_toRad(lambda))));
  }

  double _hourAngle(double dec, double angle) {
    final cosH = (sin(_toRad(angle)) - sin(_toRad(lat)) * sin(_toRad(dec))) /
        (cos(_toRad(lat)) * cos(_toRad(dec)));
    if (cosH > 1.0) return 0.0;
    if (cosH < -1.0) return 180.0;
    return _toDeg(acos(cosH));
  }

  DateTime _dt(double t) {
    while (t < 0) t += 24;
    while (t >= 24) t -= 24;
    final h = t.floor().clamp(0, 23);
    final m = ((t - h) * 60).round().clamp(0, 59);
    return DateTime(date.year, date.month, date.day, h, m);
  }

  double _toRad(double d) => d * pi / 180.0;
  double _toDeg(double r) => r * 180.0 / pi;
}

class PrayerTimes {
  final DateTime fajr;
  final DateTime sunrise;
  final DateTime dhuhr;
  final DateTime asr;
  final DateTime maghrib;
  final DateTime isha;
  final DateTime date;

  PrayerTimes({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.date,
  });

  DateTime? getNextPrayer() {
    final now = DateTime.now();
    for (final p in [fajr, dhuhr, asr, maghrib, isha]) {
      if (p.isAfter(now)) return p;
    }
    return null;
  }

  PrayerType? getNextPrayerType() {
    final next = getNextPrayer();
    if (next == null) return null;
    if (next == fajr) return PrayerType.fajr;
    if (next == dhuhr) return PrayerType.dhuhr;
    if (next == asr) return PrayerType.asr;
    if (next == maghrib) return PrayerType.maghrib;
    if (next == isha) return PrayerType.isha;
    return null;
  }

  Map<PrayerType, DateTime> getAllPrayers() => {
    PrayerType.fajr: fajr,
    PrayerType.dhuhr: dhuhr,
    PrayerType.asr: asr,
    PrayerType.maghrib: maghrib,
    PrayerType.isha: isha,
  };
}

enum CalculationMethod { karachi, isna, mwl, makkah, egypt }

extension CalculationMethodExtension on CalculationMethod {
  double get fajrAngle {
    switch (this) {
      case CalculationMethod.karachi: return 18.0;
      case CalculationMethod.isna: return 15.0;
      case CalculationMethod.mwl: return 18.0;
      case CalculationMethod.makkah: return 18.5;
      case CalculationMethod.egypt: return 19.5;
    }
  }

  double get ishaAngle {
    switch (this) {
      case CalculationMethod.karachi: return 18.0;
      case CalculationMethod.isna: return 15.0;
      case CalculationMethod.mwl: return 17.0;
      case CalculationMethod.makkah: return 90.0;
      case CalculationMethod.egypt: return 17.5;
    }
  }
}