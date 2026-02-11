class AppConstants {
  // App Info
  static const String appName = 'FAZE';
  static const String appVersion = '1.0.0';

  // Default Location (Lahore)
  static const double defaultLatitude = 31.5497;
  static const double defaultLongitude = 74.3436;
  static const String defaultCity = 'Lahore';

  // Hydration
  static const int defaultWaterGoalMl = 2500;
  static const List<int> quickAddAmounts = [150, 250, 350, 500];

  // Notification IDs
  static const int fajrNotificationId = 1;
  static const int dhuhrNotificationId = 2;
  static const int asrNotificationId = 3;
  static const int maghribNotificationId = 4;
  static const int ishaNotificationId = 5;
  static const int fajrReminderNotificationId = 11;
  static const int dhuhrReminderNotificationId = 12;
  static const int asrReminderNotificationId = 13;
  static const int maghribReminderNotificationId = 14;
  static const int ishaReminderNotificationId = 15;
  static const int hydrationNotificationId = 20;
  static const int journalNotificationId = 30;

  // Shared Preferences Keys
  static const String keyOnboardingComplete = 'onboarding_complete';
  static const String keyLatitude = 'latitude';
  static const String keyLongitude = 'longitude';
  static const String keyCity = 'city';
  static const String keyCalculationMethod = 'calculation_method';
  static const String keyWaterGoal = 'water_goal';
  static const String keyNotificationsEnabled = 'notifications_enabled';
  static const String keyPrayerRemindersEnabled = 'prayer_reminders_enabled';
  static const String keyHydrationRemindersEnabled = 'hydration_reminders_enabled';
  static const String keyJournalReminderEnabled = 'journal_reminder_enabled';
}