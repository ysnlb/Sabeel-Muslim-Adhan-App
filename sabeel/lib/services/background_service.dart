import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'package:home_widget/home_widget.dart';
import 'prayer_calculation_service.dart';
import 'notification_service.dart';

/// Unique task name registered with WorkManager.
const String kBackgroundTaskName = 'prayer_update_task';
const String kBackgroundTaskTag = 'prayer_bg';

/// Top-level callback – must be a static / top-level function.
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Read persisted settings
      final lat = prefs.getDouble('latitude') ?? 0.0;
      final lon = prefs.getDouble('longitude') ?? 0.0;
      final method = prefs.getString('calculationMethod') ?? 'MuslimWorldLeague';
      final madhab = prefs.getString('madhab') ?? 'Shafi';
      final adjFajr = prefs.getInt('adj_fajr') ?? 0;
      final adjSunrise = prefs.getInt('adj_sunrise') ?? 0;
      final adjDhuhr = prefs.getInt('adj_dhuhr') ?? 0;
      final adjAsr = prefs.getInt('adj_asr') ?? 0;
      final adjMaghrib = prefs.getInt('adj_maghrib') ?? 0;
      final adjIsha = prefs.getInt('adj_isha') ?? 0;

      final data = PrayerCalculationService.calculate(
        latitude: lat,
        longitude: lon,
        method: method,
        madhab: madhab,
        adjFajr: adjFajr,
        adjSunrise: adjSunrise,
        adjDhuhr: adjDhuhr,
        adjAsr: adjAsr,
        adjMaghrib: adjMaghrib,
        adjIsha: adjIsha,
      );

      if (data != null) {
        final fmt = DateFormat('HH:mm');

        // ── Update persistent notification ──
        final next = data.nextPrayer();
        String nextName = 'Fajr';
        String nextTime = fmt.format(data.fajr);
        if (next != null) {
          nextName = next.key;
          nextTime = fmt.format(next.value);
        } else {
          // All passed → tomorrow's Fajr
          final tmrFajr = PrayerCalculationService.tomorrowFajr(
            latitude: lat,
            longitude: lon,
            method: method,
            madhab: madhab,
            adjFajr: adjFajr,
          );
          if (tmrFajr != null) {
            nextName = 'Fajr';
            nextTime = fmt.format(tmrFajr);
          }
        }

        await NotificationService.init();
        await NotificationService.showPersistentNotification(
          nextPrayerName: nextName,
          nextPrayerTime: nextTime,
        );

        // ── Schedule adhan notifications ──
        await NotificationService.scheduleAdhanNotifications(data, {
          'fajr': 'Fajr',
          'dhuhr': 'Dhuhr',
          'asr': 'Asr',
          'maghrib': 'Maghrib',
          'isha': 'Isha',
        });

        // ── Update home screen widget ──
        await _updateHomeWidget(data, fmt);
      }
    } catch (e) {
      // Silently fail – background tasks should not crash
    }
    return Future.value(true);
  });
}

/// Register the periodic background task.
Future<void> initBackgroundService() async {
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  await Workmanager().registerPeriodicTask(
    kBackgroundTaskName,
    kBackgroundTaskName,
    tag: kBackgroundTaskTag,
    frequency: const Duration(minutes: 15),
    constraints: Constraints(
      networkType: NetworkType.notRequired,
      requiresBatteryNotLow: false,
      requiresCharging: false,
      requiresDeviceIdle: false,
      requiresStorageNotLow: false,
    ),
    existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
  );
}

/// Push prayer-time data into HomeWidget shared storage.
Future<void> _updateHomeWidget(dynamic data, DateFormat fmt) async {
  try {
    await HomeWidget.saveWidgetData<String>('fajr', fmt.format(data.fajr));
    await HomeWidget.saveWidgetData<String>('sunrise', fmt.format(data.sunrise));
    await HomeWidget.saveWidgetData<String>('dhuhr', fmt.format(data.dhuhr));
    await HomeWidget.saveWidgetData<String>('asr', fmt.format(data.asr));
    await HomeWidget.saveWidgetData<String>('maghrib', fmt.format(data.maghrib));
    await HomeWidget.saveWidgetData<String>('isha', fmt.format(data.isha));
    await HomeWidget.updateWidget(
      androidName: 'PrayerWidgetReceiver',
      iOSName: 'PrayerWidget',
    );
  } catch (_) {}
}