import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app_2/src/common_widgets/async_value_listner.dart';
import 'package:social_app_2/src/common_widgets/custom_multiple_line_text_form_field.dart';
import 'package:social_app_2/src/common_widgets/custom_text_form_field.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/presentation/account/edit_profile_form.dart';
import 'package:social_app_2/src/features/auth/presentation/account/profile_controller.dart';
import 'package:social_app_2/src/features/auth/presentation/widgets/circular_profile_image.dart';
import 'package:social_app_2/src/features/auth/presentation/widgets/image_picker_bottom_sheet.dart';
import 'package:social_app_2/src/features/services/image_picker_service.dart';
import 'package:social_app_2/src/features/services/snackbar_service.dart';
import 'package:social_app_2/src/utils/formatters.dart';
import 'package:social_app_2/src/utils/validators.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({
    super.key,
    required this.user,
  });

  final AppUser user;

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _streetController;
  late final TextEditingController _cityController;
  late final TextEditingController _stateController;
  late final TextEditingController _zipController;
  late final TextEditingController _countryController;

  File? _profileImage;
  File? _backgroundImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.displayName);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phoneNumber);
    _streetController = TextEditingController(text: widget.user.street);
    _cityController = TextEditingController(text: widget.user.city);
    _stateController = TextEditingController(text: widget.user.addressState);
    _zipController = TextEditingController(text: widget.user.zip);
    _countryController = TextEditingController(text: widget.user.country);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(bool isProfile) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => ImagePickerBottomSheet(
        title: isProfile ? 'Update Profile Picture' : 'Update Cover Photo',
      ),
    );

    if (source == null) return;

    try {
      // Show loading indicator
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                SizedBox(width: 16),
                Text('Processing image...'),
              ],
            ),
            duration: Duration(seconds: 1),
          ),
        );
      }
      final pickedFile = await ref.read(imagePickerProvider).pickImage(
            source: source,
            maxWidth: isProfile ? 500 : 1024, // Smaller size for profile pics
            maxHeight: isProfile ? 500 : 1024,
            imageQuality: isProfile ? 85 : 80,
            preferCameraDevice: isProfile && source == ImageSource.camera,
          );

      if (pickedFile != null && mounted) {
        setState(() {
          if (isProfile) {
            _profileImage = pickedFile;
          } else {
            _backgroundImage = pickedFile;
          }
        });

        // Show success message
        if (mounted) {
          ref.read(snackBarControllerProvider.notifier).showSuccess(
                isProfile
                    ? 'Profile picture updated successfully'
                    : 'Cover photo updated successfully',
              );
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text(
          //       isProfile
          //           ? 'Profile picture updated successfully'
          //           : 'Cover photo updated successfully',
          //     ),
          //     backgroundColor: Colors.green,
          //   ),
          // );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _saveChanges() async {
    final formState = ref.read(editProfileFormProvider.notifier);

    setState(() => _isLoading = true);

    try {
      await formState.submit(
        displayName: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        street: _streetController.text,
        city: _cityController.text,
        addressState: _stateController.text,
        zip: _zipController.text,
        country: _countryController.text,
        profileImage: _profileImage,
        backgroundImage: _backgroundImage,
      );

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating profile: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileControllerProvider);
    final formState = ref.watch(editProfileFormProvider);

    return AsyncValueListener<void>(
      // value:
      //     profileState.isLoading ? const AsyncLoading() : const AsyncData(null),
      value: formState,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
          actions: [
            IconButton(
              icon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Icon(Icons.save),
              onPressed: _isLoading ? null : _saveChanges,
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildImagePickers(),
                const SizedBox(height: 24),
                _buildForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Update the image picker UI
  Widget _buildImagePickers() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: _backgroundImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        _backgroundImage!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : widget.user.profileBannerImageURL != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: widget.user.profileBannerImageURL!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : const Icon(
                          Icons.image,
                          size: 50,
                          color: Colors.grey,
                        ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: () => _pickImage(false),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Stack(
          children: [
            CircularProfileImage(
              imageUrl:
                  _profileImage != null ? null : widget.user.profileImageURL,
              imageFile: _profileImage,
              radius: 50,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Theme.of(context).primaryColor,
                child: IconButton(
                  icon: const Icon(
                    Icons.edit,
                    size: 18,
                    color: Colors.white,
                  ),
                  onPressed: () => _pickImage(true),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        CustomTextFormField(
          controller: _nameController,
          label: 'Name',
          prefix: Icon(Icons.person),
          validator: Validators.validateFullName,
        ),
        const SizedBox(height: 16),
        CustomTextFormField(
          controller: _emailController,
          label: 'Email',
          prefix: Icon(Icons.email),
          validator: Validators.validateEmail,
        ),
        const SizedBox(height: 16),
        CustomTextFormField(
          controller: _phoneController,
          label: 'Phone',
          prefix: Icon(Icons.phone),
          validator: Validators.validatePhone,
          keyboardType: TextInputType.phone,
          inputFormatters: FormattedFields.phoneFormatters,
        ),
        const SizedBox(height: 16),
        // Address with multiple lines
        CustomMultipleLineTextFormField(
          label: 'Address',
          controller: _streetController,
          isRequired: false,
          keyboardType: TextInputType.streetAddress,
          textInputAction: TextInputAction.done,
          maxLines: 3,
          minLines: 2,
          textCapitalization: TextCapitalization.sentences,
        ),
        // Bio Section
        // CustomMultipleLineTextFormField(
        //   label: 'Bio',
        //   controller: _bioController,
        //   hint: 'Tell us about yourself',
        //   minLines: 3,
        //   maxLines: 5,
        //   isRequired: false,
        //   textCapitalization: TextCapitalization.sentences,
        // ),
        // const SizedBox(height: 16),

        // Website Section
        // CustomTextFormField(
        //   label: 'Website',
        //   controller: _websiteController,
        //   hint: 'https://',
        //   keyboardType: TextInputType.url,
        //   isRequired: false,
        //   validator: (value) {
        //     if (value != null && value.isNotEmpty) {
        //       final urlRegExp = RegExp(
        //         r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
        //       );
        //       if (!urlRegExp.hasMatch(value)) {
        //         return 'Please enter a valid URL';
        //       }
        //     }
        //     return null;
        //   },
        // ),
      ],
    );
  }
}
