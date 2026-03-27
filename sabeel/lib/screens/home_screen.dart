import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../models/models.dart';
import '../providers/app_providers.dart';
import '../services/notification_service.dart'; // هادي زدناها باش نعيطو للإشعارات

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Timer? _timer;
  Duration _countdown = Duration.zero;
  String _nextKey = '';

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());

    // هادا هو الكود السحري لي يخدم كي يقلع التطبيق ديريكت
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 1. نأنسطاليو الإشعارات ونطلبو الصلاحيات (Permissions)
      await NotificationService.init();
      
      // 2. إيلا كاين أوقات الصلاة (اللوكاليزاسيون كاينة)، نحدثو الـ Widget والإشعار الدائم أوتوماتيكيا
      final data = ref.read(prayerTimesProvider);
      if (data != null) {
        await refreshNotificationsAndWidget(ref);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _tick() {
    final data = ref.read(prayerTimesProvider);
    if (data == null) return;

    final next = data.nextPrayer();
    if (next != null) {
      final diff = next.value.difference(DateTime.now());
      setState(() {
        _nextKey = next.key;
        _countdown = diff.isNegative ? Duration.zero : diff;
      });
    } else {
      // All passed → countdown to tomorrow's Fajr
      final tmrFajr = ref.read(tomorrowFajrProvider);
      if (tmrFajr != null) {
        final diff = tmrFajr.difference(DateTime.now());
        setState(() {
          _nextKey = 'fajr';
          _countdown = diff.isNegative ? Duration.zero : diff;
        });
      }
    }
  }

  String _formatCountdown(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final settings = ref.watch(settingsProvider);
    final data = ref.watch(prayerTimesProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final fmt = DateFormat('HH:mm');

    // If no location set, prompt user
    if (data == null) {
      return _buildNoLocation(context, loc, ref);
    }

    final nextEntry = data.nextPrayer();
    final bool allPassed = nextEntry == null;

    return SingleChildScrollView(
      child: Column(
        children: [
          // ── Hero section: next prayer countdown ──
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [const Color(0xFF16213E), const Color(0xFF0F3460)]
                    : [const Color(0xFF1B5E20), const Color(0xFF2E7D32)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // City name
                  Text(
                    settings.cityName.isNotEmpty
                        ? settings.cityName
                        : loc.tr('noLocation'),
                    style: const TextStyle(
                        color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  // Date
                  Text(
                    DateFormat.yMMMMEEEEd(settings.locale)
                        .format(DateTime.now()),
                    style: const TextStyle(
                        color: Colors.white60, fontSize: 13),
                  ),
                  const SizedBox(height: 20),
                  // Next prayer label
                  Text(
                    allPassed
                        ? loc.tr('tomorrowFajr')
                        : '${loc.tr('nextPrayer')}: ${loc.tr(_nextKey.isNotEmpty ? _nextKey : (nextEntry?.key ?? ''))}',
                    style: const TextStyle(
                        color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 12),
                  // Countdown
                  Text(
                    _formatCountdown(_countdown),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    loc.tr('timeRemaining'),
                    style: const TextStyle(
                        color: Colors.white54, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ── Prayer time cards ──
          ...data.ordered.map((entry) {
            final isCurrent = !allPassed &&
                nextEntry != null &&
                entry.key == nextEntry.key;
            return _PrayerRow(
              label: loc.tr(entry.key),
              time: fmt.format(entry.value),
              isNext: isCurrent,
              icon: _iconFor(entry.key),
            );
          }),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildNoLocation(
      BuildContext context, AppLocalizations loc, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_off,
                size: 80, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            Text(loc.tr('noLocation'),
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(loc.tr('tapToSetLocation'),
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () async {
                try {
                  await ref.read(settingsProvider.notifier).fetchGPSLocation();
                  if (context.mounted) {
                    await refreshNotificationsAndWidget(ref);
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                }
              },
              icon: const Icon(Icons.my_location),
              label: Text(loc.tr('getLocation')),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconFor(String key) {
    switch (key) {
      case 'fajr':
        return Icons.nights_stay_outlined;
      case 'sunrise':
        return Icons.wb_sunny_outlined;
      case 'dhuhr':
        return Icons.wb_sunny;
      case 'asr':
        return Icons.wb_twilight;
      case 'maghrib':
        return Icons.nightlight_round;
      case 'isha':
        return Icons.dark_mode_outlined;
      default:
        return Icons.access_time;
    }
  }
}

// ── Individual prayer row widget ─────────────────────────────
class _PrayerRow extends StatelessWidget {
  final String label;
  final String time;
  final bool isNext;
  final IconData icon;

  const _PrayerRow({
    required this.label,
    required this.time,
    required this.isNext,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = isNext
        ? theme.colorScheme.primary.withOpacity(0.12)
        : theme.cardTheme.color ?? theme.cardColor;
    final borderColor =
        isNext ? theme.colorScheme.primary : Colors.transparent;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor, width: isNext ? 2 : 0),
      ),
      child: ListTile(
        leading: Icon(icon,
            color: isNext
                ? theme.colorScheme.primary
                : theme.iconTheme.color),
        title: Text(
          label,
          style: TextStyle(
            fontWeight: isNext ? FontWeight.bold : FontWeight.w500,
            fontSize: 16,
          ),
        ),
        trailing: Text(
          time,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: isNext ? theme.colorScheme.primary : null,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ),
    );
  }
}