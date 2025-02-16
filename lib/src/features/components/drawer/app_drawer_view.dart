// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:social_app_2/src/common_widgets/alert_dialog_model.dart';
// import 'package:social_app_2/src/common_widgets/async_value_widget.dart';
// import 'package:social_app_2/src/common_widgets/divider_with_text.dart';
// import 'package:social_app_2/src/constants/strings.dart';
// import 'package:social_app_2/src/features/auth/data/app_user_storage_service.dart';
// import 'package:social_app_2/src/features/auth/data/auth_service.dart';
// import 'package:social_app_2/src/features/auth/domain/app_user.dart';
// import 'package:social_app_2/src/features/auth/typedefs/user_id.dart';
// import 'package:social_app_2/src/features/components/admin_only/admin_only_widget.dart';
// import 'package:social_app_2/src/features/components/dialogs/logout_dialog.dart';
// import 'package:social_app_2/src/features/components/image/custom_circular_avatar.dart';
// import 'package:social_app_2/src/routing/app_router.dart';
// import 'package:social_app_2/src/theme/app_colors.dart';
// import 'package:social_app_2/src/theme/theme_provider.dart';

// class AppDrawerView extends ConsumerWidget {
//   const AppDrawerView({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentUserID = ref.watch(authRepositoryProvider).currentUser?.id;
//     if (currentUserID == null) {
//       return const SizedBox.shrink(); // Or some error widget
//     }

//     final currentUser = ref.watch(appUserFutureProvider(currentUserID));

//     return Drawer(
//       clipBehavior: Clip.hardEdge,
//       child: Column(
//         children: [
//           _buildUserInfo(
//             context: context,
//             ref: ref,
//             userID: currentUserID,
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   // _buildUserInfo(
//                   //     context: context, ref: ref, userID: currentUserID),
//                   _buildDrawerItems(
//                     context,
//                     ref,
//                     currentUser.value,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const DividerWithText(
//             text: "APPEARANCE",
//           ),
//           _buildThemeSwitcher(context: context, ref: ref),
//         ],
//       ),
//     );
//   }

//   Widget _buildUserInfo({
//     required BuildContext context,
//     required WidgetRef ref,
//     required UserID userID,
//   }) {
//     return AsyncValueWidget(
//       value: ref.watch(appUserFutureProvider(userID)),
//       data: (user) => _UserInfoHeader(user: user),
//     );
//   }

//   Widget _buildThemeSwitcher(
//       {required BuildContext context, required WidgetRef ref}) {
//     final themeNotifier = ref.read(themeProvider.notifier);
//     return ListTile(
//       title: Text(
//         "Dark Mode",
//         style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Theme.of(context).colorScheme.primary),
//       ),
//       trailing: CupertinoSwitch(
//         value: themeNotifier.isDarkMode,
//         onChanged: (value) {
//           themeNotifier.toggleTheme(value);
//         },
//       ),
//     );
//   }

//   Widget _buildDrawerItems(
//       BuildContext context, WidgetRef ref, AppUser? currentUser) {
//     return Column(
//       children: [
//         _DrawerItem(
//           icon: FontAwesomeIcons.userTie,
//           title: Strings.committee,
//           onTap: () => _navigateTo(ref, AppRoute.committeeMembers),
//         ),
//         AdminOnlyWidget(
//           child: _DrawerItem(
//             icon: FontAwesomeIcons.userGroup,
//             title: Strings.appUsers,
//             onTap: () => _navigateTo(ref, AppRoute.appUsers),
//           ),
//         ),
//         _DrawerItem(
//           icon: FontAwesomeIcons.arrowRightFromBracket,
//           title: 'Log out',
//           onTap: () => _handleLogout(context, ref),
//         ),
//       ],
//     );
//   }

//   void _navigateTo(WidgetRef ref, AppRoute route) {
//     ref.read(appRouterProvider).pop();
//     ref.read(appRouterProvider).pushNamed(route.name);
//   }

//   Future<void> _handleLogout(BuildContext context, WidgetRef ref) async {
//     // final navigator = Navigator.of(context);
//     final shouldLogout = await const LogoutDialog()
//         .present(context)
//         .then((value) => value ?? false);
//     if (shouldLogout) {
//       await ref.read(authRepositoryProvider).signOut();
//     }
//     // navigator.pop();
//   }
// }

// class _UserInfoHeader extends ConsumerWidget {
//   final AppUser? user;

//   const _UserInfoHeader({super.key, this.user});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     if (user == null) {
//       return const SizedBox.shrink(); // Or some placeholder widget
//     }

//     final isProfileBannerImageURLAvailable =
//         user!.profileBannerImageURL != null &&
//             user!.profileBannerImageURL!.isNotEmpty;
//     final isPhotoURLAvailable =
//         user!.photoURL != null && user!.photoURL!.isNotEmpty;

//     // final _themeProvider = ref.watch(themeProvider);

//     return InkWell(
//       onTap: () => _navigateToUserAccount(ref),
//       child: Container(
//         height: 200,
//         color:
//             Theme.of(context).colorScheme.primary, // Fallback background color
//         child: Stack(
//           children: [
//             // Background image
//             if (isProfileBannerImageURLAvailable)
//               CachedNetworkImage(
//                 imageUrl: user!.profileBannerImageURL!,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                 height: 200, // Adjust this value as needed
//               ),
//             // // Theme switch
//             // Positioned(
//             //   top: 16,
//             //   right: 16,
//             //   child: GestureDetector(
//             //     onTap: () {
//             //       final themeNotifier = ref.read(themeProvider.notifier);
//             //       themeNotifier.toggleTheme(!themeNotifier.isDarkMode);
//             //     },
//             //     child: Container(
//             //       padding: const EdgeInsets.all(
//             //           8), // This creates a larger tappable area
//             //       color: Colors.transparent, // Makes the container invisible
//             //       child: AbsorbPointer(
//             //         child: CupertinoSwitch(
//             //           value: ref.watch(themeProvider) == ThemeMode.dark,
//             //           onChanged: (_) {},
//             //         ),
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             // GestureDetector(
//             //   child: Positioned(
//             //     top: 8,
//             //     right: 8,
//             //     child: AbsorbPointer(
//             //       absorbing: false,
//             //       child: CupertinoSwitch(
//             //         value: themeNotifier.isDarkMode,
//             //         onChanged: (value) {
//             //           themeNotifier.toggleTheme(value);
//             //         },
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             // Gradient overlay
//             Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.transparent,
//                     AppColors.kcBlackColor.withOpacity(0.7),
//                     // Theme.of(context).colorScheme.background.withOpacity(0.1),
//                     // Theme.of(context).colorScheme.background.withOpacity(0.8),
//                   ],
//                 ),
//               ),
//             ),
//             // User info
//             Positioned.fill(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     if (isPhotoURLAvailable)
//                       CustomCircularAvatar(
//                         imageUrl: user!.photoURL,
//                         radius: 40,
//                       )
//                     else
//                       CircleAvatar(
//                         radius: 40,
//                         backgroundColor:
//                             Theme.of(context).colorScheme.secondary,
//                         child: Text(
//                           user!.displayName?.isNotEmpty == true
//                               ? user!.displayName![0].toUpperCase()
//                               : '?',
//                           style: TextStyle(
//                             fontSize: 32,
//                             color: Theme.of(context).colorScheme.onSecondary,
//                           ),
//                         ),
//                       ),
//                     const SizedBox(height: 8),
//                     _buildOverlayText(
//                       context,
//                       user!.displayName ?? '',
//                       Theme.of(context).textTheme.titleMedium,
//                     ),
//                     const SizedBox(height: 4),
//                     _buildOverlayText(
//                       context,
//                       user!.email,
//                       Theme.of(context).textTheme.bodyMedium,
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildOverlayText(
//       BuildContext context, String text, TextStyle? style) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         gradient: LinearGradient(
//           colors: [
//             Theme.of(context).colorScheme.shadow.withOpacity(0.0),
//             Theme.of(context).colorScheme.shadow.withOpacity(0.4),
//             Theme.of(context).colorScheme.shadow.withOpacity(0.0),
//           ],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           stops: const [0.0, 0.5, 1.0],
//         ),
//       ),
//       child: Text(
//         text,
//         style: style?.copyWith(
//           color: AppColors.kcWhiteColor,
//           shadows: [
//             Shadow(
//               blurRadius: 2,
//               color: Theme.of(context).colorScheme.background.withOpacity(0.5),
//               offset: const Offset(1, 1),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _navigateToUserAccount(WidgetRef ref) {
//     ref.read(appRouterProvider).pop();
//     ref.read(appRouterProvider).pushNamed(
//       AppRoute.account.name,
//       pathParameters: {'id': user!.id},
//     );
//   }
// }

// class _DrawerItem extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final VoidCallback onTap;

//   const _DrawerItem({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Icon(icon),
//       title: Text(title),
//       onTap: onTap,
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/presentation/account/profile_screen.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';
import 'package:social_app_2/src/features/components/admin_only/admin_only_widget.dart';
import 'package:social_app_2/src/routing/app_router.dart';
import 'package:social_app_2/src/theme/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).value;
    final theme = Theme.of(context);

    if (user == null) {
      return const SizedBox.shrink();
    }

    return Drawer(
      backgroundColor: theme.scaffoldBackgroundColor,
      child: Column(
        children: [
          _DrawerHeader(user: user),
          Expanded(
            child: CustomScrollView(
              slivers: [
                // Primary navigation section
                const _SectionHeader(title: 'Menu'),
                _DrawerSection(
                  items: [
                    _DrawerItem(
                      icon: Icons.home_outlined,
                      selectedIcon: Icons.home,
                      title: 'Home',
                      onTap: () {},
                      // onTap: () => _navigateTo(ref, AppRoute.home),
                    ),
                    _DrawerItem(
                      icon: Icons.person_outline,
                      selectedIcon: Icons.person,
                      title: 'Profile',
                      onTap: () => _navigateToProfile(context, user.id),
                    ),
                    _DrawerItem(
                      icon: Icons.group_outlined,
                      selectedIcon: Icons.group,
                      title: 'Committee Members',
                      onTap: () {},
                      // onTap: () => _navigateTo(ref, AppRoute.committeeMembers),
                    ),
                  ],
                ),

                // Admin section
                if (user.isAdmin) ...[
                  const _SectionHeader(title: 'Admin'),
                  _DrawerSection(
                    items: [
                      _DrawerItem(
                        icon: Icons.admin_panel_settings_outlined,
                        selectedIcon: Icons.admin_panel_settings,
                        title: 'Manage Users',
                        onTap: () {},
                        // onTap: () => _navigateTo(ref, AppRoute.appUsers),
                      ),
                      // _DrawerItem(
                      //   icon: Icons.analytics_outlined,
                      //   selectedIcon: Icons.analytics,
                      //   title: 'Analytics',
                      //   onTap: () => _navigateTo(ref, AppRoute.analytics),
                      // ),
                    ],
                  ),
                ],

                // Settings section
                const _SectionHeader(title: 'Settings & Support'),
                _DrawerSection(
                  items: [
                    _DrawerItem(
                      icon: Icons.settings_outlined,
                      selectedIcon: Icons.settings,
                      title: 'Settings',
                      onTap: () {},
                      // onTap: () => _navigateTo(ref, AppRoute.settings),
                    ),
                    // _DrawerItem(
                    //   icon: Icons.help_outline,
                    //   selectedIcon: Icons.help,
                    //   title: 'Help & Support',
                    //   onTap: () => _navigateTo(ref, AppRoute.support),
                    // ),
                    _DrawerItem(
                      icon: Icons.info_outline,
                      selectedIcon: Icons.info,
                      title: 'About',
                      onTap: () => _showAboutDialog(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildBottomSection(context, ref),
        ],
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(height: 1),
        _ThemeSwitcher(),
        _LogoutButton(onLogout: () => _handleLogout(context, ref)),
      ],
    );
  }

// TODO: remove comments from bellow code
  // void _navigateTo(WidgetRef ref, AppRoute route) {
  //   Navigator.pop(ref.context);
  //   ref.read(appRouterProvider).pushNamed(route.name);
  // }

  void _navigateToProfile(BuildContext context, String userId) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileScreen(),
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context, WidgetRef ref) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      await ref.read(authControllerProvider.notifier).signOut();
    }
  }

  Future<void> _showAboutDialog(BuildContext context) async {
    showAboutDialog(
      context: context,
      applicationName: 'Your App Name',
      applicationVersion: '1.0.0',
      applicationIcon: Image.asset(
        'assets/icon.png',
        width: 50,
        height: 50,
      ),
      children: [
        const Text('Your app description here.'),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => launchUrl(Uri.parse('https://yourapp.com/privacy')),
          child: const Text('Privacy Policy'),
        ),
        TextButton(
          onPressed: () => launchUrl(Uri.parse('https://yourapp.com/terms')),
          child: const Text('Terms of Service'),
        ),
      ],
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  final AppUser user;

  const _DrawerHeader({required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        ),
      ),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          image: user.profileBannerImageURL != null
              ? DecorationImage(
                  image:
                      CachedNetworkImageProvider(user.profileBannerImageURL!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: user.profileImageURL != null
                    ? CachedNetworkImageProvider(user.profileImageURL!)
                    : null,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: user.profileImageURL == null
                    ? Text(
                        user.displayName[0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    : null,
              ),
              const SizedBox(height: 12),
              Text(
                user.displayName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                user.email,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
              if (user.isAdmin)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.admin_panel_settings,
                        size: 16,
                        color: Colors.white,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Admin',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

class _DrawerSection extends StatelessWidget {
  final List<_DrawerItem> items;

  const _DrawerSection({required this.items});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => items[index],
        childCount: items.length,
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String title;
  final VoidCallback onTap;
  final bool selected;
  final Color? textColor;
  final Color? iconColor;

  const _DrawerItem({
    required this.icon,
    required this.selectedIcon,
    required this.title,
    required this.onTap,
    this.selected = false,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveIconColor = iconColor ?? theme.iconTheme.color;
    final effectiveTextColor = textColor ?? theme.textTheme.bodyLarge?.color;

    return ListTile(
      leading: Icon(
        selected ? selectedIcon : icon,
        color: effectiveIconColor,
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: effectiveTextColor,
          fontWeight: selected ? FontWeight.w600 : null,
        ),
      ),
      selected: selected,
      onTap: onTap,
    );
  }
}

class _ThemeSwitcher extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(
            isDarkMode ? Icons.dark_mode : Icons.light_mode,
            size: 20,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Dark Mode',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  isDarkMode ? 'Dark theme enabled' : 'Light theme enabled',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Switch(
            value: isDarkMode,
            onChanged: (value) =>
                ref.read(themeProvider.notifier).toggleTheme(value),
          ),
        ],
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  final VoidCallback onLogout;

  const _LogoutButton({required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton.icon(
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
          ),
          onPressed: onLogout,
          icon: const Icon(Icons.logout),
          label: const Text('Logout'),
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? iconColor;

  const _DrawerTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(color: textColor)),
      onTap: onTap,
    );
  }
}

/// Usage example
// appBar: MainAppBar(
//         title: widget.title,
//         scaffoldKey: _scaffoldKey,
//         actions: widget.actions,
//         isTransparent: widget.isAppBarTransparent,
//       ),
//       drawer: const MainDrawer(),
