import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// class UrlLauncherResult {
//   const UrlLauncherResult._({
//     required this.success,
//     this.error,
//   });

//   final bool success;
//   final String? error;

//   // Static instances
//   static const UrlLauncherResult successResult =
//       UrlLauncherResult._(success: true);

//   // Factory constructor for success
//   factory UrlLauncherResult.success() => successResult;

//   // Factory constructor for error
//   factory UrlLauncherResult.error(String message) =>
//       UrlLauncherResult._(success: false, error: message);
// }

// enum PhoneAction {
//   call,
//   message;

//   String get label => switch (this) {
//         PhoneAction.call => 'Call',
//         PhoneAction.message => 'Message',
//       };

//   IconData get icon => switch (this) {
//         PhoneAction.call => Icons.phone,
//         PhoneAction.message => Icons.message,
//       };
// }

// class UrlLauncherUtils {
//   static Future<UrlLauncherResult> openPhone(
//     BuildContext context,
//     String phoneNumber,
//   ) async {
//     try {
//       final action = await _showPhoneActionDialog(context);
//       if (action == null || !context.mounted) {
//         return UrlLauncherResult.error('Action cancelled');
//       }

//       final url = switch (action) {
//         PhoneAction.call => 'tel:$phoneNumber',
//         PhoneAction.message => 'sms:$phoneNumber',
//       };

//       return await _launchUrl(url);
//     } catch (e) {
//       return UrlLauncherResult.error(e.toString());
//     }
//   }

//   static Future<UrlLauncherResult> openEmail(
//     String email, {
//     String? subject,
//     String? body,
//   }) async {
//     try {
//       final Uri emailLaunchUri = Uri(
//         scheme: 'mailto',
//         path: email,
//         queryParameters: {
//           if (subject != null) 'subject': subject,
//           if (body != null) 'body': body,
//         },
//       );

//       return await _launchUrl(emailLaunchUri.toString());
//     } catch (e) {
//       return UrlLauncherResult.error(e.toString());
//     }
//   }

//   static Future<UrlLauncherResult> openMap(String address) async {
//     try {
//       // Try Google Maps first
//       final googleUrl =
//           'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}';
//       final googleMapsResult = await _launchUrl(googleUrl);
//       if (googleMapsResult.success) {
//         return googleMapsResult;
//       }

//       // Fallback to Apple Maps on iOS
//       final appleUrl = 'maps://?q=${Uri.encodeComponent(address)}';
//       final appleMapsResult = await _launchUrl(appleUrl);
//       if (appleMapsResult.success) {
//         return appleMapsResult;
//       }

//       // Final fallback to browser
//       final browserUrl =
//           'https://maps.google.com/?q=${Uri.encodeComponent(address)}';
//       return await _launchUrl(browserUrl);
//     } catch (e) {
//       return UrlLauncherResult.error(e.toString());
//     }
//   }

//   static Future<UrlLauncherResult> openWebUrl(String url) async {
//     try {
//       if (!url.startsWith('http://') && !url.startsWith('https://')) {
//         url = 'https://$url';
//       }
//       return await _launchUrl(url);
//     } catch (e) {
//       return UrlLauncherResult.error(e.toString());
//     }
//   }

//   static Future<PhoneAction?> _showPhoneActionDialog(
//       BuildContext context) async {
//     return showDialog<PhoneAction>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Contact via'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: PhoneAction.values.map((action) {
//             return ListTile(
//               leading: Icon(action.icon),
//               title: Text(action.label),
//               onTap: () => Navigator.of(context).pop(action),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }

//   static Future<UrlLauncherResult> _launchUrl(String url) async {
//     try {
//       final uri = Uri.parse(url);
//       if (await canLaunchUrl(uri)) {
//         final launched = await launchUrl(
//           uri,
//           mode: LaunchMode.platformDefault,
//         );
//         return launched
//             ? UrlLauncherResult.success()
//             : UrlLauncherResult.error('Failed to launch URL');
//       }
//       return UrlLauncherResult.error('Cannot launch URL: $url');
//     } catch (e) {
//       return UrlLauncherResult.error(e.toString());
//     }
//   }
// }

// // Extension for showing snackbars
// extension SnackBarX on BuildContext {
//   void showErrorSnackBar(String message) {
//     print(message);
//     ScaffoldMessenger.of(this).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }

//   void showSuccessSnackBar(String message) {
//     ScaffoldMessenger.of(this).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }

//   void showInfoSnackBar(String message) {
//     ScaffoldMessenger.of(this).showSnackBar(
//       SnackBar(
//         content: Text(message),
//       ),
//     );
//   }
// }

// // URL Launcher extensions
// extension UrlLauncherUtilsX on BuildContext {
//   Future<void> launchPhone(String phone) async {
//     final result = await UrlLauncherUtils.openPhone(this, phone);
//     if (mounted) {
//       if (result.success) {
//         showSuccessSnackBar('Launching phone action...');
//       } else {
//         showErrorSnackBar(result.error ?? 'Failed to launch phone action');
//       }
//     }
//   }

//   Future<void> launchEmail(String email,
//       {String? subject, String? body}) async {
//     final result = await UrlLauncherUtils.openEmail(
//       email,
//       subject: subject,
//       body: body,
//     );
//     if (mounted) {
//       if (result.success) {
//         showSuccessSnackBar('Opening email...');
//       } else {
//         showErrorSnackBar(result.error ?? 'Failed to launch email');
//       }
//     }
//   }

//   Future<void> launchMap(String address) async {
//     final result = await UrlLauncherUtils.openMap(address);
//     if (mounted) {
//       if (result.success) {
//         showSuccessSnackBar('Opening map...');
//       } else {
//         showErrorSnackBar(result.error ?? 'Failed to open map');
//       }
//     }
//   }

//   Future<void> launchWeb(String url) async {
//     final result = await UrlLauncherUtils.openWebUrl(url);
//     if (mounted) {
//       if (result.success) {
//         showSuccessSnackBar('Opening website...');
//       } else {
//         showErrorSnackBar(result.error ?? 'Failed to open URL');
//       }
//     }
//   }
// }

/// Result class for URL launch operations
class UrlLauncherResult {
  final bool success;
  final String? error;

  const UrlLauncherResult._({
    required this.success,
    this.error,
  });

  // Static instances
  static const successResult = UrlLauncherResult._(success: true);

  // Factory constructors
  factory UrlLauncherResult.success() => successResult;

  factory UrlLauncherResult.error(String message) =>
      UrlLauncherResult._(success: false, error: message);
}

extension UrlLauncherX on BuildContext {
  /// Launch phone dialer
  Future<void> launchPhone(String phone) async {
    final formattedPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');
    final uri = Uri(scheme: 'tel', path: formattedPhone);
    await _launchUrl(uri, 'Could not launch phone dialer');
  }

  /// Launch SMS
  Future<void> launchSMS(String phone, {String? message}) async {
    final formattedPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');
    final uri = Uri(
      scheme: 'sms',
      path: formattedPhone,
      queryParameters: message != null ? {'body': message} : null,
    );
    await _launchUrl(uri, 'Could not launch SMS');
  }

  /// Launch email client
  Future<void> launchEmail(
    String email, {
    String? subject,
    String? body,
    List<String>? cc,
    List<String>? bcc,
  }) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
        if (cc != null && cc.isNotEmpty) 'cc': cc.join(','),
        if (bcc != null && bcc.isNotEmpty) 'bcc': bcc.join(','),
      },
    );
    await _launchUrl(uri, 'Could not launch email client');
  }

  /// Launch maps
  Future<void> launchMap(
    String address, {
    String? label,
    double? latitude,
    double? longitude,
    MapProvider provider = MapProvider.google,
  }) async {
    final encodedAddress = Uri.encodeComponent(address);
    final uri = switch (provider) {
      MapProvider.google => Uri.parse(
          'https://www.google.com/maps/search/?api=1&query=$encodedAddress'),
      MapProvider.apple when latitude != null && longitude != null => Uri.parse(
          'https://maps.apple.com/?ll=$latitude,$longitude&q=$encodedAddress'),
      MapProvider.apple =>
        Uri.parse('https://maps.apple.com/?address=$encodedAddress'),
      MapProvider.waze =>
        Uri.parse('https://waze.com/ul?q=$encodedAddress&navigate=yes'),
    };
    await _launchUrl(uri, 'Could not launch maps');
  }

  /// Launch WhatsApp
  Future<void> launchWhatsApp(
    String phone, {
    String? message,
  }) async {
    final formattedPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');
    final uri = Uri.parse(
      'whatsapp://send?phone=$formattedPhone${message != null ? '&text=${Uri.encodeComponent(message)}' : ''}',
    );
    await _launchUrl(uri, 'Could not launch WhatsApp');
  }

  /// Launch web URL
  Future<void> launchWeb(
    String url, {
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    String processedUrl = url;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      processedUrl = 'https://$url';
    }
    final uri = Uri.parse(processedUrl);
    await _launchUrl(uri, 'Could not launch webpage', mode: mode);
  }

  /// Launch social media profile
  Future<void> launchSocialMedia(
    SocialMediaPlatform platform,
    String username,
  ) async {
    final url = switch (platform) {
      SocialMediaPlatform.facebook => 'https://facebook.com/$username',
      SocialMediaPlatform.twitter => 'https://twitter.com/$username',
      SocialMediaPlatform.instagram => 'https://instagram.com/$username',
      SocialMediaPlatform.linkedin => 'https://linkedin.com/in/$username',
      SocialMediaPlatform.github => 'https://github.com/$username',
    };
    await launchWeb(url);
  }

  /// Launch file (PDF, etc.)
  Future<void> launchFile(String url) async {
    final uri = Uri.parse(url);
    await _launchUrl(
      uri,
      'Could not open file',
      mode: LaunchMode.externalApplication,
    );
  }

  /// Generic URL launcher with error handling
  Future<void> _launchUrl(
    Uri uri,
    String errorMessage, {
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    try {
      final canLaunch = await canLaunchUrl(uri);
      if (!canLaunch) {
        throw errorMessage;
      }
      await launchUrl(uri, mode: mode);
    } catch (e) {
      throw Exception('$errorMessage: $e');
    }
  }
}

/// Map provider options
enum MapProvider {
  google,
  apple,
  waze,
}

/// Social media platforms
enum SocialMediaPlatform {
  facebook,
  twitter,
  instagram,
  linkedin,
  github,
}

/// Helper for checking platform capabilities
class UrlLauncherHelper {
  static Future<bool> canOpenPhone() async {
    return await canLaunchUrl(Uri(scheme: 'tel', path: '123'));
  }

  static Future<bool> canOpenSMS() async {
    return await canLaunchUrl(Uri(scheme: 'sms', path: '123'));
  }

  static Future<bool> canOpenEmail() async {
    return await canLaunchUrl(Uri(scheme: 'mailto', path: 'test@test.com'));
  }

  static Future<bool> canOpenWhatsApp() async {
    return await canLaunchUrl(Uri.parse('whatsapp://send'));
  }
}

// Usage example
// class ContactProfile extends StatelessWidget {
//   final Contact contact;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Basic contact methods
//         PhoneNumber(phoneNumber: contact.phone),
//         SMSNumber(phoneNumber: contact.phone),
//         EmailAddress(email: contact.email),
        
//         // Address with specific map provider
//         ElevatedButton(
//           onPressed: () => context.launchMap(
//             contact.address,
//             provider: MapProvider.waze,
//           ),
//           child: const Text('Navigate with Waze'),
//         ),

//         // WhatsApp
//         ElevatedButton(
//           onPressed: () => context.launchWhatsApp(
//             contact.phone,
//             message: 'Hi ${contact.name}!',
//           ),
//           child: const Text('Message on WhatsApp'),
//         ),

//         // Social media links
//         if (contact.socialMedia != null) ...[
//           ElevatedButton(
//             onPressed: () => context.launchSocialMedia(
//               SocialMediaPlatform.linkedin,
//               contact.socialMedia!.linkedin,
//             ),
//             child: const Text('View LinkedIn Profile'),
//           ),
//         ],

//         // Open PDF file
//         if (contact.resumeUrl != null)
//           ElevatedButton(
//             onPressed: () => context.launchFile(contact.resumeUrl!),
//             child: const Text('View Resume'),
//           ),
//       ],
//     );
//   }
// }