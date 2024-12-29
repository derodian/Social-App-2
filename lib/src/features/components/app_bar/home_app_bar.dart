import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app_2/src/common_widgets/action_text_button.dart';
import 'package:social_app_2/src/constants/breakpoints.dart';
import 'package:social_app_2/src/constants/strings.dart';
import 'package:social_app_2/src/features/auth/data/auth_repository.dart';
import 'package:social_app_2/src/features/components/admin_only/admin_only_widget.dart';
import 'package:social_app_2/src/features/components/app_bar/more_menu_button.dart';
import 'package:social_app_2/src/routing/app_router.dart';

/// Custom [AppBar] widget that is reused by the App
/// It shows the following actions, depending on the
/// application state:
/// - [Admin options]
/// - [Members List]
/// - Account or Sign-in button

class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.isAppBarTransparent = false,
    this.showAddButton = false,
    this.showEditButton = false,
    this.showSaveButton = false,
    this.showButtonBackground = false,
    this.onPressed,
    this.onBack,
  });
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool isAppBarTransparent;
  final bool showAddButton;
  final bool showEditButton;
  final bool showSaveButton;
  final bool showButtonBackground;
  final VoidCallback? onPressed;
  final VoidCallback? onBack;

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesProvider).value;
    // * This widget is responsive.
    // * On large screen, it shows all the actions in the app bar.
    // * On small screen, it shows only one action and a more menuButton if required
    // ! MediaQuery is used on the assumption that the widget
    // ! takes up the full width of the screen. If that's not
    // ! case, LayoutBuilder should be used instead
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < Breakpoint.tablet) {
      return AppBar(
        automaticallyImplyLeading: !isAppBarTransparent,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: isAppBarTransparent == true
            ? Container(
                margin: const EdgeInsets.all(8.0), // Adjust margin as needed
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.2),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: onBack ?? () => Navigator.of(context).pop(),
                ),
              )
            : leading,
        actions: [
          AdminOnlyWidget(
            child: _buildActionButtons(
              context: context,
              ref: ref,
            ),
          ),
        ],
      );
    } else {
      return AppBar(
        automaticallyImplyLeading: !isAppBarTransparent,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: isAppBarTransparent == true
            ? Container(
                margin: const EdgeInsets.all(8.0), // Adjust margin as needed
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.6),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: onBack ?? () => Navigator.of(context).pop(),
                ),
              )
            : null,
        actions: [
          if (user != null) ...[
            const ActionTextButton(
              key: MoreMenuButton.membersKey,
              text: Strings.members,
              onPressed: null,
            ),
            Container(
              margin: const EdgeInsets.all(8.0), // Adjust margin as needed
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.logout),
              ),
            ),
          ] else
            Container(
              margin: const EdgeInsets.all(8.0), // Adjust margin as needed
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ActionTextButton(
                key: MoreMenuButton.signInKey,
                text: Strings.signIn,
                onPressed: () => context.goNamed(AppRoute.signIn.name),
              ),
            ),
        ],
      );
    }
  }

  Widget _buildActionButtons({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    return Row(
      children: [
        showAddButton == true
            ? Container(
                margin: const EdgeInsets.all(8.0), // Adjust margin as needed
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: onPressed,
                  icon: const Icon(
                    Icons.add,
                  ),
                ),
              )
            : const SizedBox.shrink(),
        showEditButton == true
            ? Container(
                margin: const EdgeInsets.all(8.0), // Adjust margin as needed
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isAppBarTransparent
                      ? Colors.black.withOpacity(0)
                      : Colors.transparent,
                ),
                child: IconButton(
                  onPressed: onPressed,
                  icon: Icon(Icons.edit,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              )
            : const SizedBox.shrink(),
        showSaveButton == true
            ? Container(
                margin: const EdgeInsets.all(8.0), // Adjust margin as needed
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isAppBarTransparent
                      ? Colors.black.withOpacity(0.6)
                      : Colors.transparent,
                ),
                child: IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    Icons.save,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
