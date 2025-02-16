// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:social_app_2/src/common_widgets/async_value_widget.dart';
// import 'package:social_app_2/src/common_widgets/divider_with_margins.dart';
// import 'package:social_app_2/src/common_widgets/empty_placeholder_widget.dart';
// import 'package:social_app_2/src/common_widgets/url_launcher_widgets.dart';
// import 'package:social_app_2/src/constants/app_sizes.dart';
// import 'package:social_app_2/src/constants/strings.dart';
// import 'package:social_app_2/src/features/auth/data/app_user_storage_service.dart';
// import 'package:social_app_2/src/features/auth/domain/app_user.dart';
// import 'package:social_app_2/src/features/auth/typedefs/user_id.dart';
// import 'package:social_app_2/src/features/components/image/custom_circular_avatar.dart';
// import 'package:social_app_2/src/features/components/image/custom_cover_image.dart';
// import 'package:social_app_2/src/utils/string_hardcoded.dart';

// class UserInfoScreen extends ConsumerWidget {
//   const UserInfoScreen({
//     super.key,
//     required this.userId,
//   });
//   final UserID userId;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final user = ref.watch(appUserStreamProvider(userId));

//     return AsyncValueWidget<AppUser?>(
//       value: user,
//       data: (user) => user == null
//           ? EmptyPlaceholderWidget(
//               message: 'User details not found'.hardcoded,
//             )
//           : UserDetailsView(user: user),
//     );
//   }
// }

// class UserDetailsView extends StatelessWidget {
//   const UserDetailsView({
//     super.key,
//     required this.user,
//   });
//   final AppUser user;

//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     final titleText = user.displayName?.isNotEmpty == true
//         ? user.displayName!
//         : user.email.split('@').first;
//     return Stack(
//       children: [
//         if (user.profileBannerImageURL != null &&
//             user.profileBannerImageURL!.isNotEmpty)
//           CustomCoverImage(
//             imageUrl: user.profileBannerImageURL,
//           ),
//         SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(
//               vertical: 0,
//               horizontal: 16,
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               // crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: screenSize.height * 0.07),
//                 Stack(
//                   alignment: Alignment.bottomRight,
//                   children: [_buildProfileImage()],
//                 ),
//                 gapH8,
//                 Text(
//                   titleText,
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//                 // gapH8,
//                 const DividerWithMargins(),
//                 _buildUserInfo(),
//                 const DividerWithMargins(),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildProfileImage() {
//     return (user.photoURL?.isNotEmpty == true)
//         ? Center(
//             child: CustomCircularAvatar(
//               imageUrl: user.photoURL,
//               radius: 80,
//             ),
//           )
//         : Container(
//             height: 150,
//             width: 150,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(75),
//               border: Border.all(
//                 color: Colors.white,
//                 width: 2.0,
//               ),
//               image: const DecorationImage(
//                 image: AssetImage(Strings.assetProfileImage),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           );
//   }

//   Widget _buildUserInfo() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         EmailAddress(emailAddress: user.email),
//         if (user.phoneNumber?.isNotEmpty == true)
//           PhoneNumber(phoneNumber: user.phoneNumber!),
//         if (user.street?.isNotEmpty == true)
//           ShowAddress(
//             address:
//                 '${user.street}\n${user.city} ${user.state} ${user.zip}\n${user.country}',
//           ),
//       ],
//     );
//   }
// }
