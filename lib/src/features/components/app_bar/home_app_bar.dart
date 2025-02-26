// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:social_app_2/src/common_widgets/action_text_button.dart';
// import 'package:social_app_2/src/constants/breakpoints.dart';
// import 'package:social_app_2/src/constants/strings.dart';
// import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';
// import 'package:social_app_2/src/features/components/admin_only/admin_only_widget.dart';
// import 'package:social_app_2/src/features/components/app_bar/more_menu_button.dart';
// import 'package:social_app_2/src/routing/app_router.dart';

// /// Custom [AppBar] widget that is reused by the App
// /// It shows the following actions, depending on the
// /// application state:
// /// - [Admin options]
// /// - [Members List]
// /// - Account or Sign-in button

// class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
//   const HomeAppBar({
//     super.key,
//     required this.title,
//     this.leading,
//     this.actions,
//     this.isAppBarTransparent = false,
//     this.showAddButton = false,
//     this.showEditButton = false,
//     this.showSaveButton = false,
//     this.showButtonBackground = false,
//     this.onPressed,
//     this.onBack,
//   });
//   final String title;
//   final Widget? leading;
//   final List<Widget>? actions;
//   final bool isAppBarTransparent;
//   final bool showAddButton;
//   final bool showEditButton;
//   final bool showSaveButton;
//   final bool showButtonBackground;
//   final VoidCallback? onPressed;
//   final VoidCallback? onBack;

//   @override
//   Size get preferredSize => const Size.fromHeight(60.0);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final user = ref.watch(authControllerProvider).value;
//     // * This widget is responsive.
//     // * On large screen, it shows all the actions in the app bar.
//     // * On small screen, it shows only one action and a more menuButton if required
//     // ! MediaQuery is used on the assumption that the widget
//     // ! takes up the full width of the screen. If that's not
//     // ! case, LayoutBuilder should be used instead
//     final screenWidth = MediaQuery.of(context).size.width;
//     if (screenWidth < Breakpoint.tablet) {
//       return AppBar(
//         automaticallyImplyLeading: !isAppBarTransparent,
//         title: Text(
//           title,
//           style: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         leading: isAppBarTransparent == true
//             ? Container(
//                 margin: const EdgeInsets.all(8.0), // Adjust margin as needed
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.black.withOpacity(0.2),
//                 ),
//                 child: IconButton(
//                   icon: const Icon(
//                     Icons.arrow_back,
//                     color: Colors.white,
//                   ),
//                   onPressed: onBack ?? () => Navigator.of(context).pop(),
//                 ),
//               )
//             : leading,
//         actions: [
//           AdminOnlyWidget(
//             child: _buildActionButtons(
//               context: context,
//               ref: ref,
//             ),
//           ),
//         ],
//       );
//     } else {
//       return AppBar(
//         automaticallyImplyLeading: !isAppBarTransparent,
//         backgroundColor: Colors.transparent,
//         shadowColor: Colors.transparent,
//         foregroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text(
//           title,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         leading: isAppBarTransparent == true
//             ? Container(
//                 margin: const EdgeInsets.all(8.0), // Adjust margin as needed
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.black.withOpacity(0.6),
//                 ),
//                 child: IconButton(
//                   icon: const Icon(
//                     Icons.arrow_back,
//                     color: Colors.white,
//                   ),
//                   onPressed: onBack ?? () => Navigator.of(context).pop(),
//                 ),
//               )
//             : null,
//         actions: [
//           if (user != null) ...[
//             const ActionTextButton(
//               key: MoreMenuButton.membersKey,
//               text: Strings.members,
//               onPressed: null,
//             ),
//             Container(
//               margin: const EdgeInsets.all(8.0), // Adjust margin as needed
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.black.withOpacity(0.6),
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: IconButton(
//                 onPressed: () {},
//                 icon: const Icon(Icons.logout),
//               ),
//             ),
//           ] else
//             Container(
//               margin: const EdgeInsets.all(8.0), // Adjust margin as needed
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.black.withOpacity(0.6),
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: ActionTextButton(
//                 key: MoreMenuButton.signInKey,
//                 text: Strings.signIn,
//                 onPressed: () => context.goNamed(AppRoute.auth.name),
//               ),
//             ),
//         ],
//       );
//     }
//   }

//   Widget _buildActionButtons({
//     required BuildContext context,
//     required WidgetRef ref,
//   }) {
//     return Row(
//       children: [
//         showAddButton == true
//             ? Container(
//                 margin: const EdgeInsets.all(8.0), // Adjust margin as needed
//                 alignment: Alignment.center,
//                 child: IconButton(
//                   onPressed: onPressed,
//                   icon: const Icon(
//                     Icons.add,
//                   ),
//                 ),
//               )
//             : const SizedBox.shrink(),
//         showEditButton == true
//             ? Container(
//                 margin: const EdgeInsets.all(8.0), // Adjust margin as needed
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: isAppBarTransparent
//                       ? Colors.black.withOpacity(0)
//                       : Colors.transparent,
//                 ),
//                 child: IconButton(
//                   onPressed: onPressed,
//                   icon: Icon(Icons.edit,
//                       color: Theme.of(context).colorScheme.onBackground),
//                 ),
//               )
//             : const SizedBox.shrink(),
//         showSaveButton == true
//             ? Container(
//                 margin: const EdgeInsets.all(8.0), // Adjust margin as needed
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: isAppBarTransparent
//                       ? Colors.black.withOpacity(0.6)
//                       : Colors.transparent,
//                 ),
//                 child: IconButton(
//                   onPressed: onPressed,
//                   icon: Icon(
//                     Icons.save,
//                     color: Theme.of(context).colorScheme.onBackground,
//                   ),
//                 ),
//               )
//             : const SizedBox.shrink(),
//       ],
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app_2/src/features/app_users/presentation/app_users_screen.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';
import 'package:social_app_2/src/features/components/admin_only/admin_only_widget.dart';

class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool isTransparent;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final bool showDrawer;
  final bool showBackButton;
  final Widget? customLeading;
  final VoidCallback? onBackPressed;
  final bool showSaveButton;
  final VoidCallback? onSave;
  final bool isSaving;

  const HomeAppBar({
    required this.title,
    this.actions,
    this.isTransparent = false,
    this.scaffoldKey,
    this.showDrawer = true,
    this.showBackButton = false,
    this.customLeading,
    this.onBackPressed,
    this.showSaveButton = false,
    this.onSave,
    this.isSaving = false,
    super.key,
  })  : assert(
          !(showDrawer && showBackButton),
          'Cannot show both drawer and back button',
        ),
        assert(
          !showSaveButton || onSave != null,
          'onSave must be provided when showSaveButton is true',
        );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(currentUserProvider);

    return AppBar(
      backgroundColor: isTransparent
          ? Colors.transparent
          : theme.appBarTheme.backgroundColor,
      elevation: isTransparent ? 0 : null,
      leading: _buildLeading(context, theme, user),
      title: Text(
        title,
        style: TextStyle(
          color: isTransparent ? Colors.white : null,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        if (showSaveButton)
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 8,
            ),
            child: FilledButton.icon(
              onPressed: isSaving ? null : onSave,
              icon: isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : const Icon(Icons.save),
              label: Text(isSaving ? 'Saving...' : 'Save'),
            ),
          ),
        if (actions != null) ...actions!,
        if (!showSaveButton) // Only show admin button if save button is not shown
          AdminOnlyWidget(
            child: IconButton(
              icon: const Icon(Icons.admin_panel_settings),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AppUsersScreen()),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLeading(BuildContext context, ThemeData theme, AppUser? user) {
    if (customLeading != null) return customLeading!;

    Widget? leadingWidget;

    // Show drawer button/profile if drawer is enabled
    if (showDrawer && scaffoldKey != null) {
      leadingWidget = user != null
          ? _buildProfileButton(user, theme)
          : IconButton(
              icon: Icon(
                Icons.menu,
                color: isTransparent ? Colors.white : null,
              ),
              onPressed: () => scaffoldKey?.currentState?.openDrawer(),
            );
    }
    // Show back button if enabled
    else if (showBackButton) {
      leadingWidget = IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: isTransparent ? Colors.white : null,
        ),
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
      );
    }

    // Wrap in container if transparent
    if (isTransparent && leadingWidget != null) {
      return Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.colorScheme.surface.withOpacity(0.5),
        ),
        child: leadingWidget,
      );
    }

    return leadingWidget ?? const SizedBox.shrink();
  }

  Widget _buildProfileButton(AppUser user, ThemeData theme) {
    return InkWell(
      onTap: () => scaffoldKey?.currentState?.openDrawer(),
      customBorder: const CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: CircleAvatar(
          backgroundImage: user.profileImageURL != null
              ? CachedNetworkImageProvider(user.profileImageURL!)
              : null,
          child: user.profileImageURL == null
              ? Text(user.displayName[0].toUpperCase())
              : null,
        ),
      ),
    );
  }
}


/// usage examples
// 1. If a screen has both AppBar and Drawer:
// class MyScreen extends StatefulWidget {
//   @override
//   State<MyScreen> createState() => _MyScreenState();
// }

// class _MyScreenState extends State<MyScreen> {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: MainAppBar(
//         title: 'My Screen',
//         scaffoldKey: _scaffoldKey,
//       ),
//       drawer: const MainDrawer(),
//       body: Container(),
//     );
//   }
// }

// // 2. If a screen has AppBar but NO drawer:
// class NoDrawerScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(  // Use regular AppBar or custom one without drawer
//         title: Text('No Drawer Screen'),
//         leading: BackButton(),
//       ),
//       body: Container(),
//     );
//   }
// }

// // 3. If you want to reuse MainAppBar without drawer:
// class CustomScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MainAppBar(
//         title: 'Custom Screen',
//         scaffoldKey: GlobalKey<ScaffoldState>(),  // Temporary key, drawer won't work
//         onBack: () => Navigator.pop(context),  // Use back button instead
//       ),
//       body: Container(),
//     );
//   }
// }

// // 1. Home screen with drawer
// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: MainAppBar(
//         title: 'Home',
//         scaffoldKey: _scaffoldKey,
//         showDrawer: true,  // Default is true
//       ),
//       drawer: const MainDrawer(),
//       body: Container(),
//     );
//   }
// }

// // 2. Contact list screen
// class ContactListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MainAppBar(
//         title: 'Contacts',
//         showBackButton: true,
//       ),
//       body: ListView.builder(
//         itemBuilder: (context, index) => ListTile(
//           title: Text('Contact $index'),
//           onTap: () => Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => ContactDetailsScreen(
//                 contactId: 'contact_$index',
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // 3. Contact details screen
// class ContactDetailsScreen extends StatelessWidget {
//   final String contactId;

//   const ContactDetailsScreen({
//     required this.contactId,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MainAppBar(
//         title: 'Contact Details',
//         showBackButton: true,
//         isTransparent: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.edit),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.share),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Container(
//         // Contact details UI
//       ),
//     );
//   }
// }

// // 4. Custom leading widget example
// class CustomScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MainAppBar(
//         title: 'Custom',
//         customLeading: IconButton(
//           icon: const Icon(Icons.menu_open),
//           onPressed: () {},
//         ),
//       ),
//       body: Container(),
//     );
//   }
// }