import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context);
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        // ══════════════ Language ══════════════
        _SectionTitle(title: loc.tr('language')),
        Card(
          child: Column(
            children: [
              _buildRadio<String>(
                context: context,
                value: 'en',
                groupValue: settings.locale,
                label: loc.tr('english'),
                onChanged: (v) => notifier.setLocale(v!),
              ),
              _buildRadio<String>(
                context: context,
                value: 'fr',
                groupValue: settings.locale,
                label: loc.tr('french'),
                onChanged: (v) => notifier.setLocale(v!),
              ),
              _buildRadio<String>(
                context: context,
                value: 'ar',
                groupValue: settings.locale,
                label: loc.tr('arabic'),
                onChanged: (v) => notifier.setLocale(v!),
              ),
            ],
          ),
        ),

        // ══════════════ Theme ══════════════
        _SectionTitle(title: loc.tr('theme')),
        Card(
          child: SwitchListTile(
            title: Text(settings.isDarkMode
                ? loc.tr('darkMode')
                : loc.tr('lightMode')),
            secondary: Icon(
                settings.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            value: settings.isDarkMode,
            onChanged: (v) {
              notifier.setDarkMode(v);
            },
          ),
        ),

        // ══════════════ Location ══════════════
        _SectionTitle(title: loc.tr('location')),
        Card(
          child: Column(
            children: [
              SwitchListTile(
                title: Text(loc.tr('useGPS')),
                secondary: const Icon(Icons.gps_fixed),
                value: settings.useGPS,
                onChanged: (v) => notifier.setUseGPS(v),
              ),
              if (settings.useGPS)
                ListTile(
                  leading: const Icon(Icons.my_location),
                  title: Text(settings.cityName.isNotEmpty
                      ? settings.cityName
                      : loc.tr('noLocation')),
                  subtitle: settings.latitude != 0
                      ? Text(
                          '${settings.latitude.toStringAsFixed(4)}, ${settings.longitude.toStringAsFixed(4)}')
                      : null,
                  trailing: const Icon(Icons.refresh),
                  onTap: () async {
                    try {
                      await notifier.fetchGPSLocation();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(loc.tr('locationUpdated'))),
                        );
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
                ),
              if (!settings.useGPS)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: _ManualLocationForm(
                    initialLat: settings.latitude,
                    initialLon: settings.longitude,
                    initialCity: settings.cityName,
                    onSave: (lat, lon, city) {
                      notifier.setLocation(lat, lon, city);
                      refreshNotificationsAndWidget(ref);
                    },
                    loc: loc,
                  ),
                ),
            ],
          ),
        ),

        // ══════════════ Calculation Method ══════════════
        _SectionTitle(title: loc.tr('calculationMethod')),
        Card(
          child: Column(
            children: _kMethods.map((m) {
              return _buildRadio<String>(
                context: context,
                value: m,
                groupValue: settings.calculationMethod,
                label: loc.tr(_methodLocKey(m)),
                onChanged: (v) {
                  notifier.setCalculationMethod(v!);
                  refreshNotificationsAndWidget(ref);
                },
              );
            }).toList(),
          ),
        ),

        // ══════════════ Madhab ══════════════
        _SectionTitle(title: loc.tr('madhab')),
        Card(
          child: Column(
            children: [
              _buildRadio<String>(
                context: context,
                value: 'Shafi',
                groupValue: settings.madhab,
                label: loc.tr('shafi'),
                onChanged: (v) {
                  notifier.setMadhab(v!);
                  refreshNotificationsAndWidget(ref);
                },
              ),
              _buildRadio<String>(
                context: context,
                value: 'Hanafi',
                groupValue: settings.madhab,
                label: loc.tr('hanafi'),
                onChanged: (v) {
                  notifier.setMadhab(v!);
                  refreshNotificationsAndWidget(ref);
                },
              ),
            ],
          ),
        ),

        // ══════════════ Adjustments ══════════════
        _SectionTitle(title: loc.tr('adjustments')),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                _AdjustmentRow(
                    label: loc.tr('fajr'),
                    value: settings.adjFajr,
                    onChanged: (v) {
                      notifier.setAdjustment('fajr', v);
                      refreshNotificationsAndWidget(ref);
                    }),
                _AdjustmentRow(
                    label: loc.tr('sunrise'),
                    value: settings.adjSunrise,
                    onChanged: (v) {
                      notifier.setAdjustment('sunrise', v);
                      refreshNotificationsAndWidget(ref);
                    }),
                _AdjustmentRow(
                    label: loc.tr('dhuhr'),
                    value: settings.adjDhuhr,
                    onChanged: (v) {
                      notifier.setAdjustment('dhuhr', v);
                      refreshNotificationsAndWidget(ref);
                    }),
                _AdjustmentRow(
                    label: loc.tr('asr'),
                    value: settings.adjAsr,
                    onChanged: (v) {
                      notifier.setAdjustment('asr', v);
                      refreshNotificationsAndWidget(ref);
                    }),
                _AdjustmentRow(
                    label: loc.tr('maghrib'),
                    value: settings.adjMaghrib,
                    onChanged: (v) {
                      notifier.setAdjustment('maghrib', v);
                      refreshNotificationsAndWidget(ref);
                    }),
                _AdjustmentRow(
                    label: loc.tr('isha'),
                    value: settings.adjIsha,
                    onChanged: (v) {
                      notifier.setAdjustment('isha', v);
                      refreshNotificationsAndWidget(ref);
                    }),
              ],
            ),
          ),
        ),

        const SizedBox(height: 32),

        // ══════════════ Dua Note ══════════════
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Text(
              'لا تنسونا من صالح دعائكم',
              style: TextStyle(
                fontSize: 16,
                color: theme.hintColor,
                fontWeight: FontWeight.w500,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
      ],
    );
  }

  // ── Helpers ──

  static const _kMethods = [
    'MuslimWorldLeague',
    'Egyptian',
    'Karachi',
    'UmmAlQura',
    'Dubai',
    'NorthAmerica',
    'Kuwait',
    'Qatar',
    'Singapore',
    'Turkey',
    'Tehran',
  ];

  String _methodLocKey(String m) {
    switch (m) {
      case 'MuslimWorldLeague':
        return 'muslimWorldLeague';
      case 'Egyptian':
        return 'egyptian';
      case 'Karachi':
        return 'karachi';
      case 'UmmAlQura':
        return 'ummAlQura';
      case 'Dubai':
        return 'dubai';
      case 'NorthAmerica':
        return 'northAmerica';
      case 'Kuwait':
        return 'kuwait';
      case 'Qatar':
        return 'qatar';
      case 'Singapore':
        return 'singapore';
      case 'Turkey':
        return 'turkey';
      case 'Tehran':
        return 'tehran';
      default:
        return m;
    }
  }

  Widget _buildRadio<T>({
    required BuildContext context,
    required T value,
    required T groupValue,
    required String label,
    required ValueChanged<T?> onChanged,
  }) {
    return RadioListTile<T>(
      title: Text(label, style: const TextStyle(fontSize: 14)),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      dense: true,
      activeColor: Theme.of(context).colorScheme.primary,
    );
  }
}

// ── Section title ────────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

// ── Adjustment row (–/+ stepper) ─────────────────────────────
class _AdjustmentRow extends StatelessWidget {
  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  const _AdjustmentRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline, size: 22),
            onPressed: () => onChanged(value - 1),
          ),
          SizedBox(
            width: 36,
            child: Text(
              '${value > 0 ? '+' : ''}$value',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline, size: 22),
            onPressed: () => onChanged(value + 1),
          ),
        ],
      ),
    );
  }
}

// ── Manual location form ─────────────────────────────────────
class _ManualLocationForm extends StatefulWidget {
  final double initialLat;
  final double initialLon;
  final String initialCity;
  final void Function(double lat, double lon, String city) onSave;
  final AppLocalizations loc;

  const _ManualLocationForm({
    required this.initialLat,
    required this.initialLon,
    required this.initialCity,
    required this.onSave,
    required this.loc,
  });

  @override
  State<_ManualLocationForm> createState() => _ManualLocationFormState();
}

class _ManualLocationFormState extends State<_ManualLocationForm> {
  late TextEditingController _latCtrl;
  late TextEditingController _lonCtrl;
  late TextEditingController _cityCtrl;

  @override
  void initState() {
    super.initState();
    _latCtrl =
        TextEditingController(text: widget.initialLat.toStringAsFixed(4));
    _lonCtrl =
        TextEditingController(text: widget.initialLon.toStringAsFixed(4));
    _cityCtrl = TextEditingController(text: widget.initialCity);
  }

  @override
  void dispose() {
    _latCtrl.dispose();
    _lonCtrl.dispose();
    _cityCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = widget.loc;
    return Column(
      children: [
        TextField(
          controller: _latCtrl,
          decoration: InputDecoration(labelText: loc.tr('latitude')),
          keyboardType: const TextInputType.numberWithOptions(
              signed: true, decimal: true),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _lonCtrl,
          decoration: InputDecoration(labelText: loc.tr('longitude')),
          keyboardType: const TextInputType.numberWithOptions(
              signed: true, decimal: true),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _cityCtrl,
          decoration: InputDecoration(labelText: loc.tr('cityName')),
        ),
        const SizedBox(height: 12),
        FilledButton(
          onPressed: () {
            final lat = double.tryParse(_latCtrl.text) ?? 0.0;
            final lon = double.tryParse(_lonCtrl.text) ?? 0.0;
            widget.onSave(lat, lon, _cityCtrl.text.trim());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(loc.tr('locationUpdated'))),
            );
          },
          child: Text(loc.tr('save')),
        ),
      ],
    );
  }
}