import 'dart:async';
import 'dart:io' show Platform;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app_2/src/common_widgets/async_value_mixin.dart';
import 'package:social_app_2/src/common_widgets/async_value_widget.dart';
import 'package:social_app_2/src/common_widgets/combined_async_value_widget.dart';
import 'package:social_app_2/src/common_widgets/custom_icon_button.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/presentation/account/edit_profile_screen.dart';
import 'package:social_app_2/src/features/auth/presentation/account/email_reauthentication_dialog.dart';
import 'package:social_app_2/src/features/auth/presentation/account/profile_controller.dart';
import 'package:social_app_2/src/features/auth/presentation/account/profile_settings_button.dart';
import 'package:social_app_2/src/features/auth/presentation/auth/auth_controller.dart';
import 'package:social_app_2/src/features/auth/presentation/widgets/circular_profile_image.dart';
import 'package:social_app_2/src/features/auth/presentation/widgets/info_row_widget.dart';
import 'package:social_app_2/src/features/services/snackbar_service.dart';
import 'package:social_app_2/src/utils/url_launcher_utils.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with AsyncValueMixin<ProfileScreen> {
  // Future<void> _handleDeleteAccount() async {
  //   try {
  //     // First confirmation
  //     final confirmed = await _showDeleteConfirmationDialog();
  //     if (!mounted || !confirmed) return;

  //     // Get current user and their auth provider
  //     final user = ref.read(authControllerProvider).value;
  //     if (user == null) return;

  //     // Set deletion state to true
  //     ref.read(deletionStateProvider.notifier).setDeleting(true);

  //     if (!mounted) return;

  //     // Show loading dialog
  //     BuildContext? loadingDialogContext;
  //     showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (dialogContext) {
  //         loadingDialogContext = dialogContext;
  //         return const AlertDialog(
  //           content: Row(
  //             children: [
  //               CircularProgressIndicator(),
  //               SizedBox(width: 16),
  //               Text('Deleting account...'),
  //             ],
  //           ),
  //         );
  //       },
  //     );

  //     try {
  //       // Handle reauthentication based on provider
  //       bool reauthed = false;
  //       if (user.provider == AppAuthProvider.email) {
  //         reauthed = await EmailReauthenticationDialog.show(
  //           context,
  //           email: user.email,
  //           onSubmit: (password) => _handlePasswordSubmission(password),
  //         );
  //       } else {
  //         reauthed = await _showProviderReauthenticationDialog(user.provider);
  //       }

  //       // Check mounted state and reauthentication result
  //       if (!mounted || !reauthed) {
  //         // Clean up if needed
  //         if (loadingDialogContext?.mounted ?? false) {
  //           Navigator.of(loadingDialogContext!).pop();
  //         }
  //         ref.read(deletionStateProvider.notifier).setDeleting(false);
  //         return;
  //       }

  //       debugPrint('Reauthentication successful, proceeding with deletion');

  //       // Proceed with deletion
  //       await ref.read(authControllerProvider.notifier).deleteAccount();
  //       debugPrint('Account deletion completed');

  //       // // Handle successful deletion
  //       // if (mounted) {
  //       //   if (loadingDialogContext?.mounted ?? false) {
  //       //     Navigator.of(loadingDialogContext!).pop();
  //       //   }
  //       //   Navigator.of(context).pop(); // Return to previous screen
  //       // }
  //     } finally {
  //       // Always reset deletion state
  //       // ref.read(deletionStateProvider.notifier).setDeleting(false);
  //       // Always clean up
  //       if (loadingDialogContext?.mounted ?? false) {
  //         Navigator.of(loadingDialogContext!).pop();
  //       }
  //       ref.read(deletionStateProvider.notifier).setDeleting(false);
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (mounted) {
  //       ref
  //           .read(snackBarControllerProvider.notifier)
  //           .showError(_getErrorMessage(e));
  //     }
  //   } catch (e) {
  //     if (!mounted) return;
  //     ref
  //         .read(snackBarControllerProvider.notifier)
  //         .showError('Failed to delete account: $e');
  //   }
  // }

  Future<void> _handleDeleteAccount() async {
    late bool isDeletingState = false; // Track state locally

    try {
      debugPrint('Starting delete account process');
      // First confirmation
      final confirmed = await _showDeleteConfirmationDialog();
      if (!mounted || !confirmed) {
        debugPrint('Delete confirmation cancelled or widget unmounted');
        return;
      }

      // Get current user and their auth provider
      final user = ref.read(authControllerProvider).value;
      if (user == null) {
        debugPrint('No user found');
        return;
      }
      debugPrint('Got user: ${user.id}');

      // Store refs before async operations
      final deletionStateNotifier = ref.read(deletionStateProvider.notifier);
      final authControllerNotifier = ref.read(authControllerProvider.notifier);

      // Handle reauthentication
      debugPrint('Starting reauthentication');
      bool reauthed = false;
      if (user.provider == AppAuthProvider.email) {
        reauthed = await EmailReauthenticationDialog.show(
          context,
          email: user.email,
          onSubmit: (password) => _handlePasswordSubmission(password),
        );
      }

      debugPrint('Reauthentication result: $reauthed');
      // If reauthentication failed or widget is disposed, return
      if (!mounted || !reauthed) {
        debugPrint('Reauthentication failed or widget unmounted');
        return;
      }

      debugPrint('Setting deletion state and showing loading dialog');
      // Set deletion state and show loading dialog
      isDeletingState = true;
      deletionStateNotifier.setDeleting(true);

      debugPrint('About to call deleteAccount');
      authControllerNotifier.deleteAccount();
      debugPrint('Delete account completed successfully');

      if (mounted) {
        debugPrint('Popping navigation');
        Navigator.of(context).pop();
      }

      // finally {
      //   debugPrint('In finally block, cleaning up');
      //   deletionStateNotifier.setDeleting(false);
      // }
    } catch (e) {
      debugPrint('Error during deletion process: $e');
      ref
          .read(snackBarControllerProvider.notifier)
          .showError('Failed to delete account: $e');
    } finally {
      // Only clean up if we set the state
      if (isDeletingState) {
        debugPrint('In finally block, cleaning up deletion state');
        try {
          // Get a fresh ref only if widget is still mounted
          if (mounted) {
            ref.read(deletionStateProvider.notifier).setDeleting(false);
          }
        } catch (e) {
          debugPrint('Error cleaning up deletion state: $e');
        }
      }
    }
  }

  String _getErrorMessage(FirebaseAuthException e) {
    return switch (e.code) {
      'requires-recent-login' => 'Please sign in again to delete your account',
      'user-not-found' => 'Account not found',
      'network-request-failed' => 'Network error. Please try again',
      _ => 'Error: ${e.message ?? 'Unknown error occurred'}',
    };
  }

  Future<bool> _showDeleteConfirmationDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Account'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Are you sure you want to delete your account? This action:',
                ),
                const SizedBox(height: 16),
                ...[
                  'Cannot be undone',
                  'Will delete all your data',
                  'Will end all your sessions'
                ].map((text) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          const Icon(Icons.warning,
                              color: Colors.orange, size: 20),
                          const SizedBox(width: 8),
                          Expanded(child: Text(text)),
                        ],
                      ),
                    )),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
                child: const Text('Delete Account'),
              ),
            ],
          ),
        ) ??
        false;
  }

  // Future<bool> _handlePasswordSubmission(String password) async {
  //   if (!mounted) return false;

  //   try {
  //     await ref
  //         .read(authControllerProvider.notifier)
  //         .reauthenticateWithPassword(
  //           email: ref.read(authControllerProvider).value!.email,
  //           password: password,
  //         );
  //     debugPrint('Password authentication successful');
  //     return true;
  //   } on FirebaseAuthException catch (e) {
  //     debugPrint('Password authentication failed: $e');
  //     String errorMessage = switch (e.code) {
  //       'wrong-password' => 'Incorrect password. Please try again.',
  //       'too-many-requests' => 'Too many attempts. Please try again later.',
  //       'user-mismatch' => 'Authentication failed. Please try again.',
  //       _ => 'Authentication failed: ${e.message}',
  //     };
  //     // Use global SnackBarService
  //     ref.read(snackBarControllerProvider.notifier).showError(errorMessage);
  //     rethrow;
  //   } catch (e) {
  //     debugPrint('Password authentication failed: $e');
  //     // Use global SnackBarService
  //     ref
  //         .read(snackBarControllerProvider.notifier)
  //         .showError('Authentication failed: $e');
  //     return false;
  //   }
  // }

  Future<bool> _handlePasswordSubmission(String password) async {
    debugPrint('Starting password submission');
    if (!mounted) {
      debugPrint('Widget not mounted during password submission');
      return false;
    }

    try {
      debugPrint('Attempting reauthentication');
      final result = await ref
          .read(authControllerProvider.notifier)
          .reauthenticateWithPassword(
            email: ref.read(authControllerProvider).value!.email,
            password: password,
          );
      debugPrint('Password authentication successful');
      return result;
    } catch (e) {
      debugPrint('Password authentication failed: $e');
      ref
          .read(snackBarControllerProvider.notifier)
          .showError('Authentication failed: $e');
      return false;
    }
  }

// Update other error handling in the file to use SnackBarService
  Future<void> _handleLinkProvider(AppAuthProvider provider) async {
    try {
      await ref.read(authControllerProvider.notifier).linkProvider(provider);
      if (!mounted) return;
      ref.read(snackBarControllerProvider.notifier).showSuccess(
            'Successfully linked ${_getProviderName(provider)}',
          );
    } catch (e) {
      ref.read(snackBarControllerProvider.notifier).showError(e.toString());
    }
  }

  Future<void> _handleUnlinkProvider(AppAuthProvider provider) async {
    try {
      await ref.read(authControllerProvider.notifier).unlinkProvider(provider);
      if (!mounted) return;
      ref.read(snackBarControllerProvider.notifier).showSuccess(
            'Successfully unlinked ${_getProviderName(provider)}',
          );
    } catch (e) {
      ref.read(snackBarControllerProvider.notifier).showError(e.toString());
    }
  }

  Future<bool> _showProviderReauthenticationDialog(
      AppAuthProvider provider) async {
    debugPrint('Starting reauthentication dialog');
    bool isAuthenticated = false;
    final completer = Completer<bool>();

    // Prevent router from redirecting during reauthentication
    ref.read(authControllerProvider.notifier).clearError();

    debugPrint('About to show dialog');
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        debugPrint('Building dialog');
        return AlertDialog(
          title: const Text('Confirm Your Identity'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Please confirm your identity using ${_getProviderName(provider)} to delete your account.',
              ),
              const SizedBox(height: 16),
              StatefulBuilder(builder: (context, setState) {
                return ElevatedButton.icon(
                  onPressed: () async {
                    debugPrint('Authentication button pressed');

                    try {
                      debugPrint('Starting reauthentication');
                      // Show loading in button
                      setState(() {});

                      await ref
                          .read(authControllerProvider.notifier)
                          .reauthenticateWithProvider(provider);

                      debugPrint('Reauthentication successful');
                      isAuthenticated = true;

                      debugPrint(
                          'Checking dialog context mounted: ${dialogContext.mounted}');
                      // if (dialogContext.mounted) {
                      //   debugPrint('Closing dialog with success');
                      //   Navigator.of(dialogContext).pop();
                      // }

                      if (!dialogContext.mounted) {
                        completer.complete(true);
                        return;
                      }

                      Navigator.of(dialogContext).pop();
                      completer.complete(true);
                    } catch (e) {
                      debugPrint('Reauthentication failed: $e');
                      if (dialogContext.mounted) {
                        debugPrint('Closing dialog with failure');
                        Navigator.of(dialogContext).pop();
                      }
                      ref
                          .read(snackBarControllerProvider.notifier)
                          .showError('Authentication failed: $e');
                      completer.complete(false);
                    }
                    // finally {
                    //   debugPrint('Completing authentication process');
                    //   completer.complete();
                    // }
                  },
                  icon: FaIcon(_getProviderIcon(provider)),
                  label: Text('Continue with ${_getProviderName(provider)}'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _getProviderColor(provider),
                    foregroundColor: Colors.white,
                  ),
                );
              }),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                debugPrint('Cancel button pressed');
                Navigator.of(dialogContext).pop();
                completer.complete(false);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );

    debugPrint('Waiting for authentication to complete');
    debugPrint('Returning authentication result: ${completer.future}');
    return await completer.future;
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileControllerProvider);
    final authState = ref.watch(authControllerProvider);

    return CombinedAsyncValue(
      values: [profileState, authState],
      child: Scaffold(
        body: ScaffoldAsyncValueWidget(
          value: profileState,
          data: (user) => CustomScrollView(
            slivers: [
              _buildAppBar(user!),
              SliverToBoxAdapter(
                child: Transform.translate(
                  offset: const Offset(0, 0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        _buildProfileHeader(user),
                        const SizedBox(height: 24),
                        _buildInfoCard(user),
                        const SizedBox(height: 16),
                        _buildStatusCard(user),
                        const SizedBox(height: 24),
                        const Divider(),
                        // Authentication providers section
                        const SizedBox(height: 24),
                        Text(
                          'Connected Accounts',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        ...user.linkedProviders.map((provider) {
                          final authProvider =
                              AppAuthProvider.values.firstWhere(
                            (e) => e.name == provider,
                            orElse: () => AppAuthProvider.email,
                          );
                          return ListTile(
                            leading: FaIcon(
                              _getProviderIcon(authProvider),
                              size: 20,
                              color: _getProviderColor(authProvider),
                            ),
                            title: Text(_getProviderName(authProvider)),
                            trailing: user.linkedProviders.length > 1
                                ? IconButton(
                                    icon: const Icon(Icons.link_off),
                                    onPressed: () =>
                                        _handleUnlinkProvider(authProvider),
                                    tooltip: 'Unlink account',
                                  )
                                : null,
                          );
                        }),
                        // Add new provider section
                        if (_getAvailableProviders(user).isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Text(
                            'Add Account',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          ..._getAvailableProviders(user).map((provider) {
                            return ListTile(
                              leading: FaIcon(
                                _getProviderIcon(provider),
                                size: 20,
                                color: _getProviderColor(provider),
                              ),
                              title: Text('Add ${_getProviderName(provider)}'),
                              onTap: () => _handleLinkProvider(provider),
                            );
                          }),
                        ],

                        const SizedBox(height: 24),
                        const Divider(),
                        _buildDangerZone(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(AppUser user) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: Stack(
        clipBehavior: Clip.none,
        children: [
          FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                if (user.profileBannerImageURL != null)
                  CachedNetworkImage(
                    imageUrl: user.profileBannerImageURL!,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        _buildGradientBackground(context),
                  )
                else
                  _buildGradientBackground(context),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black45, Colors.transparent],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Position the profile image at the bottom center of the app bar
          Positioned(
            bottom: -50,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProfileImage(
                imageUrl: user.profileImageURL,
                radius: 75,
                borderWidth: 3,
                borderColor: Colors.white,
                shimmerBaseColor: Colors.grey[300],
                shimmerHighlightColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
      leading: CustomIconButton(
        icon: Icons.arrow_back,
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        const ProfileSettingsButton(),
        CustomIconButton(
          icon: Icons.edit,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => EditProfileScreen(user: user),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildGradientBackground(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.7),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(AppUser user) {
    return Column(
      children: [
        const SizedBox(height: 60),
        Text(
          user.displayName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => context.launchEmail(user.email),
          child: Text(
            user.email,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).primaryColor,
                  decoration: TextDecoration.underline,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(AppUser user) {
    late String address = '';
    if (user.street != null && user.street!.isNotEmpty) {
      address =
          '${user.street}, ${user.city}, ${user.addressState} - ${user.zip}/n${user.country}';
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            InfoRow(
              icon: Icons.phone,
              label: 'Phone',
              value: user.phoneNumber,
              onTap: () => context.launchPhone(user.phoneNumber!),
            ),
            InfoRow(
              icon: Icons.location_on,
              label: 'Address',
              value: address,
              type: InfoType.address,
              onTap: () => context.launchMap(address),
              showDistance: true,
            ),
            InfoRow(
              icon: Icons.email,
              label: 'Email',
              value: user.email,
              onTap: () => context.launchEmail(user.email),
            ),
            InfoRow(
              icon: Icons.calendar_today,
              label: 'Member Since',
              type: InfoType.date,
              value: user.createDate.toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(AppUser user) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Account Status',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            _buildStatusRow(
              'Email Verified',
              user.isEmailVerified,
            ),
            _buildStatusRow(
              'Admin Approved',
              user.isAdmin,
            ),
            if (user.isAdmin)
              _buildStatusRow(
                'Admin Access',
                true,
              ),
            InfoRow(
              icon: Icons.update,
              label: 'Last Updated',
              value: user.lastUpdateDate.toString(),
              type: InfoType.date,
              showElapsedTime: true,
            ),
            InfoRow(
              icon: Icons.access_time,
              label: 'Last Login',
              value: DateTime.now()
                  .subtract(const Duration(hours: 3, minutes: 15))
                  .toString(),
              type: InfoType.date,
              showElapsedTime: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDangerZone() {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    return Card(
      color: Theme.of(context).colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.warning, color: Colors.red),
                const SizedBox(width: 8),
                Text(
                  'Danger Zone',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Once you delete your account, there is no going back. '
              'This will permanently delete:',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            const SizedBox(height: 8),
            ...['Your profile', 'Your data', 'Your settings']
                .map((text) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.remove_circle,
                            size: 16,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            text,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ],
                      ),
                    )),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isLoading ? null : _handleDeleteAccount,
                icon: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    : const Icon(Icons.delete_forever),
                label: Text(isLoading ? 'Deleting...' : 'Delete Account'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(String label, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            value ? Icons.check_circle : Icons.cancel,
            size: 20,
            color: value ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            value ? 'Yes' : 'No',
            style: TextStyle(
              color: value ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  List<AppAuthProvider> _getAvailableProviders(AppUser user) {
    final allProviders = [
      AppAuthProvider.google,
      if (Platform.isIOS || Platform.isMacOS || kIsWeb) AppAuthProvider.apple,
      AppAuthProvider.facebook,
      AppAuthProvider.github,
    ];
    return allProviders
        .where((provider) => !user.linkedProviders.contains(provider.name))
        .toList();
  }

  IconData _getProviderIcon(AppAuthProvider provider) {
    switch (provider) {
      case AppAuthProvider.google:
        return FontAwesomeIcons.google;
      case AppAuthProvider.apple:
        return FontAwesomeIcons.apple;
      case AppAuthProvider.facebook:
        return FontAwesomeIcons.facebookF;
      case AppAuthProvider.github:
        return FontAwesomeIcons.github;
      default:
        return FontAwesomeIcons.envelope;
    }
  }

  String _getProviderName(AppAuthProvider provider) {
    switch (provider) {
      case AppAuthProvider.google:
        return 'Google';
      case AppAuthProvider.apple:
        return 'Apple';
      case AppAuthProvider.facebook:
        return 'Facebook';
      case AppAuthProvider.github:
        return 'GitHub';
      default:
        return 'Email';
    }
  }

  Color _getProviderColor(AppAuthProvider provider) {
    switch (provider) {
      case AppAuthProvider.google:
        return const Color(0xFFDB4437);
      case AppAuthProvider.apple:
        return const Color(0xFF000000);
      case AppAuthProvider.facebook:
        return const Color(0xFF1877F2);
      case AppAuthProvider.github:
        return const Color(0xFF333333);
      default:
        return Colors.blue;
    }
  }
}
