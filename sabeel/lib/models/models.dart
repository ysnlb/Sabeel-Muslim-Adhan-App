/// All data models for the application.

class AppSettings {
  final String locale;
  final bool isDarkMode;
  final double latitude;
  final double longitude;
  final String cityName;
  final bool useGPS;
  final String calculationMethod;
  final String madhab;
  final int adjFajr;
  final int adjSunrise;
  final int adjDhuhr;
  final int adjAsr;
  final int adjMaghrib;
  final int adjIsha;

  const AppSettings({
    this.locale = 'en',
    this.isDarkMode = false,
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.cityName = '',
    this.useGPS = true,
    this.calculationMethod = 'MuslimWorldLeague',
    this.madhab = 'Shafi',
    this.adjFajr = 0,
    this.adjSunrise = 0,
    this.adjDhuhr = 0,
    this.adjAsr = 0,
    this.adjMaghrib = 0,
    this.adjIsha = 0,
  });

  AppSettings copyWith({
    String? locale,
    bool? isDarkMode,
    double? latitude,
    double? longitude,
    String? cityName,
    bool? useGPS,
    String? calculationMethod,
    String? madhab,
    int? adjFajr,
    int? adjSunrise,
    int? adjDhuhr,
    int? adjAsr,
    int? adjMaghrib,
    int? adjIsha,
  }) {
    return AppSettings(
      locale: locale ?? this.locale,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      cityName: cityName ?? this.cityName,
      useGPS: useGPS ?? this.useGPS,
      calculationMethod: calculationMethod ?? this.calculationMethod,
      madhab: madhab ?? this.madhab,
      adjFajr: adjFajr ?? this.adjFajr,
      adjSunrise: adjSunrise ?? this.adjSunrise,
      adjDhuhr: adjDhuhr ?? this.adjDhuhr,
      adjAsr: adjAsr ?? this.adjAsr,
      adjMaghrib: adjMaghrib ?? this.adjMaghrib,
      adjIsha: adjIsha ?? this.adjIsha,
    );
  }
}

/// Holds the calculated prayer times for a single day.
class PrayerTimesData {
  final DateTime fajr;
  final DateTime sunrise;
  final DateTime dhuhr;
  final DateTime asr;
  final DateTime maghrib;
  final DateTime isha;

  const PrayerTimesData({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  /// Returns a list of (prayerKey, dateTime) pairs in chronological order.
  List<MapEntry<String, DateTime>> get ordered => [
        MapEntry('fajr', fajr),
        MapEntry('sunrise', sunrise),
        MapEntry('dhuhr', dhuhr),
        MapEntry('asr', asr),
        MapEntry('maghrib', maghrib),
        MapEntry('isha', isha),
      ];

  /// Returns the key and time of the next upcoming prayer, or null if all passed.
  MapEntry<String, DateTime>? nextPrayer() {
    final now = DateTime.now();
    for (final entry in ordered) {
      if (entry.value.isAfter(now)) return entry;
    }
    return null; // all prayers passed for today
  }

  DateTime? timeFor(String key) {
    switch (key) {
      case 'fajr':
        return fajr;
      case 'sunrise':
        return sunrise;
      case 'dhuhr':
        return dhuhr;
      case 'asr':
        return asr;
      case 'maghrib':
        return maghrib;
      case 'isha':
        return isha;
      default:
        return null;
    }
  }
}

/// A single adhkar item.
class AdhkarItem {
  final String arabicText;
  final String translationEn;
  final String translationFr;
  final int repeatCount;
  final String? reference;

  const AdhkarItem({
    required this.arabicText,
    required this.translationEn,
    required this.translationFr,
    required this.repeatCount,
    this.reference,
  });
}

/// A group/category of adhkar.
class AdhkarCategory {
  final String keyEn;
  final String keyFr;
  final String keyAr;
  final List<AdhkarItem> items;

  const AdhkarCategory({
    required this.keyEn,
    required this.keyFr,
    required this.keyAr,
    required this.items,
  });
}