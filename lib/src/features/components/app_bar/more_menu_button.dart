import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/routing/app_router.dart';
import 'package:social_app_2/src/utils/string_hardcoded.dart';

enum PopupMenuOption {
  signIn,
  members,
  account,
  admin,
}

class MoreMenuButton extends StatelessWidget {
  const MoreMenuButton({
    super.key,
    this.user,
    required this.isUserAdmin,
  });
  final AppUser? user;
  final bool isUserAdmin;

  // * Keys for testing using find.byKey()
  static const signInKey = Key('menuSignIn');
  static const membersKey = Key('members');
  static const accountKey = Key('menuAccount');
  static const adminKey = Key('menuAdmin');

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      // three vertical dots icon (to reveal menu options)
      icon: const Icon(Icons.more_vert),
      itemBuilder: (_) {
        // show all the options based on conditional logic
        return <PopupMenuEntry<PopupMenuOption>>[
          if (user != null) ...[
            PopupMenuItem(
              key: membersKey,
              value: PopupMenuOption.members,
              child: Text('Members'.hardcoded),
            ),
            PopupMenuItem(
              key: accountKey,
              value: PopupMenuOption.account,
              child: Text('Account'.hardcoded),
            ),
            if (isUserAdmin)
              PopupMenuItem(
                key: adminKey,
                value: PopupMenuOption.admin,
                child: Text('Admin'.hardcoded),
              ),
          ] else
            PopupMenuItem(
              key: signInKey,
              value: PopupMenuOption.signIn,
              child: Text('Sign In'.hardcoded),
            ),
        ];
      },
      onSelected: (option) {
        // push to different routes based on selected option
        switch (option) {
          case PopupMenuOption.signIn:
            context.goNamed(AppRoute.signIn.name);
          case PopupMenuOption.members:
            context.goNamed(AppRoute.members.name);
          case PopupMenuOption.account:
            context.goNamed(AppRoute.account.name);
          case PopupMenuOption.admin:
            context.goNamed(AppRoute.admin.name);
        }
      },
    );
  }
}
