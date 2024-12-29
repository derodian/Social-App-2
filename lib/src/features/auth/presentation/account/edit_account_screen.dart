import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:social_app_2/src/common_widgets/custom_text_form_field.dart';
import 'package:social_app_2/src/common_widgets/divider_with_margins.dart';
import 'package:social_app_2/src/common_widgets/error_message_widget.dart';
import 'package:social_app_2/src/common_widgets/responsive_center.dart';
import 'package:social_app_2/src/common_widgets/responsive_two_colum_layout.dart';
import 'package:social_app_2/src/constants/app_sizes.dart';
import 'package:social_app_2/src/constants/strings.dart';
import 'package:social_app_2/src/extensions/async_value_ui.dart';
import 'package:social_app_2/src/features/auth/data/app_user_storage_service.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/presentation/account/edit_account_screen_controller.dart';
import 'package:social_app_2/src/features/auth/typedefs/user_id.dart';
import 'package:social_app_2/src/features/components/admin_only/admin_only_widget.dart';
import 'package:social_app_2/src/features/services/image_picker_service.dart';
import 'package:social_app_2/src/theme/app_colors.dart';
import 'package:social_app_2/src/utils/string_hardcoded.dart';

class EditAccountScreen extends ConsumerWidget {
  const EditAccountScreen({
    super.key,
    required this.userId,
  });
  final UserID userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * By watching a [FutureProvider], the data is only loaded once.
    // * This prevents unintended rebuilds while the user is entering form data
    final userValue = ref.watch(appUserFutureProvider(userId));
    return userValue.when(
      data: (user) => user != null
          ? EditAccountScreenContents(user: user)
          : Scaffold(
              appBar: AppBar(title: Text('Edit Profile'.hardcoded)),
              body: Center(
                child: ErrorMessageWidget('User not found'.hardcoded),
              ),
            ),
      // * to prevent a black screen, return a [Scaffold] from the
      // * error and loading screen.
      error: (e, st) =>
          Scaffold(body: Center(child: ErrorMessageWidget(e.toString()))),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}

class EditAccountScreenContents extends ConsumerStatefulWidget {
  const EditAccountScreenContents({
    super.key,
    required this.user,
  });
  final AppUser user;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditAccountScreenStateContents();
}

class _EditAccountScreenStateContents
    extends ConsumerState<EditAccountScreenContents> {
  final log = Logger();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _displayNameController = TextEditingController();
  late TextEditingController _phoneNumberController = TextEditingController();
  late TextEditingController _primaryEmailController = TextEditingController();
  late TextEditingController _streetController = TextEditingController();
  late TextEditingController _cityController = TextEditingController();
  late TextEditingController _stateController = TextEditingController();
  late TextEditingController _zipController = TextEditingController();
  late TextEditingController _countryController = TextEditingController();

  // create focus node for each textfield

  final _displayNameFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _primaryEmailFocusNode = FocusNode();
  final _streetFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _stateFocusNode = FocusNode();
  final _zipFocusNode = FocusNode();
  final _countryFocusNode = FocusNode();

  String? _profileImageUrl;
  String? _profileBannerImageUrl;

  File? _profileImageFile;
  File? _profileBannerImageFile;

  bool? _isAdmin;
  bool? _isChatEnabled;
  bool? _isInfoShared;
  bool? _isPrimaryAccount;

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();

    final user = widget.user;

    _profileImageUrl = user.photoURL;
    _profileBannerImageUrl = user.profileBannerImageURL;
    _displayNameController = TextEditingController(text: user.displayName);
    _phoneNumberController = TextEditingController(text: user.phoneNumber);
    _primaryEmailController =
        TextEditingController(text: user.primaryAccountEmail);
    _streetController = TextEditingController(text: user.street);
    _cityController = TextEditingController(text: user.city);
    _stateController = TextEditingController(text: user.state);
    _zipController = TextEditingController(text: user.zip);
    _countryController = TextEditingController(text: user.country);
    _isAdmin = user.isAdmin;
    _isChatEnabled = user.isChatEnabled;
    _isInfoShared = user.isInfoShared;
    _isPrimaryAccount = user.isPrimaryAccount;
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _phoneNumberController.dispose();
    _primaryEmailController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    _countryController.dispose();

    _displayNameFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _primaryEmailFocusNode.dispose();
    _streetFocusNode.dispose();
    _cityFocusNode.dispose();
    _stateFocusNode.dispose();
    _zipFocusNode.dispose();
    _countryFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final state = ref.watch(editAccountScreenControllerProvider);
    final imagePickerService = ref.watch(imagePickerServiceProvider);

    ref.listen<AsyncValue>(
      editAccountScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Edit Account'),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.save,
              ),
              onPressed: state.isLoading ? null : submit,
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      // banner image
                      _buildBannerImage(
                        state: state,
                        imagePickerService: imagePickerService,
                      ),
                      // profile image
                      _buildProfileImage(
                        state: state,
                        imagePickerService: imagePickerService,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: screenSize.height / 10.0),
                        Text(
                          "Tap on image to change it",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        gapH16,
                        Text(
                          widget.user.email,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const DividerWithMargins(),
                        // text box for name
                        CustomTextFormField(
                          labelText: Strings.fullName,
                          fieldFocusNode: _displayNameFocusNode,
                          nextFocusNode: _phoneNumberFocusNode,
                          maxLines: 1,
                          controller: _displayNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                        ),
                        // text box for phone number
                        CustomTextFormField(
                          labelText: Strings.phoneNumber,
                          fieldFocusNode: _phoneNumberFocusNode,
                          nextFocusNode: _primaryEmailFocusNode,
                          maxLines: 1,
                          controller: _phoneNumberController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                        ),
                        gapH8,
                        // text box for street address
                        CustomTextFormField(
                          labelText: Strings.street,
                          fieldFocusNode: _streetFocusNode,
                          nextFocusNode: _cityFocusNode,
                          maxLines: null,
                          controller: _streetController,
                        ),
                        gapH8,
                        // text box for city
                        CustomTextFormField(
                          labelText: Strings.city,
                          fieldFocusNode: _cityFocusNode,
                          nextFocusNode: _stateFocusNode,
                          maxLines: 1,
                          controller: _cityController,
                        ),
                        gapH8,
                        // text box for state
                        CustomTextFormField(
                          labelText: Strings.state,
                          fieldFocusNode: _stateFocusNode,
                          nextFocusNode: _zipFocusNode,
                          maxLines: 1,
                          controller: _stateController,
                        ),
                        gapH8,
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: // text box for zip
                                  CustomTextFormField(
                                labelText: Strings.zip,
                                fieldFocusNode: _zipFocusNode,
                                nextFocusNode: _countryFocusNode,
                                maxLines: 1,
                                controller: _zipController,
                              ),
                            ),
                            gapW8,
                            Expanded(
                              flex: 1,
                              // text box for country
                              child: CustomTextFormField(
                                labelText: Strings.country,
                                fieldFocusNode: _countryFocusNode,
                                maxLines: 1,
                                controller: _countryController,
                                enterPressed: () =>
                                    FocusScope.of(context).unfocus(),
                              ),
                            ),
                          ],
                        ),
                        gapH10,
                        ListTile(
                          title: const Text(Strings.allowChatTitle),
                          subtitle: const Text(Strings.allowChatDescription),
                          trailing: Switch(
                            value: _isChatEnabled ?? false,
                            onChanged: (isOn) {
                              setState(() {
                                _isChatEnabled = isOn;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text(Strings.shareInfoTitle),
                          subtitle: const Text(Strings.shareInfoDescription),
                          trailing: Switch(
                            value: _isInfoShared ?? false,
                            onChanged: (isOn) {
                              setState(() {
                                _isInfoShared = isOn;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text(Strings.primaryAccountTitle),
                          subtitle:
                              const Text(Strings.primaryAccountDescription),
                          trailing: Switch(
                            value: _isPrimaryAccount ?? false,
                            onChanged: (isOn) {
                              setState(() {
                                _isPrimaryAccount = isOn;
                              });
                            },
                          ),
                        ),
                        if (_isPrimaryAccount != true)
                          // text box for primary email
                          CustomTextFormField(
                            labelText: Strings.primaryAccountEmail,
                            fieldFocusNode: _primaryEmailFocusNode,
                            nextFocusNode: _streetFocusNode,
                            maxLines: 1,
                            controller: _primaryEmailController,
                          ),
                        gapH8,
                        AdminOnlyWidget(
                          child: ListTile(
                            title: const Text(Strings.isAdminTitle),
                            subtitle: const Text(Strings.isAdminDescription),
                            trailing: Switch(
                              value: _isAdmin ?? false,
                              onChanged: (isOn) {
                                setState(() {
                                  _isAdmin = isOn;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  gapH20,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(
      {required AsyncValue<void> state,
      required ImagePickerService imagePickerService}) {
    final bool isProfileImageUrlEmpty =
        _profileImageUrl != null && _profileImageUrl!.isEmpty;
    return Positioned(
      bottom: -75,
      child: GestureDetector(
        onTap:
            state.isLoading ? null : () => pickProfileImage(imagePickerService),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
          ),
          child: ClipOval(
            child: SizedBox(
              width: 160,
              height: 160,
              child: _profileImageFile != null
                  ? Image.file(_profileImageFile!, fit: BoxFit.cover)
                  : !isProfileImageUrlEmpty
                      ? CachedNetworkImage(
                          imageUrl: _profileImageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              _buildLoadingIndicator(),
                          errorWidget: (context, url, error) =>
                              _buildErrorWidget(),
                        )
                      : _buildPlaceholderWidget('Add photo'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBannerImage(
      {required AsyncValue<void> state,
      required ImagePickerService imagePickerService}) {
    final bool isProfileBannerImageUrlEmpty =
        _profileBannerImageUrl != null && _profileBannerImageUrl!.isEmpty;
    return GestureDetector(
      onTap: state.isLoading
          ? null
          : () => pickProfileBannerImage(imagePickerService),
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: _profileBannerImageFile != null
            ? Image.file(_profileBannerImageFile!, fit: BoxFit.cover)
            : !isProfileBannerImageUrlEmpty
                ? CachedNetworkImage(
                    imageUrl: _profileBannerImageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => _buildLoadingIndicator(),
                    errorWidget: (context, url, error) => _buildErrorWidget(),
                  )
                : _buildPlaceholderWidget('Tap to add banner image'),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorWidget() {
    return const Center(
      child: Icon(Icons.error, color: Colors.red),
    );
  }

  Widget _buildPlaceholderWidget(String text) {
    return Container(
      color: AppColors.kcLightGreyColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_a_photo, size: 50, color: Colors.grey[600]),
            gapH8,
            Text(
              text,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickProfileImage(ImagePickerService imagePickerService) async {
    try {
      final pickedFile =
          await imagePickerService.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _profileImageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      showErrorSnackBar('Failed to pick image: $e');
    }
  }

  Future<void> pickProfileBannerImage(
      ImagePickerService imagePickerService) async {
    try {
      final pickedFile =
          await imagePickerService.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _profileBannerImageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      showErrorSnackBar('Failed to pick banner image: $e');
    }
  }

  Future<void> submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);
      try {
        final appUser = widget.user;
        final updatedUser = AppUser(
          id: appUser.id,
          email: appUser.email,
          displayName: _displayNameController.text,
          phoneNumber: _phoneNumberController.text,
          primaryAccountEmail: _primaryEmailController.text,
          isEmailVerified: appUser.isEmailVerified,
          isApproved: appUser.isApproved,
          isAdmin: _isAdmin!,
          isChatEnabled: _isChatEnabled!,
          isInfoShared: _isInfoShared!,
          isPrimaryAccount: _isPrimaryAccount!,
          street: _streetController.text,
          city: _cityController.text,
          state: _stateController.text,
          zip: _zipController.text,
          country: _countryController.text,
        );
        log.i('Updated User : $updatedUser');
        final success = await ref
            .read(editAccountScreenControllerProvider.notifier)
            .uploadImageAndSaveUserInfo(
              user: updatedUser,
              profileImageFile: _profileImageFile,
              profileBannerImageFile: _profileBannerImageFile,
            );
        if (success) {
          showSuccessSnackBar('Profile updated successfully');
          if (mounted) {
            context.pop();
          }
        } else {
          showErrorSnackBar('Failed to update profile');
        }
      } catch (e) {
        showErrorSnackBar('An error occurred: $e');
      } finally {
        setState(() => _isSubmitting = false);
      }
    }
  }

  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  PreferredSizeWidget _buildAppBar({
    required AsyncValue<void> state,
    required VoidCallback? onSave,
  }) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      leading: _buildAppBarIcon(
        icon: Icons.close,
        onPressed: state.isLoading ? null : () => Navigator.of(context).pop(),
      ),
      actions: [
        _buildAppBarIcon(
          icon: Icons.save,
          onPressed: onSave,
        ),
      ],
    );
  }

  Widget _buildAppBarIcon({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.kcBlackColor.withOpacity(0.6),
      ),
      child: IconButton(
        icon: Icon(icon),
        color: AppColors.kcWhiteColor,
        onPressed: onPressed,
      ),
    );
  }
}
