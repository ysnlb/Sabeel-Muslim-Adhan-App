import 'package:adhan/adhan.dart';
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
        params.madhab = Madhab.hanafi;
      } else {
        params.madhab = Madhab.shafi;
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
        return CalculationMethod.egyptian.getParameters();
      case 'Karachi':
        return CalculationMethod.karachi.getParameters();
      case 'UmmAlQura':
        return CalculationMethod.umm_al_qura.getParameters();
      case 'Dubai':
        return CalculationMethod.dubai.getParameters();
      case 'NorthAmerica':
        return CalculationMethod.north_america.getParameters();
      case 'Kuwait':
        return CalculationMethod.kuwait.getParameters();
      case 'Qatar':
        return CalculationMethod.qatar.getParameters();
      case 'Singapore':
        return CalculationMethod.singapore.getParameters();
      case 'Turkey':
        return CalculationMethod.turkey.getParameters();
      case 'Tehran':
        return CalculationMethod.tehran.getParameters();
      case 'MuslimWorldLeague':
      default:
        return CalculationMethod.muslim_world_league.getParameters();
    }
  }
}