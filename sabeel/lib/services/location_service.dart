import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

/// Handles GPS position and reverse-geocoding (and forward geocoding for city names).
class LocationService {
  /// Check & request permissions, then return the current position (GPS).
  static Future<Position> getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }

  /// الحصول على الإحداثيات من اسم المدينة مباشرة (الطريقة اليدوية)
  static Future<Position?> getCoordinatesFromCity(String cityName) async {
    try {
      List<Location> locations = await locationFromAddress(cityName);
      if (locations.isNotEmpty) {
        return Position(
          latitude: locations.first.latitude,
          longitude: locations.first.longitude,
          timestamp: DateTime.now(),
          accuracy: 100.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
          altitudeAccuracy: 0.0,
          headingAccuracy: 0.0,
        );
      }
    } catch (e) {
      print("Error finding city: $e");
    }
    return null; // يرجع null إيلا مالقاش المدينة
  }

  /// Reverse-geocode coordinates to a human-readable city name.
  static Future<String> getCityName(double lat, double lon) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lon);
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        return p.locality ?? p.subAdministrativeArea ?? p.administrativeArea ?? '';
      }
    } catch (_) {}
    return '';
  }
}