import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app_2/src/common_widgets/banner_image.dart';
import 'package:social_app_2/src/common_widgets/custom_text_form_field.dart';
import 'package:social_app_2/src/common_widgets/edit_button.dart';
import 'package:social_app_2/src/common_widgets/gredient_icon_button.dart';
import 'package:social_app_2/src/common_widgets/interactive_image_view.dart';
import 'package:social_app_2/src/common_widgets/profile_image.dart';
import 'package:social_app_2/src/constants/firestore_field_name.dart';
import 'package:social_app_2/src/features/auth/domain/app_user.dart';
import 'package:social_app_2/src/features/auth/presentation/account/edit_profile_form.dart';
import 'package:social_app_2/src/features/auth/presentation/account/profile_controller.dart';
import 'package:social_app_2/src/features/auth/presentation/widgets/circular_profile_image.dart';
import 'package:social_app_2/src/features/auth/presentation/widgets/image_picker_bottom_sheet.dart';
import 'package:social_app_2/src/features/services/image_picker_service.dart';
import 'package:social_app_2/src/features/services/snackbar_service.dart';
import 'package:social_app_2/src/utils/formatters.dart';
import 'package:social_app_2/src/utils/validators.dart';

// class EditProfileScreen extends ConsumerStatefulWidget {
//   const EditProfileScreen({
//     super.key,
//     required this.user,
//   });

//   final AppUser user;

//   @override
//   ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
//   final _formKey = GlobalKey<FormState>();

//   late final TextEditingController _nameController;
//   late final TextEditingController _emailController;
//   late final TextEditingController _phoneController;
//   late final TextEditingController _streetController;
//   late final TextEditingController _cityController;
//   late final TextEditingController _stateController;
//   late final TextEditingController _zipController;
//   late final TextEditingController _countryController;

//   File? _profileImage;
//   File? _backgroundImage;
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.user.displayName);
//     _emailController = TextEditingController(text: widget.user.email);
//     _phoneController = TextEditingController(text: widget.user.phoneNumber);
//     _streetController = TextEditingController(text: widget.user.street);
//     _cityController = TextEditingController(text: widget.user.city);
//     _stateController = TextEditingController(text: widget.user.addressState);
//     _zipController = TextEditingController(text: widget.user.zip);
//     _countryController = TextEditingController(text: widget.user.country);
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _streetController.dispose();
//     _cityController.dispose();
//     _stateController.dispose();
//     _zipController.dispose();
//     _countryController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickImage(bool isProfile) async {
//     final source = await showModalBottomSheet<ImageSource>(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => ImagePickerBottomSheet(
//         title: isProfile ? 'Update Profile Picture' : 'Update Cover Photo',
//       ),
//     );

//     if (source == null) return;

//     try {
//       // Show loading indicator
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Row(
//               children: [
//                 SizedBox(
//                   width: 20,
//                   height: 20,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 Text('Processing image...'),
//               ],
//             ),
//             duration: Duration(seconds: 1),
//           ),
//         );
//       }
//       final pickedFile = await ref.read(imagePickerProvider).pickImage(
//             source: source,
//             maxWidth: isProfile ? 500 : 1024, // Smaller size for profile pics
//             maxHeight: isProfile ? 500 : 1024,
//             imageQuality: isProfile ? 85 : 80,
//             preferCameraDevice: isProfile && source == ImageSource.camera,
//           );

//       if (pickedFile != null && mounted) {
//         setState(() {
//           if (isProfile) {
//             _profileImage = pickedFile;
//           } else {
//             _backgroundImage = pickedFile;
//           }
//         });

//         // Show success message
//         if (mounted) {
//           ref.read(snackBarControllerProvider.notifier).showSuccess(
//                 isProfile
//                     ? 'Profile picture updated successfully'
//                     : 'Cover photo updated successfully',
//               );
//           // ScaffoldMessenger.of(context).showSnackBar(
//           //   SnackBar(
//           //     content: Text(
//           //       isProfile
//           //           ? 'Profile picture updated successfully'
//           //           : 'Cover photo updated successfully',
//           //     ),
//           //     backgroundColor: Colors.green,
//           //   ),
//           // );
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(e.toString()),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   Future<void> _saveChanges() async {
//     final formState = ref.read(editProfileFormProvider.notifier);

//     setState(() => _isLoading = true);

//     try {
//       await formState.submit(
//         displayName: _nameController.text,
//         email: _emailController.text,
//         phone: _phoneController.text,
//         street: _streetController.text,
//         city: _cityController.text,
//         addressState: _stateController.text,
//         zip: _zipController.text,
//         country: _countryController.text,
//         profileImage: _profileImage,
//         backgroundImage: _backgroundImage,
//       );

//       if (mounted) {
//         Navigator.of(context).pop();
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error updating profile: ${e.toString()}'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() => _isLoading = false);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final profileState = ref.watch(profileControllerProvider);
//     final formState = ref.watch(editProfileFormProvider);

//     return AsyncValueListener<void>(
//       // value:
//       //     profileState.isLoading ? const AsyncLoading() : const AsyncData(null),
//       value: formState,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Edit Profile'),
//           actions: [
//             IconButton(
//               icon: _isLoading
//                   ? const SizedBox(
//                       width: 20,
//                       height: 20,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2,
//                         valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                       ),
//                     )
//                   : const Icon(Icons.save),
//               onPressed: _isLoading ? null : _saveChanges,
//             ),
//           ],
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 _buildImagePickers(),
//                 const SizedBox(height: 24),
//                 _buildForm(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Update the image picker UI
//   Widget _buildImagePickers() {
//     return Column(
//       children: [
//         Stack(
//           children: [
//             Container(
//               height: 150,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: _backgroundImage != null
//                   ? ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Image.file(
//                         _backgroundImage!,
//                         fit: BoxFit.cover,
//                       ),
//                     )
//                   : widget.user.profileBannerImageURL != null
//                       ? ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: CachedNetworkImage(
//                             imageUrl: widget.user.profileBannerImageURL!,
//                             fit: BoxFit.cover,
//                             placeholder: (context, url) => const Center(
//                               child: CircularProgressIndicator(),
//                             ),
//                             errorWidget: (context, url, error) => const Icon(
//                               Icons.image,
//                               size: 50,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         )
//                       : const Icon(
//                           Icons.image,
//                           size: 50,
//                           color: Colors.grey,
//                         ),
//             ),
//             Positioned(
//               bottom: 8,
//               right: 8,
//               child: CircleAvatar(
//                 backgroundColor: Theme.of(context).primaryColor,
//                 child: IconButton(
//                   icon: const Icon(Icons.edit, color: Colors.white),
//                   onPressed: () => _pickImage(false),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         Stack(
//           children: [
//             CircularProfileImage(
//               imageUrl:
//                   _profileImage != null ? null : widget.user.profileImageURL,
//               imageFile: _profileImage,
//               radius: 50,
//             ),
//             Positioned(
//               bottom: 0,
//               right: 0,
//               child: CircleAvatar(
//                 radius: 18,
//                 backgroundColor: Theme.of(context).primaryColor,
//                 child: IconButton(
//                   icon: const Icon(
//                     Icons.edit,
//                     size: 18,
//                     color: Colors.white,
//                   ),
//                   onPressed: () => _pickImage(true),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildForm() {
//     return Column(
//       children: [
//         CustomTextFormField(
//           controller: _nameController,
//           label: 'Name',
//           prefix: Icon(Icons.person),
//           validator: Validators.validateFullName,
//         ),
//         const SizedBox(height: 16),
//         CustomTextFormField(
//           controller: _emailController,
//           label: 'Email',
//           prefix: Icon(Icons.email),
//           validator: Validators.validateEmail,
//         ),
//         const SizedBox(height: 16),
//         CustomTextFormField(
//           controller: _phoneController,
//           label: 'Phone',
//           prefix: Icon(Icons.phone),
//           validator: Validators.validatePhone,
//           keyboardType: TextInputType.phone,
//           inputFormatters: FormattedFields.phoneFormatters,
//         ),
//         const SizedBox(height: 16),
//         // Address with multiple lines
//         CustomMultipleLineTextFormField(
//           label: 'Address',
//           controller: _streetController,
//           isRequired: false,
//           keyboardType: TextInputType.streetAddress,
//           textInputAction: TextInputAction.done,
//           maxLines: 3,
//           minLines: 2,
//           textCapitalization: TextCapitalization.sentences,
//         ),
//         // Bio Section
//         // CustomMultipleLineTextFormField(
//         //   label: 'Bio',
//         //   controller: _bioController,
//         //   hint: 'Tell us about yourself',
//         //   minLines: 3,
//         //   maxLines: 5,
//         //   isRequired: false,
//         //   textCapitalization: TextCapitalization.sentences,
//         // ),
//         // const SizedBox(height: 16),

//         // Website Section
//         // CustomTextFormField(
//         //   label: 'Website',
//         //   controller: _websiteController,
//         //   hint: 'https://',
//         //   keyboardType: TextInputType.url,
//         //   isRequired: false,
//         //   validator: (value) {
//         //     if (value != null && value.isNotEmpty) {
//         //       final urlRegExp = RegExp(
//         //         r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
//         //       );
//         //       if (!urlRegExp.hasMatch(value)) {
//         //         return 'Please enter a valid URL';
//         //       }
//         //     }
//         //     return null;
//         //   },
//         // ),
//       ],
//     );
//   }
// }
// class EditProfileScreen extends ConsumerStatefulWidget {
//   const EditProfileScreen({
//     super.key,
//     required this.user,
//   });

//   final AppUser user;

//   @override
//   ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
//   // Form key to validate form inputs
//   final _formKey = GlobalKey<FormState>();

//   // Scroll controller for the main scroll view
//   final _scrollController = ScrollController();

//   // Controllers for text fields
//   late final TextEditingController _nameController;
//   late final TextEditingController _emailController;
//   late final TextEditingController _phoneController;
//   late final TextEditingController _streetController;
//   late final TextEditingController _cityController;
//   late final TextEditingController _addressStateController;
//   late final TextEditingController _zipController;
//   late final TextEditingController _countryController;

//   // User settings
//   late final NotificationSettings _notificationSettings;
//   late final PrivacySettings _privacySettings;

//   // Image files
//   File? _profileImage;
//   File? _backgroundImage;

//   // Loading states
//   bool _isLoading = false;
//   bool _isUploadingProfile = false;
//   bool _isUploadingBackground = false;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize text controllers with current user data
//     _nameController = TextEditingController(text: widget.user.displayName);
//     _emailController = TextEditingController(text: widget.user.email);
//     _phoneController = TextEditingController(text: widget.user.phoneNumber);
//     _streetController = TextEditingController(text: widget.user.street);
//     _cityController = TextEditingController(text: widget.user.city);
//     _addressStateController =
//         TextEditingController(text: widget.user.addressState);
//     _zipController = TextEditingController(text: widget.user.zip);
//     _countryController = TextEditingController(text: widget.user.country);

//     // Initialize user settings
//     _notificationSettings = widget.user.notificationSettings;
//     _privacySettings = widget.user.privacySettings;
//   }

//   @override
//   void dispose() {
//     // Clean up all controllers when the widget is disposed
//     _nameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _streetController.dispose();
//     _cityController.dispose();
//     _addressStateController.dispose();
//     _zipController.dispose();
//     _countryController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   /// Handle image picking from camera or gallery
//   Future<void> _pickImage(bool isProfile) async {
//     try {
//       // Set loading state
//       setState(() {
//         if (isProfile) {
//           _isUploadingProfile = true;
//         } else {
//           _isUploadingBackground = true;
//         }
//       });

//       // Show bottom sheet to select image source
//       final source = await showModalBottomSheet<ImageSource>(
//         context: context,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//         ),
//         builder: (context) => ImagePickerBottomSheet(
//           title: isProfile ? 'Update Profile Picture' : 'Update Cover Photo',
//         ),
//       );

//       // If user canceled selection, exit early
//       if (source == null) {
//         setState(() {
//           _isUploadingProfile = false;
//           _isUploadingBackground = false;
//         });
//         return;
//       }

//       // Pick the image
//       final pickedFile = await ref.read(imagePickerProvider).pickImage(
//             source: source,
//             maxWidth: isProfile ? 500 : 1024, // Smaller size for profile pics
//             maxHeight: isProfile ? 500 : 1024,
//             imageQuality: isProfile ? 85 : 80,
//             preferCameraDevice: isProfile && source == ImageSource.camera,
//           );

//       // If image was picked, update state
//       if (pickedFile != null && mounted) {
//         setState(() {
//           if (isProfile) {
//             _profileImage = pickedFile;
//           } else {
//             _backgroundImage = pickedFile;
//           }
//         });

//         // Show success message
//         ref.read(snackBarControllerProvider.notifier).showSuccess(
//               isProfile
//                   ? 'Profile picture updated successfully'
//                   : 'Cover photo updated successfully',
//             );
//       }
//     } catch (e) {
//       // Show error message if something went wrong
//       ref.read(snackBarControllerProvider.notifier).showError(e.toString());
//     } finally {
//       // Reset loading state
//       if (mounted) {
//         setState(() {
//           _isUploadingProfile = false;
//           _isUploadingBackground = false;
//         });
//       }
//     }
//   }

//   // Update Privacy Settings
//   void _updatePrivacySetting(String setting, bool value) {
//     setState(() {
//       _privacySettings = switch (setting) {
//         FirestoreFieldName.hideLastSeen =>
//           _privacySettings.copyWith(hideLastSeen: value),
//         FirestoreFieldName.hideOnlineStatus =>
//           _privacySettings.copyWith(hideOnlineStatus: value),
//         FirestoreFieldName.profileVisibleToPublic =>
//           _privacySettings.copyWith(profileVisibleToPublic: value),
//         FirestoreFieldName.isInfoShared =>
//           widget.user.copyWith(isInfoShared: value).privacySettings,
//         FirestoreFieldName.isChatEnabled =>
//           widget.user.copyWith(isChatEnabled: value).privacySettings,
//         _ => _privacySettings,
//       };
//     });
//   }

//   // Update Notifications Settings
//   void _updateNotificationSetting(String setting, bool value) {
//     setState(() {
//       _notificationSettings = switch (setting) {
//         FirestoreFieldName.pushNotifications =>
//           _notificationSettings.copyWith(pushNotifications: value),
//         FirestoreFieldName.emailNotifications =>
//           _notificationSettings.copyWith(emailNotifications: value),
//         FirestoreFieldName.inAppNotifications =>
//           _notificationSettings.copyWith(inAppNotifications: value),
//         _ => _notificationSettings,
//       };
//     });
//   }

//   /// Save profile changes
//   Future<void> _saveChanges() async {
//     // Validate form
//     if (!_formKey.currentState!.validate()) return;

//     // Set loading state
//     setState(() => _isLoading = true);

//     try {
//       // Submit the form
//       await ref.read(editProfileFormProvider.notifier).submit(
//             displayName: _nameController.text,
//             email: _emailController.text,
//             phone: _phoneController.text,
//             street: _streetController.text,
//             city: _cityController.text,
//             addressState: _addressStateController.text,
//             zip: _zipController.text,
//             country: _countryController.text,
//             profileImage: _profileImage,
//             backgroundImage: _backgroundImage,
//             isInfoShared: widget.user.isInfoShared,
//             isChatEnabled: widget.user.isChatEnabled,
//             privacySettings: _privacySettings,
//             notificationSettings: _notificationSettings,
//           );

//       // Show success message and navigate back
//       if (mounted) {
//         ref
//             .read(snackBarControllerProvider.notifier)
//             .showSuccess('Profile updated successfully');
//         Navigator.of(context).pop();
//       }
//     } catch (e) {
//       // show error message
//       ref
//           .read(snackBarControllerProvider.notifier)
//           .showError('Failed to update profile: $e');
//     } finally {
//       // Reset loading state
//       if (mounted) {
//         setState(() => _isLoading = false);
//       }
//     }
//   }

//   // Add these methods to show full-screen images only if available
//   void _showFullScreenProfile(BuildContext context) {
//     ImageProvider? imageProvider;

//     if (_profileImage != null) {
//       imageProvider = FileImage(_profileImage!);
//     } else if (widget.user.profileImageURL != null) {
//       imageProvider = CachedNetworkImageProvider(widget.user.profileImageURL!);
//     }

//     if (imageProvider != null) {
//       InteractiveImageViewer.show(
//         context: context,
//         imageProvider: imageProvider,
//         title: 'Profile Photo',
//         allowSharing: true,
//         imageCaption: '${widget.user.displayName}\'s profile photo',
//       );
//     }
//   }

//   /// Show full-screen view of banner image if available
//   void _showFullScreenBanner(BuildContext context) {
//     ImageProvider? imageProvider;

//     if (_backgroundImage != null) {
//       imageProvider = FileImage(_backgroundImage!);
//     } else if (widget.user.profileBannerImageURL != null) {
//       imageProvider =
//           CachedNetworkImageProvider(widget.user.profileBannerImageURL!);
//     }

//     if (imageProvider != null) {
//       InteractiveImageViewer.show(
//         context: context,
//         imageProvider: imageProvider,
//         title: 'Cover Photo',
//         allowSharing: true,
//         imageCaption: '${widget.user.displayName}\'s cover photo',
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;

//     return Scaffold(
//       body: SafeArea(
//         top: false, // Allow content to extend under status bar
//         child: Stack(
//           children: [
//             // Main scroll view
//             CustomScrollView(
//               controller: _scrollController,
//               physics: const BouncingScrollPhysics(),
//               slivers: [
//                 // _buildAppBar(),
//                 _buildSliverAppBar(colorScheme),
//                 // Add bottom padding to account for bottom bar
//                 SliverToBoxAdapter(
//                   // child: _buildForm(),
//                   child: _buildProfileForm(colorScheme),
//                 )
//               ],
//             ),

//             // Loading overlay
//             if (_isLoading)
//               Positioned.fill(
//                 child: Container(
//                   color: Colors.black.withOpacity(0.3),
//                   child: Center(
//                     child: Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(24),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             const CircularProgressIndicator(),
//                             const SizedBox(height: 16),
//                             Text(
//                               'Saving changes...',
//                               style: theme.textTheme.bodyLarge,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//       // bottomNavigationBar: _buildBottomBar(),
//       bottomNavigationBar: _buildBottomBar(colorScheme),
//     );
//   }

//   // App Bar
//   Widget _buildAppBar() {
//     return SliverAppBar(
//       expandedHeight: 200,
//       pinned: true,
//       flexibleSpace: _buildHeaderImages(),
//       leading: IconButton(
//         onPressed: () => Navigator.pop(context),
//         icon: const Icon(Icons.close),
//       ),
//       actions: [
//         _isLoading
//             ? const Center(
//                 child: Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: SizedBox(
//                     width: 20,
//                     height: 20,
//                     child: CircularProgressIndicator(strokeWidth: 2),
//                   ),
//                 ),
//               )
//             : IconButton(
//                 onPressed: _saveChanges,
//                 icon: const Icon(Icons.save),
//               ),
//       ],
//     );
//   }

//   Widget _buildSliverAppBar(ColorScheme colorScheme) {
//     return SliverAppBar(
//       expandedHeight: 240, // Increased height for better visual appeal
//       pinned: true,
//       stretch: true, // Enable stretching effect
//       backgroundColor: colorScheme.surfaceContainerHigh,
//       elevation: 0,
//       scrolledUnderElevation: 2, // Modern subtle elevation when scrolled
//       flexibleSpace: _buildHeaderImages(),
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back),
//         tooltip: "Back",
//         onPressed: () => Navigator.pop(context),
//       ),
//       actions: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: TextButton.icon(
//             onPressed: _isLoading ? null : _saveChanges,
//             icon: const Icon(Icons.check),
//             label: const Text('Save'),
//             style: TextButton.styleFrom(
//               backgroundColor: colorScheme.primaryContainer,
//               foregroundColor: colorScheme.onPrimaryContainer,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   /// Build the header section with banner and profile images
//   Widget _buildHeaderImages() {
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         // FlexibleSpaceBar for banner and gradient
//         FlexibleSpaceBar(
//           background: Stack(
//             fit: StackFit.expand,
//             children: [
//               // Banner Image
//               GestureDetector(
//                 onTap: widget.user.profileBannerImageURL != null ||
//                         _backgroundImage != null
//                     ? () => _showFullScreenBanner(context)
//                     : null,
//                 child: BannerImage(
//                   imageUrl: widget.user.profileBannerImageURL,
//                   imageFile: _backgroundImage,
//                   isLoading: false, // We handle loading in the edit button
//                   isInteractive: widget.user.profileBannerImageURL != null ||
//                       _backgroundImage != null,
//                   backgroundColor:
//                       Theme.of(context).colorScheme.surfaceContainerHighest,
//                 ),
//               ),
//               // Gradient overlay
//               Positioned.fill(
//                 child: DecoratedBox(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Colors.black.withOpacity(0.3),
//                         Colors.black.withOpacity(0.1),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         // Edit Banner Button - moved outside FlexibleSpaceBar
//         Positioned(
//           bottom: 16, // Adjust this value to position above profile image
//           right: 16,
//           child: EditButton(
//             onPressed: () => _pickImage(false),
//             size: EditButtonSize.small,
//             isLoading: _isUploadingBackground,
//             tooltip: "Edit cover photo",
//           ),
//         ),
//         // Profile Image
//         Positioned(
//           left: 0,
//           right: 0,
//           bottom: -60,
//           child: Center(
//             child: SizedBox(
//               width: 120,
//               height: 120,
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   // Profile Image with possible full-screen view
//                   GestureDetector(
//                     onTap: widget.user.profileImageURL != null ||
//                             _profileImage != null
//                         ? () => _showFullScreenProfile(context)
//                         : null,
//                     child: ProfileImage(
//                       imageUrl: widget.user.profileImageURL,
//                       imageFile: _profileImage,
//                       isLoading: false, // We handle loading in the edit button
//                       isInteractive: widget.user.profileImageURL != null ||
//                           _profileImage != null,
//                       radius: 50,
//                     ),
//                   ),
//                   // Edit Profile Button
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: EditButton(
//                       onPressed: () => _pickImage(true),
//                       size: EditButtonSize.small,
//                       isLoading: _isUploadingProfile,
//                       tooltip: "Edit profile picture",
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildBannerImage() {
//     return Stack(
//       children: [
//         if (_backgroundImage != null)
//           Image.file(
//             _backgroundImage!,
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//           )
//         else if (widget.user.profileBannerImageURL != null)
//           CachedNetworkImage(
//             imageUrl: widget.user.profileBannerImageURL!,
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//             placeholder: (context, url) => Container(
//               color: Theme.of(context).colorScheme.surfaceContainerHighest,
//             ),
//             errorWidget: (context, url, error) => Container(
//               color: Theme.of(context).colorScheme.surfaceContainerHighest,
//               child: const Icon(
//                 Icons.image_not_supported,
//                 size: 50,
//               ),
//             ),
//           )
//         else
//           Center(
//             child: Container(
//               color: Theme.of(context).colorScheme.surfaceContainerHighest,
//               child: const Icon(Icons.image, size: 50),
//             ),
//           ),
//         // Edit button overlay
//         Positioned(
//           bottom: 16,
//           right: 16,
//           child: _isUploadingBackground
//               ? const CircularProgressIndicator()
//               : FloatingActionButton.small(
//                   onPressed: () => _pickImage(false),
//                   child: const Icon(Icons.edit),
//                 ),
//         ),
//       ],
//     );
//   }

//   Widget _buildProfileImage() {
//     return SizedBox(
//       width: 120,
//       height: 120,
//       child: Container(
//         decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(
//               color: Theme.of(context).colorScheme.surface,
//               width: 4,
//             )),
//         child: CircleAvatar(
//             radius: 56,
//             backgroundColor:
//                 Theme.of(context).colorScheme.surfaceContainerHighest,
//             child: Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 // Profile Image
//                 _profileImage != null
//                     ? ClipOval(
//                         child: Image.file(
//                           _profileImage!,
//                           width: 112,
//                           height: 112,
//                           fit: BoxFit.cover,
//                         ),
//                       )
//                     : widget.user.profileImageURL != null
//                         ? CachedNetworkImage(
//                             imageUrl: widget.user.profileImageURL!,
//                             imageBuilder: (context, imageProvider) => Container(
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   image: DecorationImage(
//                                     image: imageProvider,
//                                     fit: BoxFit.cover,
//                                   )),
//                             ),
//                             placeholder: (context, url) =>
//                                 const CircularProgressIndicator(),
//                             errorWidget: (context, url, error) => const Icon(
//                               Icons.person,
//                               size: 56,
//                             ),
//                           )
//                         : Center(
//                             child: const Icon(
//                               Icons.person,
//                               size: 56,
//                             ),
//                           ),
//                 // Edit Button
//                 Positioned(
//                   bottom: -4,
//                   right: -4,
//                   child: _isUploadingProfile
//                       ? const CircularProgressIndicator()
//                       : Container(
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Theme.of(context).colorScheme.primary,
//                           ),
//                           child: IconButton(
//                             iconSize: 20,
//                             padding: const EdgeInsets.all(8),
//                             constraints: const BoxConstraints(),
//                             icon: const Icon(
//                               Icons.edit,
//                               color: Colors.white,
//                             ),
//                             onPressed: () => _pickImage(true),
//                           ),
//                         ),
//                 ),
//               ],
//             )),
//       ),
//     );
//   }

//   // Update the image picker UI
//   Widget _buildImagePickers() {
//     return Column(
//       children: [
//         Stack(
//           children: [
//             Container(
//               height: 150,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: _backgroundImage != null
//                   ? ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Image.file(
//                         _backgroundImage!,
//                         fit: BoxFit.cover,
//                       ),
//                     )
//                   : widget.user.profileBannerImageURL != null
//                       ? ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: CachedNetworkImage(
//                             imageUrl: widget.user.profileBannerImageURL!,
//                             fit: BoxFit.cover,
//                             placeholder: (context, url) => const Center(
//                               child: CircularProgressIndicator(),
//                             ),
//                             errorWidget: (context, url, error) => const Icon(
//                               Icons.image,
//                               size: 50,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         )
//                       : const Icon(
//                           Icons.image,
//                           size: 50,
//                           color: Colors.grey,
//                         ),
//             ),
//             Positioned(
//               bottom: 8,
//               right: 8,
//               child: CircleAvatar(
//                 backgroundColor: Theme.of(context).primaryColor,
//                 child: IconButton(
//                   icon: const Icon(Icons.edit, color: Colors.white),
//                   onPressed: () => _pickImage(false),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         Stack(
//           children: [
//             CircularProfileImage(
//               imageUrl:
//                   _profileImage != null ? null : widget.user.profileImageURL,
//               imageFile: _profileImage,
//               radius: 50,
//             ),
//             Positioned(
//               bottom: 0,
//               right: 0,
//               child: CircleAvatar(
//                 radius: 18,
//                 backgroundColor: Theme.of(context).primaryColor,
//                 child: IconButton(
//                   icon: const Icon(
//                     Icons.edit,
//                     size: 18,
//                     color: Colors.white,
//                   ),
//                   onPressed: () => _pickImage(true),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   /// Build the main profile form
//   Widget _buildProfileForm(ColorScheme colorScheme) {
//     return Form(
//       key: _formKey,
//       child: Padding(
//         padding: const EdgeInsets.only(
//           top: 64, // Space for profile image that extends above
//           left: 16,
//           right: 16,
//           bottom: 16,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // User's name in large text
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 24.0),
//                 child: Text(
//                   widget.user.displayName,
//                   style: Theme.of(context).textTheme.headlineSmall,
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),

//             // Basic info sectioned form with Material 3 card treatment
//             _buildCardSection(
//               title: 'Basic Information',
//               icon: Icons.person_outline,
//               colorScheme: colorScheme,
//               children: [
//                 CustomTextFormField(
//                   controller: _nameController,
//                   label: 'Name',
//                   prefix: Icon(Icons.person),
//                   validator: Validators.validateFullName,
//                 ),
//                 const SizedBox(height: 16),
//                 CustomTextFormField(
//                   controller: _emailController,
//                   label: 'Email',
//                   isEnabled: false, // Email usually can't be changed directly
//                   prefix: Icon(Icons.email),
//                   validator: Validators.validateEmail,
//                 ),
//                 const SizedBox(height: 16),
//                 CustomTextFormField(
//                   controller: _phoneController,
//                   label: 'Phone',
//                   prefix: Icon(Icons.phone),
//                   validator: Validators.validatePhone,
//                   keyboardType: TextInputType.phone,
//                   inputFormatters: FormattedFields.phoneFormatters,
//                 ),
//               ],
//             ),

//             const SizedBox(height: 24),

//             // Address section
//             _buildCardSection(
//               title: 'Address',
//               icon: Icons.location_on_outlined,
//               colorScheme: colorScheme,
//               children: [
//                 CustomTextFormField(
//                   label: 'Street',
//                   controller: _streetController,
//                   isRequired: false,
//                   prefix: Icon(Icons.home),
//                   keyboardType: TextInputType.streetAddress,
//                   textInputAction: TextInputAction.next,
//                   textCapitalization: TextCapitalization.sentences,
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: CustomTextFormField(
//                         controller: _cityController,
//                         label: 'City',
//                         prefix: Icon(Icons.location_city),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: CustomTextFormField(
//                         controller: _addressStateController,
//                         label: 'State',
//                         prefix: Icon(Icons.map),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: CustomTextFormField(
//                         controller: _zipController,
//                         label: 'Zip Code',
//                         prefix: Icon(Icons.pin),
//                         keyboardType: TextInputType.number,
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: CustomTextFormField(
//                         controller: _countryController,
//                         label: 'Country',
//                         prefix: Icon(Icons.public),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),

//             const SizedBox(height: 24),

//             // Privacy section
//             _buildCardSection(
//               title: 'Privacy',
//               icon: Icons.security_outlined,
//               colorScheme: colorScheme,
//               children: [
//                 _buildPrivacySwitchTile(
//                   title: 'Share Information',
//                   subtitle: 'Make your profile visible to others',
//                   value: widget.user.isInfoShared,
//                   onChanged: (value) =>
//                       _updatePrivacySetting('isInfoShared', value),
//                   colorScheme: colorScheme,
//                 ),
//                 _buildPrivacySwitchTile(
//                   title: 'Enable Chat',
//                   subtitle: 'Allow others to send you messages',
//                   value: widget.user.isChatEnabled,
//                   onChanged: (value) =>
//                       _updatePrivacySetting('isChatEnabled', value),
//                   colorScheme: colorScheme,
//                 ),
//                 _buildPrivacySwitchTile(
//                   title: 'Hide Last Seen',
//                   subtitle: 'Hide your last active status',
//                   value: _privacySettings.hideLastSeen,
//                   onChanged: (value) =>
//                       _updatePrivacySetting('hideLastSeen', value),
//                   colorScheme: colorScheme,
//                 ),
//                 _buildPrivacySwitchTile(
//                   title: 'Hide Online Status',
//                   subtitle: 'Hide when you\'re online',
//                   value: _privacySettings.hideOnlineStatus,
//                   onChanged: (value) =>
//                       _updatePrivacySetting('hideOnlineStatus', value),
//                   colorScheme: colorScheme,
//                 ),
//                 _buildPrivacySwitchTile(
//                   title: 'Public Profile',
//                   subtitle: 'Allow anyone to view your profile',
//                   value: _privacySettings.profileVisibleToPublic,
//                   onChanged: (value) =>
//                       _updatePrivacySetting('profileVisibleToPublic', value),
//                   colorScheme: colorScheme,
//                 ),
//               ],
//             ),

//             const SizedBox(height: 24),

//             // Notification section
//             _buildCardSection(
//               title: 'Notifications',
//               icon: Icons.notifications_outlined,
//               colorScheme: colorScheme,
//               children: [
//                 _buildPrivacySwitchTile(
//                   title: 'Push Notifications',
//                   subtitle: 'Receive push notifications',
//                   value: _notificationSettings.pushNotifications,
//                   onChanged: (value) =>
//                       _updateNotificationSetting('pushNotifications', value),
//                   colorScheme: colorScheme,
//                 ),
//                 _buildPrivacySwitchTile(
//                   title: 'Email Notifications',
//                   subtitle: 'Receive email notifications',
//                   value: _notificationSettings.emailNotifications,
//                   onChanged: (value) =>
//                       _updateNotificationSetting('emailNotifications', value),
//                   colorScheme: colorScheme,
//                 ),
//                 _buildPrivacySwitchTile(
//                   title: 'In-App Notifications',
//                   subtitle: 'Show notifications within the app',
//                   value: _notificationSettings.inAppNotifications,
//                   onChanged: (value) =>
//                       _updateNotificationSetting('inAppNotifications', value),
//                   colorScheme: colorScheme,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildForm() {
//     return Form(
//       key: _formKey,
//       child: ListView(
//         padding: const EdgeInsets.only(
//           top: 100,
//           left: 16,
//           right: 16,
//           bottom: 16,
//         ),
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         children: [
//           // Basic Information section
//           _buildSection(
//             title: 'Basic Information',
//             icon: Icons.person_outline,
//             children: [
//               CustomTextFormField(
//                 controller: _nameController,
//                 label: 'Name',
//                 prefix: Icon(Icons.person),
//                 validator: Validators.validateFullName,
//               ),
//               const SizedBox(height: 16),
//               CustomTextFormField(
//                 controller: _emailController,
//                 label: 'Email',
//                 isEnabled: false, // Email usually can't be changed directly
//                 prefix: Icon(Icons.email),
//                 validator: Validators.validateEmail,
//               ),
//               const SizedBox(height: 16),
//               CustomTextFormField(
//                 controller: _phoneController,
//                 label: 'Phone',
//                 prefix: Icon(Icons.phone),
//                 validator: Validators.validatePhone,
//                 keyboardType: TextInputType.phone,
//                 inputFormatters: FormattedFields.phoneFormatters,
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           _buildSection(
//             title: 'Address',
//             icon: Icons.location_on_outlined,
//             children: [
//               // Address with multiple lines
//               CustomTextFormField(
//                 label: 'Street',
//                 controller: _streetController,
//                 isRequired: false,
//                 keyboardType: TextInputType.streetAddress,
//                 textInputAction: TextInputAction.next,
//                 textCapitalization: TextCapitalization.sentences,
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomTextFormField(
//                       controller: _cityController,
//                       label: 'City',
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: CustomTextFormField(
//                       controller: _addressStateController,
//                       label: 'State',
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomTextFormField(
//                       controller: _zipController,
//                       label: 'Zip Code',
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: CustomTextFormField(
//                       controller: _countryController,
//                       label: 'Country',
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),

//           // Privacy Settings Section
//           _buildSection(
//             title: 'Privacy Settings',
//             icon: Icons.security_outlined,
//             children: [
//               SwitchListTile(
//                 title: const Text('Share Information'),
//                 subtitle: const Text('Make your profile visible to others'),
//                 value: widget.user.isInfoShared,
//                 onChanged: (value) =>
//                     _updatePrivacySetting('isInfoShared', value),
//               ),
//               SwitchListTile(
//                 title: const Text('Enable Chat'),
//                 subtitle: const Text('Allow others to send you messages'),
//                 value: widget.user.isChatEnabled,
//                 onChanged: (value) =>
//                     _updatePrivacySetting('isChatEnabled', value),
//               ),
//             ],
//           ),

//           // Notification Settings Section
//           _buildSection(
//             title: 'Notification Preferences',
//             icon: Icons.notifications_outlined,
//             children: [
//               // Add notification settings switches
//               // Similar to privacy settings
//             ],
//           ),

//           // Bio Section
//           // CustomMultipleLineTextFormField(
//           //   label: 'Bio',
//           //   controller: _bioController,
//           //   hint: 'Tell us about yourself',
//           //   minLines: 3,
//           //   maxLines: 5,
//           //   isRequired: false,
//           //   textCapitalization: TextCapitalization.sentences,
//           // ),
//           // const SizedBox(height: 16),

//           // Website Section
//           // CustomTextFormField(
//           //   label: 'Website',
//           //   controller: _websiteController,
//           //   hint: 'https://',
//           //   keyboardType: TextInputType.url,
//           //   isRequired: false,
//           //   validator: (value) {
//           //     if (value != null && value.isNotEmpty) {
//           //       final urlRegExp = RegExp(
//           //         r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
//           //       );
//           //       if (!urlRegExp.hasMatch(value)) {
//           //         return 'Please enter a valid URL';
//           //       }
//           //     }
//           //     return null;
//           //   },
//           // ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSettingTile({
//     required String title,
//     required String subtitle,
//     required bool value,
//     required ValueChanged<bool> onChanged,
//   }) {
//     return SwitchListTile(
//       title: Text(title),
//       subtitle: Text(subtitle),
//       value: value,
//       onChanged: onChanged,
//       contentPadding: EdgeInsets.zero,
//     );
//   }

//   Widget _buildPrivacySettings() {
//     return Column(
//       children: [
//         _buildSettingTile(
//           title: 'Share Information',
//           subtitle: 'Make your profile visible to others',
//           value: widget.user.isInfoShared,
//           onChanged: (value) => _updatePrivacySetting(
//             FirestoreFieldName.isInfoShared,
//             value,
//           ),
//         ),
//         _buildSettingTile(
//           title: 'Enable Chat',
//           subtitle: 'Allow others to send you messages',
//           value: widget.user.isChatEnabled,
//           onChanged: (value) => _updatePrivacySetting('isChatEnabled', value),
//         ),
//         _buildSettingTile(
//           title: 'Hide Last Seen',
//           subtitle: 'Hide your last active status',
//           value: _privacySettings.hideLastSeen,
//           onChanged: (value) => _updatePrivacySetting('hideLastSeen', value),
//         ),
//         _buildSettingTile(
//           title: 'Hide Online Status',
//           subtitle: 'Hide when you\'re online',
//           value: _privacySettings.hideOnlineStatus,
//           onChanged: (value) =>
//               _updatePrivacySetting('hideOnlineStatus', value),
//         ),
//         _buildSettingTile(
//           title: 'Public Profile',
//           subtitle: 'Allow anyone to view your profile',
//           value: _privacySettings.profileVisibleToPublic,
//           onChanged: (value) =>
//               _updatePrivacySetting('profileVisibleToPublic', value),
//         ),
//       ],
//     );
//   }

//   Widget _buildNotificationSettings() {
//     return Column(
//       children: [
//         _buildSettingTile(
//           title: 'Push Notifications',
//           subtitle: 'Receive push notifications',
//           value: _notificationSettings.pushNotifications,
//           onChanged: (value) =>
//               _updateNotificationSetting('pushNotifications', value),
//         ),
//         _buildSettingTile(
//           title: 'Email Notifications',
//           subtitle: 'Receive email notifications',
//           value: _notificationSettings.emailNotifications,
//           onChanged: (value) =>
//               _updateNotificationSetting('emailNotifications', value),
//         ),
//         _buildSettingTile(
//           title: 'In-App Notifications',
//           subtitle: 'Show notifications within the app',
//           value: _notificationSettings.inAppNotifications,
//           onChanged: (value) =>
//               _updateNotificationSetting('inAppNotifications', value),
//         ),
//         // Add specific notification types
//         const Divider(height: 32),
//         const Text(
//           'Notify me about:',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//           ),
//         ),
//         const SizedBox(height: 16),
//         // Add specific notification preferences here
//       ],
//     );
//   }

//   // Modern card section with Material 3 styling
//   Widget _buildCardSection({
//     required String title,
//     required IconData icon,
//     required List<Widget> children,
//     required ColorScheme colorScheme,
//   }) {
//     return Card(
//       elevation: 0,
//       color: colorScheme.surfaceContainerLow,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(icon, color: colorScheme.primary),
//                 const SizedBox(width: 8),
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w500,
//                     color: colorScheme.onSurface,
//                   ),
//                 ),
//               ],
//             ),
//             const Divider(height: 24),
//             ...children,
//           ],
//         ),
//       ),
//     );
//   }

//   // Modern switch tile with Material 3 styling
//   Widget _buildPrivacySwitchTile({
//     required String title,
//     required String subtitle,
//     required bool value,
//     required ValueChanged<bool> onChanged,
//     required ColorScheme colorScheme,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   subtitle,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: colorScheme.onSurfaceVariant,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Switch(
//             value: value,
//             onChanged: onChanged,
//             activeColor: colorScheme.primary,
//           ),
//         ],
//       ),
//     );
//   }

//   // Build the bottom action bar
//   Widget _buildBottomBar(ColorScheme colorScheme) {
//     return Container(
//       decoration: BoxDecoration(
//         color: colorScheme.surface,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 5,
//             offset: const Offset(0, -1),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             children: [
//               Expanded(
//                 child: OutlinedButton(
//                   onPressed: () => Navigator.pop(context),
//                   style: OutlinedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Text('Cancel'),
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: FilledButton(
//                   onPressed: _isLoading ? null : _saveChanges,
//                   style: FilledButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: _isLoading
//                       ? const SizedBox(
//                           width: 20,
//                           height: 20,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             valueColor:
//                                 AlwaysStoppedAnimation<Color>(Colors.white),
//                           ),
//                         )
//                       : const Text('Save'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSection({
//     required String title,
//     required IconData icon,
//     required List<Widget> children,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           child: Row(
//             children: [
//               Icon(icon, size: 24),
//               const SizedBox(width: 8),
//               Text(
//                 title,
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//             ],
//           ),
//         ),
//         ...children,
//         const Divider(height: 32),
//       ],
//     );
//   }

//   // Widget _buildBottomBar() {
//   //   return SafeArea(
//   //     child: Padding(
//   //       padding: const EdgeInsets.all(16),
//   //       child: Row(
//   //         children: [
//   //           Expanded(
//   //             child: OutlinedButton(
//   //               onPressed: () => Navigator.pop(context),
//   //               child: const Text('Cancel'),
//   //             ),
//   //           ),
//   //           const SizedBox(width: 16),
//   //           Expanded(
//   //             child: FilledButton(
//   //               onPressed: _isLoading ? null : _saveChanges,
//   //               child: _isLoading
//   //                   ? const SizedBox(
//   //                       width: 20,
//   //                       height: 20,
//   //                       child: CircularProgressIndicator(strokeWidth: 2),
//   //                     )
//   //                   : const Text('Save'),
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
// }

/// Screen for editing user profile information
class EditProfileScreen extends ConsumerStatefulWidget {
  /// Constructor for the edit profile screen
  const EditProfileScreen({
    super.key,
    required this.user,
  });

  /// The user whose profile is being edited
  final AppUser user;

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  // Form key to validate form inputs
  final _formKey = GlobalKey<FormState>();

  // Scroll controller for the main scroll view
  final _scrollController = ScrollController();

  // Controllers for text fields
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _streetController;
  late final TextEditingController _cityController;
  late final TextEditingController _addressStateController;
  late final TextEditingController _zipController;
  late final TextEditingController _countryController;

  // User settings
  late NotificationSettings _notificationSettings;
  late PrivacySettings _privacySettings;
  late bool _isInfoShared;
  late bool _isChatEnabled;

  // Original values to compare for changes
  late final String _originalName;
  late final String _originalPhone;
  late final String _originalStreet;
  late final String _originalCity;
  late final String _originalState;
  late final String _originalZip;
  late final String _originalCountry;
  late final NotificationSettings _originalNotificationSettings;
  late final PrivacySettings _originalPrivacySettings;
  late final bool _originalInfoShared;
  late final bool _originalChatEnabled;

  // Image state
  File? _profileImage;
  File? _backgroundImage;

  // Loading states
  bool _isLoading = false;
  bool _isUploadingProfile = false;
  bool _isUploadingBackground = false;

  // Track if data has been changed
  bool _hasDataChanged = false;

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with current user data
    _nameController = TextEditingController(text: widget.user.displayName);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phoneNumber);
    _streetController = TextEditingController(text: widget.user.street);
    _cityController = TextEditingController(text: widget.user.city);
    _addressStateController =
        TextEditingController(text: widget.user.addressState);
    _zipController = TextEditingController(text: widget.user.zip);
    _countryController = TextEditingController(text: widget.user.country);

    // Store original values for change detection
    _originalName = widget.user.displayName;
    _originalPhone = widget.user.phoneNumber ?? '';
    _originalStreet = widget.user.street ?? '';
    _originalCity = widget.user.city ?? '';
    _originalState = widget.user.addressState ?? '';
    _originalZip = widget.user.zip ?? '';
    _originalCountry = widget.user.country ?? '';

    // Initialize user settings
    _notificationSettings = widget.user.notificationSettings;
    _privacySettings = widget.user.privacySettings;
    _isInfoShared = widget.user.isInfoShared;
    _isChatEnabled = widget.user.isChatEnabled;

    // Store original settings for change detection
    _originalNotificationSettings = widget.user.notificationSettings;
    _originalPrivacySettings = widget.user.privacySettings;
    _originalInfoShared = widget.user.isInfoShared;
    _originalChatEnabled = widget.user.isChatEnabled;

    // Add listeners to detect changes
    _nameController.addListener(_checkForChanges);
    _phoneController.addListener(_checkForChanges);
    _streetController.addListener(_checkForChanges);
    _cityController.addListener(_checkForChanges);
    _addressStateController.addListener(_checkForChanges);
    _zipController.addListener(_checkForChanges);
    _countryController.addListener(_checkForChanges);
  }

  @override
  void dispose() {
    // Remove listeners
    _nameController.removeListener(_checkForChanges);
    _phoneController.removeListener(_checkForChanges);
    _streetController.removeListener(_checkForChanges);
    _cityController.removeListener(_checkForChanges);
    _addressStateController.removeListener(_checkForChanges);
    _zipController.removeListener(_checkForChanges);
    _countryController.removeListener(_checkForChanges);

    // Clean up all controllers when the widget is disposed
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _addressStateController.dispose();
    _zipController.dispose();
    _countryController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// Check if any data has changed from original values
  void _checkForChanges() {
    final hasTextChanged = _nameController.text != _originalName ||
        _phoneController.text != _originalPhone ||
        _streetController.text != _originalStreet ||
        _cityController.text != _originalCity ||
        _addressStateController.text != _originalState ||
        _zipController.text != _originalZip ||
        _countryController.text != _originalCountry;

    final hasSettingsChanged =
        !_notificationSettings.equals(_originalNotificationSettings) ||
            !_privacySettings.equals(_originalPrivacySettings) ||
            _isInfoShared != _originalInfoShared ||
            _isChatEnabled != _originalChatEnabled;

    final hasImagesChanged = _profileImage != null || _backgroundImage != null;

    final newHasDataChanged =
        hasTextChanged || hasSettingsChanged || hasImagesChanged;

    // Only update state if the value has changed
    if (newHasDataChanged != _hasDataChanged) {
      setState(() {
        _hasDataChanged = newHasDataChanged;
      });
    }
  }

  /// Handle image picking from camera or gallery
  Future<void> _pickImage(bool isProfile) async {
    try {
      // Set loading state
      setState(() {
        if (isProfile) {
          _isUploadingProfile = true;
        } else {
          _isUploadingBackground = true;
        }
      });

      // Show bottom sheet to select image source
      final source = await showModalBottomSheet<ImageSource>(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => ImagePickerBottomSheet(
          title: isProfile ? 'Update Profile Picture' : 'Update Cover Photo',
        ),
      );

      // If user canceled selection, exit early
      if (source == null) {
        setState(() {
          _isUploadingProfile = false;
          _isUploadingBackground = false;
        });
        return;
      }

      // Pick the image
      final pickedFile = await ref.read(imagePickerProvider).pickImage(
            source: source,
            maxWidth: isProfile ? 500 : 1024, // Smaller size for profile pics
            maxHeight: isProfile ? 500 : 1024,
            imageQuality: isProfile ? 85 : 80,
            preferCameraDevice: isProfile && source == ImageSource.camera,
          );

      // If image was picked, update state
      if (pickedFile != null && mounted) {
        setState(() {
          if (isProfile) {
            _profileImage = pickedFile;
          } else {
            _backgroundImage = pickedFile;
          }
          // Update has changed flag
          _hasDataChanged = true;
        });

        // Show success message
        ref.read(snackBarControllerProvider.notifier).showSuccess(
              isProfile
                  ? 'Profile picture updated successfully'
                  : 'Cover photo updated successfully',
            );
      }
    } catch (e) {
      // Show error message if something went wrong
      ref.read(snackBarControllerProvider.notifier).showError(e.toString());
    } finally {
      // Reset loading state
      if (mounted) {
        setState(() {
          _isUploadingProfile = false;
          _isUploadingBackground = false;
        });
      }
    }
  }

  /// Update privacy settings
  void _updatePrivacySetting(String setting, bool value) {
    setState(() {
      switch (setting) {
        case FirestoreFieldName.hideLastSeen:
          _privacySettings = _privacySettings.copyWith(hideLastSeen: value);
          break;
        case FirestoreFieldName.hideOnlineStatus:
          _privacySettings = _privacySettings.copyWith(hideOnlineStatus: value);
          break;
        case FirestoreFieldName.profileVisibleToPublic:
          _privacySettings =
              _privacySettings.copyWith(profileVisibleToPublic: value);
          break;
        case FirestoreFieldName.isInfoShared:
          _isInfoShared = value;
          break;
        case FirestoreFieldName.isChatEnabled:
          _isChatEnabled = value;
          break;
      }

      // Check if settings have changed
      _checkForChanges();
    });
  }

  /// Update notification settings
  void _updateNotificationSetting(String setting, bool value) {
    setState(() {
      switch (setting) {
        case FirestoreFieldName.pushNotifications:
          _notificationSettings =
              _notificationSettings.copyWith(pushNotifications: value);
          break;
        case FirestoreFieldName.emailNotifications:
          _notificationSettings =
              _notificationSettings.copyWith(emailNotifications: value);
          break;
        case FirestoreFieldName.inAppNotifications:
          _notificationSettings =
              _notificationSettings.copyWith(inAppNotifications: value);
          break;
      }

      // Check if settings have changed
      _checkForChanges();
    });
  }

  /// Save profile changes
  Future<void> _saveChanges() async {
    // Only proceed if data has changed
    if (!_hasDataChanged) return;

    // Validate form
    // if (!_formKey.currentState!.validate()) return;
    // Validate form - this is the key part
    if (!_formKey.currentState!.validate()) {
      // Form validation failed - show error message
      ref
          .read(snackBarControllerProvider.notifier)
          .showError('Please fill in all required fields before saving');
      return;
    }

    // Set loading state
    setState(() => _isLoading = true);

    try {
      // Submit the form
      await ref.read(editProfileFormProvider.notifier).submit(
            displayName: _nameController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            street: _streetController.text,
            city: _cityController.text,
            addressState: _addressStateController.text,
            zip: _zipController.text,
            country: _countryController.text,
            profileImage: _profileImage,
            backgroundImage: _backgroundImage,
            isInfoShared: _isInfoShared,
            isChatEnabled: _isChatEnabled,
            privacySettings: _privacySettings,
            notificationSettings: _notificationSettings,
          );

      // Show success message and navigate back
      if (mounted) {
        ref
            .read(snackBarControllerProvider.notifier)
            .showSuccess('Profile updated successfully');
        Navigator.of(context).pop();
      }
    } catch (e) {
      // Show error message
      ref
          .read(snackBarControllerProvider.notifier)
          .showError('Failed to update profile: $e');
    } finally {
      // Reset loading state
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Show dialog to confirm discarding changes
  void _showDiscardChangesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Discard changes?'),
        content: const Text(
            'You have unsaved changes. Are you sure you want to discard them?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Close edit screen
            },
            child: const Text('Discard'),
          ),
        ],
      ),
    );
  }

  /// Show full-screen view of profile image if available
  void _showFullScreenProfile(BuildContext context) {
    ImageProvider? imageProvider;

    if (_profileImage != null) {
      imageProvider = FileImage(_profileImage!);
    } else if (widget.user.profileImageURL != null) {
      imageProvider = CachedNetworkImageProvider(widget.user.profileImageURL!);
    }

    if (imageProvider != null) {
      InteractiveImageViewer.show(
        context: context,
        imageProvider: imageProvider,
        title: 'Profile Photo',
        allowSharing: true,
        imageCaption: '${widget.user.displayName}\'s profile photo',
      );
    }
  }

  /// Show full-screen view of banner image if available
  void _showFullScreenBanner(BuildContext context) {
    ImageProvider? imageProvider;

    if (_backgroundImage != null) {
      imageProvider = FileImage(_backgroundImage!);
    } else if (widget.user.profileBannerImageURL != null) {
      imageProvider =
          CachedNetworkImageProvider(widget.user.profileBannerImageURL!);
    }

    if (imageProvider != null) {
      InteractiveImageViewer.show(
        context: context,
        imageProvider: imageProvider,
        title: 'Cover Photo',
        allowSharing: true,
        imageCaption: '${widget.user.displayName}\'s cover photo',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        top: false, // Allow content to extend under status bar
        child: Stack(
          children: [
            // Main scroll view
            CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                _buildSliverAppBar(colorScheme),
                SliverToBoxAdapter(
                  child: _buildProfileForm(colorScheme),
                ),
                // Add bottom padding to account for bottom bar
                SliverToBoxAdapter(
                  child: SizedBox(height: 80),
                ),
              ],
            ),

            // Loading overlay
            if (_isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(height: 16),
                            Text(
                              'Saving changes...',
                              style: theme.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(colorScheme),
    );
  }

  /// Build the sliver app bar with header images
  Widget _buildSliverAppBar(ColorScheme colorScheme) {
    return SliverAppBar(
      expandedHeight: 240, // Increased height for better visual appeal
      pinned: true,
      stretch: true, // Enable stretching effect
      backgroundColor: colorScheme.surfaceContainerHigh.withOpacity(0.8),
      elevation: 0,
      scrolledUnderElevation: 2, // Modern subtle elevation when scrolled
      flexibleSpace: _buildHeaderImages(),
      leading: GradientIconButton(
        onPressed: () => _hasDataChanged
            ? _showDiscardChangesDialog()
            : Navigator.pop(context),
        tooltip: 'Back',
        icon: Icons.arrow_back,
      ),

      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton.icon(
            onPressed: _hasDataChanged && !_isLoading ? _saveChanges : null,
            icon: const Icon(Icons.check),
            label: const Text('Save'),
            style: TextButton.styleFrom(
              backgroundColor: _hasDataChanged
                  ? colorScheme.primaryContainer
                  : colorScheme.surfaceContainerHigh,
              foregroundColor: _hasDataChanged
                  ? colorScheme.onPrimaryContainer
                  : colorScheme.onSurfaceVariant.withOpacity(0.5),
              disabledBackgroundColor: colorScheme.surfaceContainerHigh,
              disabledForegroundColor:
                  colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }

  /// Build the header section with banner and profile images
  Widget _buildHeaderImages() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // FlexibleSpaceBar for banner and gradient
        FlexibleSpaceBar(
          background: Stack(
            fit: StackFit.expand,
            children: [
              // Banner Image
              GestureDetector(
                onTap: widget.user.profileBannerImageURL != null ||
                        _backgroundImage != null
                    ? () => _showFullScreenBanner(context)
                    : null,
                child: BannerImage(
                  imageUrl: widget.user.profileBannerImageURL,
                  imageFile: _backgroundImage,
                  isLoading: false, // We handle loading in the edit button
                  isInteractive: widget.user.profileBannerImageURL != null ||
                      _backgroundImage != null,
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
              ),
              // Gradient overlay
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Edit Banner Button - using our common edit button
        Positioned(
          bottom: 38,
          right: 16,
          child: EditButton(
            onPressed: () => _pickImage(false),
            size: EditButtonSize.small,
            isLoading: _isUploadingBackground,
            tooltip: "Edit cover photo",
          ),
        ),

        // Profile Image
        Positioned(
          left: 0,
          right: 0,
          bottom: -50,
          child: Center(
            child: Stack(
              children: [
                // Profile Image with possible full-screen view
                ProfileImage(
                  imageUrl: widget.user.profileImageURL,
                  imageFile: _profileImage,
                  isLoading: false, // We handle loading in the edit button
                  isInteractive: false,
                  radius: 60,
                  onTap: widget.user.profileImageURL != null ||
                          _profileImage != null
                      ? () => _showFullScreenProfile(context)
                      : null,
                ),
                // Edit button last (higher z-index)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Transform.translate(
                    offset: const Offset(0, 0), // Try adjusting if needed
                    child: EditButton(
                      onPressed: () => _pickImage(true),
                      size: EditButtonSize.small,
                      isLoading: _isUploadingProfile,
                      tooltip: "Edit profile picture",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Build the main profile form
  Widget _buildProfileForm(ColorScheme colorScheme) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 64, // Space for profile image that extends above
          left: 16,
          right: 16,
          bottom: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User's name in large text
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  widget.user.displayName,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // Basic Information section
            _buildCardSection(
              title: 'Basic Information',
              icon: Icons.person_outline,
              colorScheme: colorScheme,
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
                  isEnabled: false, // Email usually can't be changed directly
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
              ],
            ),

            const SizedBox(height: 24),

            // Address section
            _buildCardSection(
              title: 'Address',
              icon: Icons.location_on_outlined,
              colorScheme: colorScheme,
              children: [
                CustomTextFormField(
                  label: 'Street',
                  controller: _streetController,
                  isRequired: false,
                  prefix: Icon(Icons.home),
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: _cityController,
                        label: 'City',
                        prefix: Icon(Icons.location_city),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomTextFormField(
                        controller: _addressStateController,
                        label: 'State',
                        prefix: Icon(Icons.map),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: _zipController,
                        label: 'Zip Code',
                        prefix: Icon(Icons.pin),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomTextFormField(
                        controller: _countryController,
                        label: 'Country',
                        prefix: Icon(Icons.public),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Privacy section
            _buildCardSection(
              title: 'Privacy',
              icon: Icons.security_outlined,
              colorScheme: colorScheme,
              children: [
                _buildPrivacySwitchTile(
                  title: 'Share Information',
                  subtitle: 'Make your profile visible to others',
                  value: _isInfoShared,
                  onChanged: (value) => _updatePrivacySetting(
                      FirestoreFieldName.isInfoShared, value),
                  colorScheme: colorScheme,
                ),
                _buildPrivacySwitchTile(
                  title: 'Enable Chat',
                  subtitle: 'Allow others to send you messages',
                  value: _isChatEnabled,
                  onChanged: (value) => _updatePrivacySetting(
                      FirestoreFieldName.isChatEnabled, value),
                  colorScheme: colorScheme,
                ),
                _buildPrivacySwitchTile(
                  title: 'Hide Last Seen',
                  subtitle: 'Hide your last active status',
                  value: _privacySettings.hideLastSeen,
                  onChanged: (value) => _updatePrivacySetting(
                      FirestoreFieldName.hideLastSeen, value),
                  colorScheme: colorScheme,
                ),
                _buildPrivacySwitchTile(
                  title: 'Hide Online Status',
                  subtitle: 'Hide when you\'re online',
                  value: _privacySettings.hideOnlineStatus,
                  onChanged: (value) => _updatePrivacySetting(
                      FirestoreFieldName.hideOnlineStatus, value),
                  colorScheme: colorScheme,
                ),
                _buildPrivacySwitchTile(
                  title: 'Public Profile',
                  subtitle: 'Allow anyone to view your profile',
                  value: _privacySettings.profileVisibleToPublic,
                  onChanged: (value) => _updatePrivacySetting(
                      FirestoreFieldName.profileVisibleToPublic, value),
                  colorScheme: colorScheme,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Notifications section
            _buildCardSection(
              title: 'Notifications',
              icon: Icons.notifications_outlined,
              colorScheme: colorScheme,
              children: [
                _buildPrivacySwitchTile(
                  title: 'Push Notifications',
                  subtitle: 'Receive push notifications',
                  value: _notificationSettings.pushNotifications,
                  onChanged: (value) => _updateNotificationSetting(
                      FirestoreFieldName.pushNotifications, value),
                  colorScheme: colorScheme,
                ),
                _buildPrivacySwitchTile(
                  title: 'Email Notifications',
                  subtitle: 'Receive email notifications',
                  value: _notificationSettings.emailNotifications,
                  onChanged: (value) => _updateNotificationSetting(
                      FirestoreFieldName.emailNotifications, value),
                  colorScheme: colorScheme,
                ),
                _buildPrivacySwitchTile(
                  title: 'In-App Notifications',
                  subtitle: 'Show notifications within the app',
                  value: _notificationSettings.inAppNotifications,
                  onChanged: (value) => _updateNotificationSetting(
                      FirestoreFieldName.inAppNotifications, value),
                  colorScheme: colorScheme,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build a card section with title and children
  Widget _buildCardSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
    required ColorScheme colorScheme,
  }) {
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  /// Build a switch tile for settings
  Widget _buildPrivacySwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required ColorScheme colorScheme,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: colorScheme.primary,
          ),
        ],
      ),
    );
  }

  /// Build the bottom action bar
  Widget _buildBottomBar(ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _hasDataChanged
                      ? _showDiscardChangesDialog()
                      : Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: FilledButton(
                  onPressed:
                      _hasDataChanged && !_isLoading ? _saveChanges : null,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Bottom sheet for image source selection
class ImagePickerBottomSheet extends StatelessWidget {
  final String title;

  const ImagePickerBottomSheet({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a photo'),
              onTap: () => Navigator.of(context).pop(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from gallery'),
              onTap: () => Navigator.of(context).pop(ImageSource.gallery),
            ),
            if (title.contains('Profile'))
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Remove current photo'),
                onTap: () => Navigator.of(context).pop(null),
              ),
          ],
        ),
      ),
    );
  }
}

/// Extension to add equality checking to NotificationSettings
extension NotificationSettingsExtensions on NotificationSettings {
  bool equals(NotificationSettings other) {
    return pushNotifications == other.pushNotifications &&
        emailNotifications == other.emailNotifications &&
        inAppNotifications == other.inAppNotifications;
  }
}

/// Extension to add equality checking to PrivacySettings
extension PrivacySettingsExtensions on PrivacySettings {
  bool equals(PrivacySettings other) {
    return hideLastSeen == other.hideLastSeen &&
        hideOnlineStatus == other.hideOnlineStatus &&
        profileVisibleToPublic == other.profileVisibleToPublic;
  }
}
