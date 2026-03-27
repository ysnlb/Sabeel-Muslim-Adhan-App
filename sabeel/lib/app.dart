import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'l10n/app_localizations.dart';
import 'providers/app_providers.dart';
import 'screens/adhkar_screen.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'theme/app_theme.dart';

class PrayerApp extends ConsumerStatefulWidget {
  const PrayerApp({super.key});

  @override
  ConsumerState<PrayerApp> createState() => _PrayerAppState();
}

class _PrayerAppState extends ConsumerState<PrayerApp> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Trigger initial notification scheduling after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refreshNotificationsAndWidget(ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final locale = Locale(settings.locale);
    final loc = AppLocalizations(locale);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prayer Times',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      locale: locale,
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Scaffold(
        appBar: AppBar(
          title: Text(loc.tr('appTitle')),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            HomeScreen(),
            AdhkarScreen(),
            SettingsScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.mosque_outlined),
              activeIcon: const Icon(Icons.mosque),
              label: loc.tr('home'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.menu_book_outlined),
              activeIcon: const Icon(Icons.menu_book),
              label: loc.tr('adhkar'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings_outlined),
              activeIcon: const Icon(Icons.settings),
              label: loc.tr('settings'),
            ),
          ],
        ),
      ),
    );
  }
}