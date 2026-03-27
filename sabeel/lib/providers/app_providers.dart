import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:home_widget/home_widget.dart';

import '../models/models.dart';
import '../services/prayer_calculation_service.dart';
import '../services/location_service.dart';
import '../services/notification_service.dart';

// ═══════════════════════════════════════════════════════════
//  SharedPreferences provider (overridden in main)
// ═══════════════════════════════════════════════════════════
final sharedPrefsProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Override in ProviderScope');
});

// ═══════════════════════════════════════════════════════════
//  Settings StateNotifier
// ═══════════════════════════════════════════════════════════
class SettingsNotifier extends StateNotifier<AppSettings> {
  final SharedPreferences _prefs;

  SettingsNotifier(this._prefs) : super(const AppSettings()) {
    _load();
  }

  void _load() {
    state = AppSettings(
      locale: _prefs.getString('locale') ?? 'en',
      isDarkMode: _prefs.getBool('isDarkMode') ?? false,
      latitude: _prefs.getDouble('latitude') ?? 0.0,
      longitude: _prefs.getDouble('longitude') ?? 0.0,
      cityName: _prefs.getString('cityName') ?? '',
      useGPS: _prefs.getBool('useGPS') ?? true,
      calculationMethod:
          _prefs.getString('calculationMethod') ?? 'MuslimWorldLeague',
      madhab: _prefs.getString('madhab') ?? 'Shafi',
      adjFajr: _prefs.getInt('adj_fajr') ?? 0,
      adjSunrise: _prefs.getInt('adj_sunrise') ?? 0,
      adjDhuhr: _prefs.getInt('adj_dhuhr') ?? 0,
      adjAsr: _prefs.getInt('adj_asr') ?? 0,
      adjMaghrib: _prefs.getInt('adj_maghrib') ?? 0,
      adjIsha: _prefs.getInt('adj_isha') ?? 0,
    );
  }

  Future<void> _persist() async {
    await _prefs.setString('locale', state.locale);
    await _prefs.setBool('isDarkMode', state.isDarkMode);
    await _prefs.setDouble('latitude', state.latitude);
    await _prefs.setDouble('longitude', state.longitude);
    await _prefs.setString('cityName', state.cityName);
    await _prefs.setBool('useGPS', state.useGPS);
    await _prefs.setString('calculationMethod', state.calculationMethod);
    await _prefs.setString('madhab', state.madhab);
    await _prefs.setInt('adj_fajr', state.adjFajr);
    await _prefs.setInt('adj_sunrise', state.adjSunrise);
    await _prefs.setInt('adj_dhuhr', state.adjDhuhr);
    await _prefs.setInt('adj_asr', state.adjAsr);
    await _prefs.setInt('adj_maghrib', state.adjMaghrib);
    await _prefs.setInt('adj_isha', state.adjIsha);
  }

  void setLocale(String locale) {
    state = state.copyWith(locale: locale);
    _persist();
  }

  void toggleTheme() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
    _persist();
  }

  void setDarkMode(bool v) {
    state = state.copyWith(isDarkMode: v);
    _persist();
  }

  void setLocation(double lat, double lon, String city) {
    state = state.copyWith(latitude: lat, longitude: lon, cityName: city);
    _persist();
  }

  void setUseGPS(bool v) {
    state = state.copyWith(useGPS: v);
    _persist();
  }

  void setCalculationMethod(String m) {
    state = state.copyWith(calculationMethod: m);
    _persist();
  }

  void setMadhab(String m) {
    state = state.copyWith(madhab: m);
    _persist();
  }

  void setAdjustment(String prayer, int minutes) {
    switch (prayer) {
      case 'fajr':
        state = state.copyWith(adjFajr: minutes);
        break;
      case 'sunrise':
        state = state.copyWith(adjSunrise: minutes);
        break;
      case 'dhuhr':
        state = state.copyWith(adjDhuhr: minutes);
        break;
      case 'asr':
        state = state.copyWith(adjAsr: minutes);
        break;
      case 'maghrib':
        state = state.copyWith(adjMaghrib: minutes);
        break;
      case 'isha':
        state = state.copyWith(adjIsha: minutes);
        break;
    }
    _persist();
  }

  /// Fetch GPS location and update.
  Future<void> fetchGPSLocation() async {
    try {
      final pos = await LocationService.getCurrentPosition();
      final city =
          await LocationService.getCityName(pos.latitude, pos.longitude);
      setLocation(pos.latitude, pos.longitude, city);
    } catch (e) {
      rethrow;
    }
  }
}

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, AppSettings>((ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  return SettingsNotifier(prefs);
});

// ═══════════════════════════════════════════════════════════
//  Computed Prayer Times (reacts to settings changes)
// ═══════════════════════════════════════════════════════════
final prayerTimesProvider = Provider<PrayerTimesData?>((ref) {
  final s = ref.watch(settingsProvider);
  return PrayerCalculationService.calculate(
    latitude: s.latitude,
    longitude: s.longitude,
    method: s.calculationMethod,
    madhab: s.madhab,
    adjFajr: s.adjFajr,
    adjSunrise: s.adjSunrise,
    adjDhuhr: s.adjDhuhr,
    adjAsr: s.adjAsr,
    adjMaghrib: s.adjMaghrib,
    adjIsha: s.adjIsha,
  );
});

/// Tomorrow's Fajr – used when all of today's prayers have passed.
final tomorrowFajrProvider = Provider<DateTime?>((ref) {
  final s = ref.watch(settingsProvider);
  return PrayerCalculationService.tomorrowFajr(
    latitude: s.latitude,
    longitude: s.longitude,
    method: s.calculationMethod,
    madhab: s.madhab,
    adjFajr: s.adjFajr,
  );
});

// ═══════════════════════════════════════════════════════════
//  Helper: schedule notifications & update widget whenever
//  prayer times change.
// ═══════════════════════════════════════════════════════════
Future<void> refreshNotificationsAndWidget(WidgetRef ref) async {
  final data = ref.read(prayerTimesProvider);
  final settings = ref.read(settingsProvider);
  if (data == null) return;

  final fmt = DateFormat('HH:mm');

  // Schedule adhan notifications
  final nameMap = <String, String>{
    'fajr': 'Fajr',
    'dhuhr': 'Dhuhr',
    'asr': 'Asr',
    'maghrib': 'Maghrib',
    'isha': 'Isha',
  };
  await NotificationService.scheduleAdhanNotifications(data, nameMap);

  // Update persistent notification
  final next = data.nextPrayer();
  if (next != null) {
    await NotificationService.showPersistentNotification(
      nextPrayerName: next.key,
      nextPrayerTime: fmt.format(next.value),
    );
  } else {
    final tmrFajr = ref.read(tomorrowFajrProvider);
    await NotificationService.showPersistentNotification(
      nextPrayerName: 'Fajr',
      nextPrayerTime: tmrFajr != null ? fmt.format(tmrFajr) : '--:--',
    );
  }

  // Update home widget
  try {
    await HomeWidget.saveWidgetData<String>('fajr', fmt.format(data.fajr));
    await HomeWidget.saveWidgetData<String>(
        'sunrise', fmt.format(data.sunrise));
    await HomeWidget.saveWidgetData<String>('dhuhr', fmt.format(data.dhuhr));
    await HomeWidget.saveWidgetData<String>('asr', fmt.format(data.asr));
    await HomeWidget.saveWidgetData<String>(
        'maghrib', fmt.format(data.maghrib));
    await HomeWidget.saveWidgetData<String>('isha', fmt.format(data.isha));
    await HomeWidget.saveWidgetData<String>(
        'city', settings.cityName);
    await HomeWidget.updateWidget(
      androidName: 'PrayerWidgetReceiver',
      iOSName: 'PrayerWidget',
    );
  } catch (_) {}
}