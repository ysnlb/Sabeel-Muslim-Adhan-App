import 'package:adhan_dart/adhan_dart.dart';
import '../models/models.dart';

/// Stateless service that computes prayer times for a given day.
/// This has zero Flutter dependency so it can run in a background isolate.
class PrayerCalculationService {
  PrayerCalculationService._();

  /// Calculate today's prayer times (or for [date] if provided).
  static PrayerTimesData? calculate({
    required double latitude,
    required double longitude,
    required String method,
    required String madhab,
    int adjFajr = 0,
    int adjSunrise = 0,
    int adjDhuhr = 0,
    int adjAsr = 0,
    int adjMaghrib = 0,
    int adjIsha = 0,
    DateTime? date,
  }) {
    if (latitude == 0.0 && longitude == 0.0) return null;

    try {
      final coordinates = Coordinates(latitude, longitude);
      final dateComponents = DateComponents.from(date ?? DateTime.now());
      final params = _resolveMethod(method);

      // Set madhab for Asr calculation
      if (madhab == 'Hanafi') {
        params.madhab = Madhab.Hanafi;
      } else {
        params.madhab = Madhab.Shafi;
      }

      final times = PrayerTimes(coordinates, dateComponents, params);

      return PrayerTimesData(
        fajr: times.fajr!.add(Duration(minutes: adjFajr)),
        sunrise: times.sunrise!.add(Duration(minutes: adjSunrise)),
        dhuhr: times.dhuhr!.add(Duration(minutes: adjDhuhr)),
        asr: times.asr!.add(Duration(minutes: adjAsr)),
        maghrib: times.maghrib!.add(Duration(minutes: adjMaghrib)),
        isha: times.isha!.add(Duration(minutes: adjIsha)),
      );
    } catch (e) {
      return null;
    }
  }

  /// Calculate tomorrow's Fajr (used when all today's prayers have passed).
  static DateTime? tomorrowFajr({
    required double latitude,
    required double longitude,
    required String method,
    required String madhab,
    int adjFajr = 0,
  }) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final data = calculate(
      latitude: latitude,
      longitude: longitude,
      method: method,
      madhab: madhab,
      adjFajr: adjFajr,
      date: tomorrow,
    );
    return data?.fajr;
  }

  /// Map user-facing method string to [CalculationParameters].
  static CalculationParameters _resolveMethod(String method) {
    switch (method) {
      case 'Egyptian':
        return CalculationMethod.Egyptian.getParameters();
      case 'Karachi':
        return CalculationMethod.Karachi.getParameters();
      case 'UmmAlQura':
        return CalculationMethod.UmmAlQura.getParameters();
      case 'Dubai':
        return CalculationMethod.Dubai.getParameters();
      case 'NorthAmerica':
        return CalculationMethod.NorthAmerica.getParameters();
      case 'Kuwait':
        return CalculationMethod.Kuwait.getParameters();
      case 'Qatar':
        return CalculationMethod.Qatar.getParameters();
      case 'Singapore':
        return CalculationMethod.Singapore.getParameters();
      case 'Turkey':
        return CalculationMethod.Turkey.getParameters();
      case 'Tehran':
        return CalculationMethod.Tehran.getParameters();
      case 'MuslimWorldLeague':
      default:
        return CalculationMethod.MuslimWorldLeague.getParameters();
    }
  }
}