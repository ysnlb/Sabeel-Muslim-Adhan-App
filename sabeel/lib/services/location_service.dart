import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

/// Handles GPS position and reverse/forward geocoding.
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

  /// الحصول على الإحداثيات من اسم المدينة مباشرة (الطريقة القديمة)
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
    return null;
  }

  /// البحث عن المدن وإرجاع قائمة بالخيارات (الجديدة)
  static Future<List<Map<String, dynamic>>> searchCities(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);
      List<Map<String, dynamic>> results = [];
      
      // ندو أول 5 نتائج باش ما نكثروش على المستعمل
      for (var loc in locations.take(5)) {
        try {
          final placemarks = await placemarkFromCoordinates(loc.latitude, loc.longitude);
          if (placemarks.isNotEmpty) {
            final p = placemarks.first;
            // نركبو اسم شباب (المدينة، الولاية، البلد)
            final nameParts = [p.locality, p.administrativeArea, p.country]
                .where((e) => e != null && e.toString().isNotEmpty)
                .toList();
            
            final name = nameParts.join(', ');
            
            results.add({
              'name': name.isEmpty ? query : name,
              'lat': loc.latitude,
              'lon': loc.longitude
            });
          }
        } catch (_) {
          // يلا صرى مشكل في تفاصيل وحدة من المدن، يكمل للجاية عادي
        }
      }
      return results;
    } catch (e) {
      print("Error searching cities: $e");
      return [];
    }
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