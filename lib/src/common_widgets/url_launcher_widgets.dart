import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/features/services/snackbar_service.dart';
import 'package:social_app_2/src/features/services/url_launcher_service.dart';
import 'package:social_app_2/src/theme/app_colors.dart';
import 'package:social_app_2/src/utils/url_launcher_utils.dart';
import 'package:url_launcher/url_launcher.dart';

// class PhoneNumber extends StatelessWidget {
//   const PhoneNumber({
//     super.key,
//     required this.phoneNumber,
//     this.isIconOnly = false,
//   });
//   final String phoneNumber;
//   final bool isIconOnly;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () async {
//         // await launchUrl('tel:+1-816-555-1212');
//         final Uri launchUri = Uri(
//           scheme: 'tel',
//           path: phoneNumber,
//         );
//         if (await canLaunchUrl(launchUri)) {
//           await launchUrl(launchUri);
//         } else {
//           throw 'Could not launch $launchUri';
//         }
//       },
//       child: isIconOnly
//           ? const Icon(Icons.phone)
//           : ListTile(
//               leading: Icon(
//                 Icons.phone,
//                 size: 28,
//                 color: AppColors.kcPrimaryColor,
//               ),
//               title: Text(
//                 phoneNumber,
//                 style: bodyStyle,
//               ),
//             ),
//     );
//   }
// }

// class SMSNumber extends StatelessWidget {
//   const SMSNumber({
//     super.key,
//     required this.phoneNumber,
//     this.isIconOnly = false,
//   });

//   final String phoneNumber;
//   final bool isIconOnly;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () async {
//         // await launchUrl('tel:+1-816-555-1212');
//         final Uri launchUri = Uri(
//           scheme: 'sms',
//           path: phoneNumber,
//         );
//         if (await canLaunchUrl(launchUri)) {
//           await launchUrl(launchUri);
//         } else {
//           throw 'Could not launch $launchUri';
//         }
//       },
//       child: isIconOnly
//           ? const Icon(Icons.message)
//           : ListTile(
//               leading: Icon(
//                 Icons.message,
//                 size: 28,
//                 color: AppColors.kcPrimaryColor,
//               ),
//               title: Text(
//                 phoneNumber,
//                 style: bodyStyle,
//               ),
//             ),
//     );
//   }
// }

// class EmailAddress extends StatelessWidget {
//   const EmailAddress({
//     super.key,
//     required this.emailAddress,
//     this.isIconOnly = false,
//   });
//   final String emailAddress;
//   final bool isIconOnly;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () async {
//         // await launchUrl('tel:+1-816-555-1212');
//         final Uri launchUri = Uri(
//           scheme: 'mailto',
//           path: emailAddress,
//         );
//         if (await canLaunchUrl(launchUri)) {
//           await launchUrl(launchUri);
//         } else {
//           throw 'Could not launch $launchUri';
//         }
//       },
//       child: isIconOnly
//           ? const Icon(Icons.email)
//           : ListTile(
//               leading: Icon(
//                 Icons.email,
//                 size: 28,
//                 color: AppColors.kcPrimaryColor,
//               ),
//               title: Text(
//                 emailAddress,
//                 style: bodyStyle,
//                 softWrap: true,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//     );
//   }
// }

// class ShowAddress extends StatelessWidget {
//   ShowAddress({
//     super.key,
//     required this.address,
//     this.location,
//     this.isIconOnly = false,
//     this.isClickable = true,
//   });
//   final String? location;
//   final String address;
//   final bool isIconOnly;
//   final bool isClickable;

//   final UrlLauncherService _urlLauncherService = UrlLauncherService();

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: isClickable
//           ? () {
//               _urlLauncherService.openMaps(
//                   address: address, locationName: location);
//             }
//           : null,
//       child: isIconOnly
//           ? const Icon(Icons.location_on)
//           : ListTile(
//               isThreeLine: location != null,
//               leading: Icon(
//                 Icons.location_on,
//                 size: 28,
//                 color: isClickable
//                     ? AppColors.kcPrimaryColor
//                     : AppColors.kcLightGreyColor,
//               ),
//               title: Text(
//                 location ?? address,
//                 style: bodyStyle,
//               ),
//               subtitle: location != null
//                   ? Text(
//                       address,
//                       style: bodyStyle.copyWith(
//                           color: AppColors.kcMediumGreyColor),
//                     )
//                   : Container(),
//             ),
//     );
//   }
// }
// lib/widgets/launcher_widgets.dart

// class LaunchableWidget extends ConsumerWidget {
//   final String data;
//   final IconData icon;
//   final String scheme;
//   final bool isIconOnly;

//   const LaunchableWidget({
//     super.key,
//     required this.data,
//     required this.icon,
//     required this.scheme,
//     this.isIconOnly = false,
//   });

//   Future<void> _launchUrl(WidgetRef ref) async {
//     final snackBarService = ref.read(snackBarControllerProvider.notifier);
//     final Uri launchUri = Uri(
//       scheme: scheme,
//       path: data,
//     );
//     try {
//       if (await canLaunchUrl(launchUri)) {
//         await launchUrl(launchUri);
//         snackBarService.showSuccess('Launched successfully');
//       } else {
//         throw 'Could not launch $launchUri';
//       }
//     } catch (e) {
//       debugPrint('Error launching URL: $e');
//       snackBarService.showError('Failed to launch. Please try again.');
//     }
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return InkWell(
//       onTap: () => _launchUrl(ref),
//       child: isIconOnly
//           ? Icon(icon)
//           : ListTile(
//               leading: Icon(
//                 icon,
//                 size: 28,
//                 color: AppColors.kcPrimaryColor,
//               ),
//               title: Text(
//                 data,
//                 style: Theme.of(context).textTheme.bodyLarge,
//                 softWrap: true,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//     );
//   }
// }

// class PhoneNumber extends StatelessWidget {
//   final String phoneNumber;
//   final bool isIconOnly;

//   const PhoneNumber({
//     super.key,
//     required this.phoneNumber,
//     this.isIconOnly = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return LaunchableWidget(
//       data: phoneNumber,
//       icon: Icons.phone,
//       scheme: 'tel',
//       isIconOnly: isIconOnly,
//     );
//   }
// }

// class SMSNumber extends StatelessWidget {
//   final String phoneNumber;
//   final bool isIconOnly;

//   const SMSNumber({
//     super.key,
//     required this.phoneNumber,
//     this.isIconOnly = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return LaunchableWidget(
//       data: phoneNumber,
//       icon: Icons.message,
//       scheme: 'sms',
//       isIconOnly: isIconOnly,
//     );
//   }
// }

// class EmailAddress extends StatelessWidget {
//   final String emailAddress;
//   final bool isIconOnly;

//   const EmailAddress({
//     super.key,
//     required this.emailAddress,
//     this.isIconOnly = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return LaunchableWidget(
//       data: emailAddress,
//       icon: Icons.email,
//       scheme: 'mailto',
//       isIconOnly: isIconOnly,
//     );
//   }
// }

// class ShowAddress extends ConsumerWidget {
//   final String? location;
//   final String address;
//   final bool isIconOnly;
//   final bool isClickable;

//   const ShowAddress({
//     super.key,
//     required this.address,
//     this.location,
//     this.isIconOnly = false,
//     this.isClickable = true,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final urlLauncherService = ref.watch(urlLauncherServiceProvider);
//     final snackBarService = ref.watch(snackBarControllerProvider.notifier);

//     return InkWell(
//       onTap: isClickable
//           ? () async {
//               try {
//                 await urlLauncherService.openMaps(
//                     address: address, locationName: location);
//                 snackBarService.showSuccess('Opening maps...');
//               } catch (e) {
//                 snackBarService
//                     .showError('Failed to open maps. Please try again.');
//               }
//             }
//           : null,
//       child: isIconOnly
//           ? const Icon(Icons.location_on)
//           : ListTile(
//               isThreeLine: location != null,
//               leading: Icon(
//                 Icons.location_on,
//                 size: 28,
//                 color: isClickable
//                     ? AppColors.kcPrimaryColor
//                     : AppColors.kcLightGreyColor,
//               ),
//               title: Text(
//                 location ?? address,
//                 style: Theme.of(context).textTheme.bodyLarge,
//               ),
//               subtitle: location != null
//                   ? Text(
//                       address,
//                       style: Theme.of(context).textTheme.bodyLarge,
//                     )
//                   : null,
//             ),
//     );
//   }
// }

// // Providers
// final urlLauncherServiceProvider = Provider<UrlLauncherService>((ref) {
//   return UrlLauncherService();
// });

class LaunchableWidget extends ConsumerWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isIconOnly;
  final bool enabled;
  final Color? iconColor;

  const LaunchableWidget({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isIconOnly = false,
    this.enabled = true,
    this.iconColor,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final effectiveIconColor = iconColor ??
        (enabled ? theme.colorScheme.primary : theme.colorScheme.outline);

    return InkWell(
      onTap: enabled ? onTap : null,
      child: isIconOnly
          ? Icon(icon, color: effectiveIconColor)
          : ListTile(
              enabled: enabled,
              leading: Icon(
                icon,
                size: 24,
                color: effectiveIconColor,
              ),
              title: Text(
                label,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: enabled ? null : theme.colorScheme.outline,
                ),
              ),
            ),
    );
  }
}

class PhoneNumber extends ConsumerWidget {
  final String phoneNumber;
  final bool isIconOnly;
  final bool enabled;

  const PhoneNumber({
    required this.phoneNumber,
    this.isIconOnly = false,
    this.enabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LaunchableWidget(
      label: phoneNumber,
      icon: Icons.phone,
      enabled: enabled,
      isIconOnly: isIconOnly,
      onTap: () => context.launchPhone(phoneNumber),
    );
  }
}

class SMSNumber extends ConsumerWidget {
  final String phoneNumber;
  final bool isIconOnly;
  final bool enabled;

  const SMSNumber({
    required this.phoneNumber,
    this.isIconOnly = false,
    this.enabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LaunchableWidget(
      label: phoneNumber,
      icon: Icons.message,
      enabled: enabled,
      isIconOnly: isIconOnly,
      onTap: () => context.launchSMS(phoneNumber),
    );
  }
}

class EmailAddress extends ConsumerWidget {
  final String email;
  final String? subject;
  final String? body;
  final bool isIconOnly;
  final bool enabled;

  const EmailAddress({
    required this.email,
    this.subject,
    this.body,
    this.isIconOnly = false,
    this.enabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LaunchableWidget(
      label: email,
      icon: Icons.email,
      enabled: enabled,
      isIconOnly: isIconOnly,
      onTap: () => context.launchEmail(
        email,
        subject: subject,
        body: body,
      ),
    );
  }
}

class Address extends ConsumerWidget {
  final String address;
  final String? locationName;
  final bool isIconOnly;
  final bool enabled;

  const Address({
    required this.address,
    this.locationName,
    this.isIconOnly = false,
    this.enabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LaunchableWidget(
      label: locationName ?? address,
      icon: Icons.location_on,
      enabled: enabled,
      isIconOnly: isIconOnly,
      onTap: () => context.launchMap(address),
    );
  }
}
