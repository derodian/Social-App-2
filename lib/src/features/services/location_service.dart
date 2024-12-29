import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:logger/logger.dart';

class LocationService {
  final log = Logger();
  Future<List<Location>> getLocationFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('Address lookup timed out');
      });
      return locations;
    } catch (e) {
      log.e('Error in getLocationFromAddress: $e');
      rethrow;
    }
  }
}
