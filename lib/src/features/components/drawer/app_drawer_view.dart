import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app_2/src/common_widgets/alert_dialog_model.dart';
import 'package:social_app_2/src/common_widgets/async_value_widget.dart';
import 'package:social_app_2/src/common_widgets/divider_with_text.dart';
import 'package:social_app_2/src/constants/strings.dart';
import 'package:social_app_2/src/features/auth/data/app_user_storage_service.dart';
import 'package:social_app_2/src/features/auth/data/auth_repository.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/typedefs/user_id.dart';
import 'package:social_app_2/src/features/components/admin_only/admin_only_widget.dart';
import 'package:social_app_2/src/features/components/dialogs/logout_dialog.dart';
import 'package:social_app_2/src/features/components/image/custom_circular_avatar.dart';
import 'package:social_app_2/src/routing/app_router.dart';
import 'package:social_app_2/src/theme/app_colors.dart';
import 'package:social_app_2/src/theme/theme_provider.dart';

class AppDrawerView extends ConsumerWidget {
  const AppDrawerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserID = ref.watch(authRepositoryProvider).currentUser?.id;
    if (currentUserID == null) {
      return const SizedBox.shrink(); // Or some error widget
    }

    final currentUser = ref.watch(appUserFutureProvider(currentUserID));
    final isCurrentUserApproved =
        ref.watch(isUserApprovedProvider(currentUserID));

    return Drawer(
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          _buildUserInfo(
            context: context,
            ref: ref,
            userID: currentUserID,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // _buildUserInfo(
                  //     context: context, ref: ref, userID: currentUserID),
                  _buildDrawerItems(
                    context,
                    ref,
                    currentUser.value,
                    isCurrentUserApproved.value,
                  ),
                ],
              ),
            ),
          ),
          const DividerWithText(
            text: "APPEARANCE",
          ),
          _buildThemeSwitcher(context: context, ref: ref),
        ],
      ),
    );
  }

  Widget _buildUserInfo({
    required BuildContext context,
    required WidgetRef ref,
    required UserID userID,
  }) {
    return AsyncValueWidget(
      value: ref.watch(appUserFutureProvider(userID)),
      data: (user) => _UserInfoHeader(user: user),
    );
  }

  Widget _buildThemeSwitcher(
      {required BuildContext context, required WidgetRef ref}) {
    final themeNotifier = ref.read(themeProvider.notifier);
    return ListTile(
      title: Text(
        "Dark Mode",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary),
      ),
      trailing: CupertinoSwitch(
        value: themeNotifier.isDarkMode,
        onChanged: (value) {
          themeNotifier.toggleTheme(value);
        },
      ),
    );
  }

  Widget _buildDrawerItems(BuildContext context, WidgetRef ref,
      AppUser? currentUser, bool? isCurrentUserApproved) {
    return Column(
      children: [
        _DrawerItem(
          icon: FontAwesomeIcons.userTie,
          title: Strings.committee,
          onTap: () => _navigateTo(ref, AppRoute.committeeMembers),
        ),
        AdminOnlyWidget(
          child: _DrawerItem(
            icon: FontAwesomeIcons.userGroup,
            title: Strings.appUsers,
            onTap: () => _navigateTo(ref, AppRoute.appUsers),
          ),
        ),
        _DrawerItem(
          icon: FontAwesomeIcons.arrowRightFromBracket,
          title: 'Log out',
          onTap: () => _handleLogout(context, ref),
        ),
      ],
    );
  }

  void _navigateTo(WidgetRef ref, AppRoute route) {
    ref.read(goRouterProvider).pop();
    ref.read(goRouterProvider).pushNamed(route.name);
  }

  Future<void> _handleLogout(BuildContext context, WidgetRef ref) async {
    // final navigator = Navigator.of(context);
    final shouldLogout = await const LogoutDialog()
        .present(context)
        .then((value) => value ?? false);
    if (shouldLogout) {
      await ref.read(authRepositoryProvider).signOut();
    }
    // navigator.pop();
  }
}

class _UserInfoHeader extends ConsumerWidget {
  final AppUser? user;

  const _UserInfoHeader({super.key, this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (user == null) {
      return const SizedBox.shrink(); // Or some placeholder widget
    }

    final isProfileBannerImageURLAvailable =
        user!.profileBannerImageURL != null &&
            user!.profileBannerImageURL!.isNotEmpty;
    final isPhotoURLAvailable =
        user!.photoURL != null && user!.photoURL!.isNotEmpty;

    // final _themeProvider = ref.watch(themeProvider);

    return InkWell(
      onTap: () => _navigateToUserAccount(ref),
      child: Container(
        height: 200,
        color:
            Theme.of(context).colorScheme.primary, // Fallback background color
        child: Stack(
          children: [
            // Background image
            if (isProfileBannerImageURLAvailable)
              CachedNetworkImage(
                imageUrl: user!.profileBannerImageURL!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200, // Adjust this value as needed
              ),
            // // Theme switch
            // Positioned(
            //   top: 16,
            //   right: 16,
            //   child: GestureDetector(
            //     onTap: () {
            //       final themeNotifier = ref.read(themeProvider.notifier);
            //       themeNotifier.toggleTheme(!themeNotifier.isDarkMode);
            //     },
            //     child: Container(
            //       padding: const EdgeInsets.all(
            //           8), // This creates a larger tappable area
            //       color: Colors.transparent, // Makes the container invisible
            //       child: AbsorbPointer(
            //         child: CupertinoSwitch(
            //           value: ref.watch(themeProvider) == ThemeMode.dark,
            //           onChanged: (_) {},
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // GestureDetector(
            //   child: Positioned(
            //     top: 8,
            //     right: 8,
            //     child: AbsorbPointer(
            //       absorbing: false,
            //       child: CupertinoSwitch(
            //         value: themeNotifier.isDarkMode,
            //         onChanged: (value) {
            //           themeNotifier.toggleTheme(value);
            //         },
            //       ),
            //     ),
            //   ),
            // ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.kcBlackColor.withOpacity(0.7),
                    // Theme.of(context).colorScheme.background.withOpacity(0.1),
                    // Theme.of(context).colorScheme.background.withOpacity(0.8),
                  ],
                ),
              ),
            ),
            // User info
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (isPhotoURLAvailable)
                      CustomCircularAvatar(
                        imageUrl: user!.photoURL,
                        radius: 40,
                      )
                    else
                      CircleAvatar(
                        radius: 40,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        child: Text(
                          user!.displayName?.isNotEmpty == true
                              ? user!.displayName![0].toUpperCase()
                              : '?',
                          style: TextStyle(
                            fontSize: 32,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    _buildOverlayText(
                      context,
                      user!.displayName ?? '',
                      Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    _buildOverlayText(
                      context,
                      user!.email,
                      Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOverlayText(
      BuildContext context, String text, TextStyle? style) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.shadow.withOpacity(0.0),
            Theme.of(context).colorScheme.shadow.withOpacity(0.4),
            Theme.of(context).colorScheme.shadow.withOpacity(0.0),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Text(
        text,
        style: style?.copyWith(
          color: AppColors.kcWhiteColor,
          shadows: [
            Shadow(
              blurRadius: 2,
              color: Theme.of(context).colorScheme.background.withOpacity(0.5),
              offset: const Offset(1, 1),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToUserAccount(WidgetRef ref) {
    ref.read(goRouterProvider).pop();
    ref.read(goRouterProvider).pushNamed(
      AppRoute.account.name,
      pathParameters: {'id': user!.id},
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
