import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;

import 'app.dart';
import 'providers/app_providers.dart';
import 'services/notification_service.dart';
import 'services/background_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ── Timezone initialisation (required for scheduled notifications) ──
  tz.initializeTimeZones();
  try {
    final tzName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(tzName));
  } catch (_) {
    // Fallback to UTC if device timezone is not found
  }

  // ── Notification plugin initialisation ──
  await NotificationService.init();

  // ── WorkManager background task registration ──
  await initBackgroundService();

  // ── SharedPreferences (injected as a Riverpod override) ──
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPrefsProvider.overrideWithValue(prefs),
      ],
      child: const PrayerApp(),
    ),
  );
}