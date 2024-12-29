import 'dart:io' show Platform;

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:social_app_2/src/features/services/location_service.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  final LocationService _locationService = LocationService();
  final log = Logger();
  // Method to open maps, providing options if both apps are available
  Future<void> openMaps({required String address, String? locationName}) async {
    try {
      // get coordinates from address
      var locations = await _locationService.getLocationFromAddress(address);
      Uri? googleUrl;
      Uri? appleUrl;

      String label = Uri.encodeComponent(
          locationName?.isNotEmpty == true ? locationName! : address);

      if (locations.isNotEmpty) {
        double lat = locations.first.latitude;
        double lon = locations.first.longitude;
        log.i('Latitude: $lat, Longitude: $lon');
        googleUrl = Uri.parse(
            "https://www.google.com/maps/search/?api=1&query=$lat,$lon&query_place_id=$label");
        appleUrl = Uri.parse(
            "https://maps.apple.com/?ll=$lat,$lon&q=$lat,$lon&q=$label");
      } else {
        final String query = Uri.encodeComponent(address);

        appleUrl = Uri.parse("https://maps.apple.com/?address=$query&q=$label");
        googleUrl =
            Uri.parse("https://www.google.com/maps/search/?api=1&query=$query");
      }

      if (Platform.isIOS) {
        // Attempt to launch Apple Maps, if fails, try Google Maps
        if (await canLaunchUrl(appleUrl)) {
          await launchUrl(appleUrl, mode: LaunchMode.externalApplication);
        } else if (await canLaunchUrl(googleUrl)) {
          await launchUrl(googleUrl, mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not launch maps';
        }
      } else if (Platform.isAndroid) {
        // Android devices usually have Google Maps
        if (await canLaunchUrl(googleUrl)) {
          await launchUrl(googleUrl, mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not launch maps';
        }
      }
    } on PlatformException catch (e) {
      log.i('PlatformException in openMaps: ${e.message}');
      // Fallback to web URL
      String webUrl =
          'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}';
      if (await canLaunchUrl(Uri.parse(webUrl))) {
        await launchUrl(Uri.parse(webUrl),
            mode: LaunchMode.externalNonBrowserApplication);
      } else {
        throw 'Could not launch maps';
      }
    } catch (e) {
      log.i('Error in openMaps: $e');
      rethrow;
    }
  }

  Future<void> sendEmail({
    required String toEmail,
    String subject = "",
    String body = "",
  }) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: toEmail,
      query: encodeQueryParameters(<String, String>{
        'subject': subject,
        'body': body,
      }),
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch email app';
    }
  }

  // Method to send SMS
  Future<void> sendSMS({required String phoneNumber}) async {
    final Uri smsLaunchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );

    if (await canLaunchUrl(smsLaunchUri)) {
      await launchUrl(smsLaunchUri);
    } else {
      throw 'Could not launch SMS app';
    }
  }

  // Method to make phone calls
  Future<void> makePhoneCall({required String phoneNumber}) async {
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    if (await canLaunchUrl(phoneLaunchUri)) {
      await launchUrl(phoneLaunchUri);
    } else {
      throw 'Could not launch phone app';
    }
  }

  // Method to open files using their default application
  Future<void> openFile({required String filePath}) async {
    final Uri fileUri = Uri.file(filePath);

    if (await canLaunchUrl(fileUri)) {
      await launchUrl(fileUri);
    } else {
      throw 'Could not open file';
    }
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
