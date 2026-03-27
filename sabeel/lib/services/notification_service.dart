import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import '../models/models.dart';

/// Manages all local notifications: adhan alerts + persistent "next prayer".
class NotificationService {
  NotificationService._();

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // Notification channel IDs
  static const String _adhanChannelId = 'adhan_channel';
  static const String _persistentChannelId = 'persistent_channel';

  // Notification IDs
  static const int _persistentNotifId = 9999;
  // Prayer IDs: Fajr=1, Sunrise=2, Dhuhr=3, Asr=4, Maghrib=5, Isha=6
  static const Map<String, int> _prayerNotifIds = {
    'fajr': 1,
    'sunrise': 2,
    'dhuhr': 3,
    'asr': 4,
    'maghrib': 5,
    'isha': 6,
  };

  /// Initialise the plugin with platform-specific settings.
  static Future<void> init() async {
    const androidInit = AndroidInitializationSettings('notification');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );
    await _plugin.initialize(initSettings);

    // Request permissions on Android 13+
    if (Platform.isAndroid) {
      final androidPlugin =
          _plugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      await androidPlugin?.requestNotificationsPermission();
      await androidPlugin?.requestExactAlarmsPermission();
    }
  }

  // ── Adhan Notifications ───────────────────────────────────

  /// Schedule adhan notifications for every prayer in [data].
  /// Skips `sunrise` since it is not a prayer.
  static Future<void> scheduleAdhanNotifications(
      PrayerTimesData data, Map<String, String> prayerNames) async {
    // Cancel old scheduled adhan notifications first
    for (final id in _prayerNotifIds.values) {
      await _plugin.cancel(id);
    }

    final now = DateTime.now();
    final prayersToNotify = ['fajr', 'dhuhr', 'asr', 'maghrib', 'isha'];

    for (final key in prayersToNotify) {
      final time = data.timeFor(key);
      if (time == null || time.isBefore(now)) continue;

      final scheduledTZ = tz.TZDateTime.from(time, tz.local);

      await _plugin.zonedSchedule(
        _prayerNotifIds[key]!,
        '🕌 ${prayerNames[key] ?? key}',
        '${prayerNames[key] ?? key} - حان وقت الصلاة',
        scheduledTZ,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _adhanChannelId,
            'Adhan Notifications',
            channelDescription: 'Plays adhan at prayer times',
            importance: Importance.max,
            priority: Priority.high,
            icon: 'notification',
            sound: const RawResourceAndroidNotificationSound('adhan'),
            playSound: true,
            enableVibration: true,
            fullScreenIntent: true,
          ),
          iOS: const DarwinNotificationDetails(
            sound: 'adhan.mp3',
            presentAlert: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: null, // One-shot for today
      );
    }
  }

  // ── Persistent Notification ───────────────────────────────

  /// Show or update the silent persistent notification displaying the next
  /// prayer name and time.
  static Future<void> showPersistentNotification({
    required String nextPrayerName,
    required String nextPrayerTime,
  }) async {
    await _plugin.show(
      _persistentNotifId,
      '🕌 $nextPrayerName',
      nextPrayerTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _persistentChannelId,
          'Next Prayer',
          channelDescription: 'Shows the next prayer time',
          importance: Importance.low,
          priority: Priority.low,
          icon: 'notification',
          ongoing: true,
          autoCancel: false,
          playSound: false,
          enableVibration: false,
          showWhen: false,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: false,
          presentSound: false,
        ),
      ),
    );
  }

  /// Remove the persistent notification.
  static Future<void> cancelPersistentNotification() async {
    await _plugin.cancel(_persistentNotifId);
  }

  /// Cancel everything.
  static Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}