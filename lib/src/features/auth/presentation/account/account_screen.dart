import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:social_app_2/src/common_widgets/alert_dialog_model.dart';
import 'package:social_app_2/src/common_widgets/alert_dialogs.dart';
import 'package:social_app_2/src/common_widgets/async_value_widget.dart';
import 'package:social_app_2/src/common_widgets/custom_image.dart';
import 'package:social_app_2/src/common_widgets/delete_button.dart';
import 'package:social_app_2/src/common_widgets/delete_dialog.dart';
import 'package:social_app_2/src/common_widgets/empty_placeholder_widget.dart';
import 'package:social_app_2/src/common_widgets/responsive_center.dart';
import 'package:social_app_2/src/common_widgets/responsive_two_colum_layout.dart';
import 'package:social_app_2/src/constants/app_sizes.dart';
import 'package:social_app_2/src/constants/strings.dart';
import 'package:social_app_2/src/extensions/async_value_ui.dart';
import 'package:social_app_2/src/features/auth/data/app_user_storage_service.dart';
import 'package:social_app_2/src/features/auth/data/auth_repository.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/presentation/account/account_screen_controller.dart';
import 'package:social_app_2/src/features/auth/presentation/account/email_password_input_dialog.dart';
import 'package:social_app_2/src/routing/app_router.dart';
import 'package:social_app_2/src/utils/string_hardcoded.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      accountScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(accountScreenControllerProvider);
    final currentUserId = ref.watch(authRepositoryProvider).currentUser?.id;
    return Scaffold(
      appBar: AppBar(
        title: state.isLoading
            ? const CircularProgressIndicator()
            : Text('Account'.hardcoded),
        actions: [
          IconButton(
            onPressed: () => context.goNamed(
              AppRoute.editAccount.name,
              pathParameters: {'userId': currentUserId!},
            ),
            icon: const Icon(
              Icons.edit,
            ),
          ),
          IconButton(
            onPressed: state.isLoading
                ? null
                : () async {
                    final logout = await showAlertDialog(
                      context: context,
                      title: 'Are you sure?'.hardcoded,
                      cancelActionText: 'Cancel'.hardcoded,
                      defaultActionText: 'Logout'.hardcoded,
                    );
                    if (logout == true) {
                      ref
                          .read(accountScreenControllerProvider.notifier)
                          .signOut();
                    }
                  },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const ResponsiveCenter(
        padding: EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: AccountScreenContents(),
      ),
    );
  }
}

// Show user data here
class AccountScreenContents extends ConsumerStatefulWidget {
  const AccountScreenContents({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AccountScreenContentsState();
}

class _AccountScreenContentsState extends ConsumerState<AccountScreenContents> {
  final log = Logger();

  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _reauthenticateAndDeleteUser({
    required AppUser appUser,
  }) async {
    final controller = ref.read(accountScreenControllerProvider.notifier);

    final shouldDelete =
        await const DeleteDialog(titleOfObjectToDelete: Strings.account)
            .present(context)
            .then((shouldDelete) => shouldDelete ?? false);

    if (shouldDelete) {
      if (appUser.providerId == 'google.com') {
        // get password from user and send it to controller to get user credential with current user's email
        log.i('GET PASSWORD FROM GOOGLE.COM');
        final credential = await controller.getUserCredentialFromGoogle();
        if (!mounted) return;
        if (credential != null) {
          final canDelete =
              await const DeleteDialog(titleOfObjectToDelete: Strings.account)
                  .present(context)
                  .then((shouldDelete) => shouldDelete ?? false);
          log.i('Deleting user');
          if (canDelete == true) {
            await controller.deleteUser(
              credential: credential,
              userId: appUser.id,
            );
            await controller.signOut();
            // go back to main screen
            // context.goNamed(AppRoute.news.name);
          }
        }
      } else if (appUser.providerId == 'apple.com') {
        // get credential from apple
        log.i('GET CREDENTIAL FROM APPLE.COM');
        final credential = await controller.getUserCredentialFromApple();
        if (!mounted) return;
        if (credential != null) {
          final canDelete =
              await const DeleteDialog(titleOfObjectToDelete: Strings.account)
                  .present(context)
                  .then((shouldDelete) => shouldDelete ?? false);
          log.i('Deleting user');
          if (canDelete == true) {
            await controller.deleteUser(
              credential: credential,
              userId: appUser.id,
            );
            await controller.signOut();
            // go back to main screen
            // context.goNamed(AppRoute.news.name);
          }
        }
      } else {
        // get password from user and send it to controller to get user credential with current user's email
        log.i('GET EMAIL & PASSWORD FROM USER');
        if (!mounted) return;
        final didSubmitUserCredential = await emailPasswordInputDialog(
              context: context,
              title: Strings.reauthenticateAccount,
              cancelActionText: 'Cancel',
              canSubmitPassword: true,
              emailController: _emailController,
              passwordController: _passwordController,
            ) ??
            false;

        if (didSubmitUserCredential) {
          log.i('User credential received');
          final credential = await controller.getUserCredentialFromFirebase(
            email: _emailController.text,
            password: _passwordController.text,
          );
          if (credential != null) {
            if (!mounted) return;
            final canDelete =
                await const DeleteDialog(titleOfObjectToDelete: Strings.account)
                    .present(context)
                    .then((shouldDelete) => shouldDelete ?? false);
            if (canDelete == true) {
              log.i('DELETING CURRENT USER');
              await controller.deleteUser(
                credential: credential,
                userId: appUser.id,
              );
              await controller.signOut();
              // go back to main screen
              // context.goNamed(AppRoute.news.name);
              // await controller.signOut();
              // if (mounted) {
              //   Navigator.of(context).pop();
              //   Navigator.of(context).pop();
              // }
            }
          }
        } else {
          log.i('User did not submit email and password');
        }
      }
    } else {
      log.i("User do not want to delete account ");
    }
  }
  // Future<void> _delete() async {
  //   final delete = await showAlertDialog(
  //     context: context,
  //     title: 'Are you sure?'.hardcoded,
  //     cancelActionText: 'Cancel'.hardcoded,
  //     defaultActionText: 'Delete'.hardcoded,
  //   );
  //   if (delete == true) {
  //     ref.read(editAccountScreenControllerProvider.notifier).deleteUser(user);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final signedInUser = ref.watch(authRepositoryProvider).currentUser;
    if (signedInUser == null) {
      return const SizedBox.shrink();
    }
    final currentUser = ref.watch(appUserStreamProvider(signedInUser.id));
    final state = ref.watch(accountScreenControllerProvider);
    return AsyncValueWidget<AppUser?>(
      value: currentUser,
      data: (user) => user == null
          ? EmptyPlaceholderWidget(
              message: 'User details not found'.hardcoded,
            )
          : CustomScrollView(
              slivers: [
                ResponsiveSliverCenter(
                  padding: const EdgeInsets.all(Sizes.p16),
                  child: UserDetails(user: user),
                ),
                ResponsiveSliverCenter(
                  child: DeleteButton(
                    text: Strings.deleteAccount,
                    onPressed: state.isLoading
                        ? null
                        : () => _reauthenticateAndDeleteUser(appUser: user),
                  ),
                ),
              ],
            ),
    );
  }
}

class UserDetails extends ConsumerWidget {
  final AppUser user;
  const UserDetails({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageUrl = user.photoURL ?? 'assets/images/stock/superman_03.png';

    return ResponsiveTwoColumnLayout(
      startContent: Card(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p8),
          child: CustomImage(imageUrl: imageUrl),
        ),
      ),
      spacing: Sizes.p16,
      endContent: Card(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              gapH16,
              Text(
                user.displayName ?? '',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              gapH8,
              Text(
                user.email,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              gapH16,
              Row(
                children: [
                  Text(
                    'Phone:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${user.phoneNumber}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              gapH16,
              Row(
                children: [
                  Text(
                    'isAdmin:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${user.isAdmin}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'isApproved:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${user.isApproved}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'isVerified:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${user.isEmailVerified}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'isInfoShared:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${user.isInfoShared}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              gapH16,
              Visibility(
                visible: user.street != null && user.street!.isNotEmpty,
                child: Row(
                  children: [
                    const Icon(
                      Icons.directions,
                      size: 50,
                    ),
                    gapW16,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text('${user.street}'),
                        Row(
                          children: [
                            Text('${user.city}'),
                            Text(', ${user.state}'),
                            Text(' - ${user.zip}'),
                          ],
                        ),
                      ],
                    )
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

// class EmailVerificationWidget extends ConsumerWidget {
//   const EmailVerificationWidget({super.key, required this.user});
//   final AppUser user;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(accountScreenControllerProvider);
//     if (user.emailVerified == false) {
//       return Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           OutlinedButton(
//             onPressed: state.isLoading
//                 ? null
//                 : () async {
//                     final success = await ref
//                         .read(accountScreenControllerProvider.notifier)
//                         .sendEmailVerification(user);
//                     if (success && context.mounted) {
//                       showAlertDialog(
//                         context: context,
//                         title: 'Sent - now check your email'.hardcoded,
//                       );
//                     }
//                   },
//             child: Text(
//               'Verify email'.hardcoded,
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//           ),
//         ],
//       );
//     } else {
//       return Row(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             'Verified'.hardcoded,
//             style: Theme.of(context)
//                 .textTheme
//                 .titleMedium!
//                 .copyWith(color: Colors.green.shade700),
//           ),
//           gapW8,
//           Icon(Icons.check_circle, color: Colors.green.shade700),
//         ],
//       );
//     }
//   }
// }
