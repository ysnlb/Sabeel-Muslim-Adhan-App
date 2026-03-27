import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

/// Handles GPS position and reverse-geocoding.
class LocationService {
  /// Check & request permissions, then return the current position.
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

    return await Geolocator.getCurrentPosition(
      Position position = await Geolocator.getCurrentPosition();
    );
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