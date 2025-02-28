import 'package:flutter/material.dart';

/// A custom filled button with consistent styling across the app.
///
/// This button provides a filled background with customizable colors and
/// can include an optional icon. It follows Material 3 design principles
/// while maintaining a consistent look with the app's design language.
class CustomFilledButton extends StatelessWidget {
  /// The text to display on the button
  final String text;

  /// Called when the button is tapped
  final VoidCallback? onPressed;

  /// Optional icon to display before the text
  final IconData? icon;

  /// Optional loading state - shows a spinner instead of text/icon
  final bool isLoading;

  /// Override the default background color
  final Color? backgroundColor;

  /// Override the default text color
  final Color? textColor;

  /// Override the default icon color (defaults to textColor if not specified)
  final Color? iconColor;

  /// Space between icon and text
  final double iconSpacing;

  /// Border radius for the button
  final double borderRadius;

  /// The elevation of the button when it's in its default (unpressed) state
  final double elevation;

  /// Padding within the button
  final EdgeInsetsGeometry? padding;

  /// Text style for the button text
  final TextStyle? textStyle;

  /// Size of the icon (if provided)
  final double? iconSize;

  /// Width of the button (null for automatic sizing)
  final double? width;

  /// Height of the button (null for automatic sizing)
  final double? height;

  /// The minimum size of the button's tap target.
  final Size? minimumSize;

  /// Whether to show a splash effect when the button is tapped
  final bool enableFeedback;

  const CustomFilledButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.iconSpacing = 8.0,
    this.borderRadius = 8.0,
    this.elevation = 0,
    this.padding,
    this.textStyle,
    this.iconSize,
    this.width,
    this.height,
    this.minimumSize,
    this.enableFeedback = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Default colors based on theme
    final defaultBgColor = theme.colorScheme.primary;
    final defaultTextColor = theme.colorScheme.onPrimary;

    // Use provided colors or fall back to defaults
    final bgColor = backgroundColor ?? defaultBgColor;
    final txtColor = textColor ?? defaultTextColor;
    final icnColor = iconColor ?? txtColor;

    // Determine padding based on whether an icon is present
    final buttonPadding = padding ??
        EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        );

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: txtColor,
          elevation: elevation,
          padding: buttonPadding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          minimumSize: minimumSize,
          disabledBackgroundColor: bgColor.withOpacity(0.6),
          disabledForegroundColor: txtColor.withOpacity(0.8),
          enableFeedback: enableFeedback,
        ),
        child: isLoading
            ? _buildLoadingIndicator(txtColor)
            : _buildButtonContent(txtColor, icnColor, theme),
      ),
    );
  }

  Widget _buildLoadingIndicator(Color color) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }

  Widget _buildButtonContent(
      Color textColor, Color iconColor, ThemeData theme) {
    final buttonText = Text(
      text,
      style: textStyle?.copyWith(color: textColor) ??
          TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
    );

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
          SizedBox(width: iconSpacing),
          buttonText,
        ],
      );
    }

    return buttonText;
  }

  /// Creates a primary action button
  static CustomFilledButton primary({
    required String text,
    required VoidCallback onPressed,
    IconData? icon,
    bool isLoading = false,
    ThemeData? theme,
    BuildContext? context,
  }) {
    final theme = context != null ? Theme.of(context) : null;

    return CustomFilledButton(
      text: text,
      onPressed: onPressed,
      icon: icon,
      isLoading: isLoading,
      borderRadius: 8.0,
      // Other properties use defaults
    );
  }

  /// Creates a small button suitable for toolbars
  static CustomFilledButton small({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isLoading = false,
    ThemeData? theme,
    BuildContext? context,
  }) {
    final theme = context != null ? Theme.of(context) : null;

    return CustomFilledButton(
      text: text,
      onPressed: onPressed,
      icon: icon,
      isLoading: isLoading,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      iconSize: 18,
      textStyle: TextStyle(fontSize: 14),
      borderRadius: 8.0,
      // Other properties use defaults
    );
  }

  /// Creates a large button for prominent actions
  static CustomFilledButton large({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isLoading = false,
    ThemeData? theme,
    BuildContext? context,
  }) {
    final theme = context != null ? Theme.of(context) : null;

    return CustomFilledButton(
      text: text,
      onPressed: onPressed,
      icon: icon,
      isLoading: isLoading,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      iconSize: 24,
      borderRadius: 12.0,
      // Other properties use defaults
    );
  }

  /// Creates a secondary action button
  static CustomFilledButton secondary({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isLoading = false,
    BuildContext? context,
  }) {
    final theme = context != null ? Theme.of(context) : null;
    final bgColor = theme?.colorScheme.secondary;
    final txtColor = theme?.colorScheme.onSecondary;

    return CustomFilledButton(
      text: text,
      onPressed: onPressed,
      icon: icon,
      isLoading: isLoading,
      backgroundColor: bgColor,
      textColor: txtColor,
      // Other properties use defaults
    );
  }
}

// /// A convenience extension providing common button configurations
// extension CustomButtonExtensions on CustomFilledButton {
//   /// Creates a primary action button
//   static CustomFilledButton primary({
//     required String text,
//     required VoidCallback onPressed,
//     IconData? icon,
//     bool isLoading = false,
//     ThemeData? theme,
//   }) {
//     return CustomFilledButton(
//       text: text,
//       onPressed: onPressed,
//       icon: icon,
//       isLoading: isLoading,
//       borderRadius: 8.0,
//       // Other properties use defaults
//     );
//   }

//   /// Creates a small button suitable for toolbars
//   static CustomFilledButton small({
//     required String text,
//     required VoidCallback? onPressed,
//     IconData? icon,
//     bool isLoading = false,
//     ThemeData? theme,
//   }) {
//     return CustomFilledButton(
//       text: text,
//       onPressed: onPressed,
//       icon: icon,
//       isLoading: isLoading,
//       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       iconSize: 18,
//       textStyle: TextStyle(fontSize: 14),
//       borderRadius: 8.0,
//       // Other properties use defaults
//     );
//   }

//   /// Creates a large button for prominent actions
//   static CustomFilledButton large({
//     required String text,
//     required VoidCallback? onPressed,
//     IconData? icon,
//     bool isLoading = false,
//     ThemeData? theme,
//   }) {
//     return CustomFilledButton(
//       text: text,
//       onPressed: onPressed,
//       icon: icon,
//       isLoading: isLoading,
//       padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//       textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//       iconSize: 24,
//       borderRadius: 12.0,
//       // Other properties use defaults
//     );
//   }

//   /// Creates a secondary action button
//   static CustomFilledButton secondary({
//     required String text,
//     required VoidCallback? onPressed,
//     IconData? icon,
//     bool isLoading = false,
//     BuildContext? context,
//   }) {
//     final theme = context != null ? Theme.of(context) : null;
//     final bgColor = theme?.colorScheme.secondary;
//     final txtColor = theme?.colorScheme.onSecondary;

//     return CustomFilledButton(
//       text: text,
//       onPressed: onPressed,
//       icon: icon,
//       isLoading: isLoading,
//       backgroundColor: bgColor,
//       textColor: txtColor,
//       // Other properties use defaults
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:social_app_2/src/common_widgets/custom_filled_button.dart';
// import 'package:social_app_2/src/common_widgets/custom_outlined_button.dart';

// /// Examples of using CustomFilledButton and CustomOutlinedButton in different contexts

// /// Example 1: Basic login form
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: const InputDecoration(
//                 labelText: 'Email',
//                 prefixIcon: Icon(Icons.email),
//               ),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _passwordController,
//               decoration: const InputDecoration(
//                 labelText: 'Password',
//                 prefixIcon: Icon(Icons.lock),
//               ),
//               obscureText: true,
//             ),
//             const SizedBox(height: 32),
            
//             // Full-width primary button
//             CustomFilledButton(
//               text: 'Sign In',
//               onPressed: _isLoading ? null : _handleLogin,
//               isLoading: _isLoading,
//               width: double.infinity,
//               icon: Icons.login,
//             ),
            
//             const SizedBox(height: 16),
            
//             // Secondary outlined button
//             CustomOutlinedButton(
//               text: 'Create Account',
//               onPressed: () => Navigator.pushNamed(context, '/signup'),
//               width: double.infinity,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _handleLogin() async {
//     setState(() => _isLoading = true);
    
//     // Simulate network delay
//     await Future.delayed(const Duration(seconds: 2));
    
//     setState(() => _isLoading = false);
    
//     if (mounted) {
//       Navigator.pushReplacementNamed(context, '/home');
//     }
//   }
// }

// /// Example 2: Form with discard/save actions
// class EditProfileScreen extends ConsumerStatefulWidget {
//   const EditProfileScreen({Key? key}) : super(key: key);

//   @override
//   ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
//   bool _isSaving = false;
//   bool _hasChanges = true; // This would normally be calculated

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Profile'),
//         leading: IconButton(
//           icon: const Icon(Icons.close),
//           onPressed: () => _confirmDiscard(context),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: CustomFilledButton.small(
//               text: 'Save',
//               onPressed: _hasChanges ? _saveProfile : null,
//               isLoading: _isSaving,
//               icon: Icons.save,
//               context: context,
//             ),
//           ),
//         ],
//       ),
//       body: const Center(
//         child: Text('Profile form would go here'),
//       ),
//     );
//   }

//   Future<void> _saveProfile() async {
//     setState(() => _isSaving = true);
    
//     // Simulate network delay
//     await Future.delayed(const Duration(seconds: 2));
    
//     setState(() => _isSaving = false);
    
//     if (mounted) {
//       Navigator.pop(context);
//     }
//   }

//   Future<void> _confirmDiscard(BuildContext context) async {
//     if (!_hasChanges) {
//       Navigator.pop(context);
//       return;
//     }
    
//     final result = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Discard changes?'),
//         content: const Text('You have unsaved changes. Are you sure you want to discard them?'),
//         actions: [
//           CustomOutlinedButton.small(
//             text: 'Cancel',
//             onPressed: () => Navigator.pop(context, false),
//             context: context,
//           ),
//           CustomFilledButton.small(
//             text: 'Discard',
//             onPressed: () => Navigator.pop(context, true),
//             context: context,
//           ),
//         ],
//       ),
//     );
    
//     if (result == true && mounted) {
//       Navigator.pop(context);
//     }
//   }
// }

// /// Example 3: Different button styles in a settings screen
// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Settings')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Account',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
            
//             // Primary filled button
//             CustomFilledButton(
//               text: 'Edit Profile',
//               onPressed: () {},
//               icon: Icons.person,
//               width: double.infinity,
//             ),
            
//             const SizedBox(height: 8),
            
//             // Secondary filled button
//             CustomFilledButton.secondary(
//               text: 'Notification Settings',
//               onPressed: () {},
//               icon: Icons.notifications,
//               width: double.infinity,
//               context: context,
//             ),
            
//             const SizedBox(height: 8),
            
//             // Primary outlined button
//             CustomOutlinedButton(
//               text: 'Privacy Settings',
//               onPressed: () {},
//               icon: Icons.privacy_tip,
//               width: double.infinity,
//             ),
            
//             const SizedBox(height: 32),
            
//             const Text(
//               'Danger Zone',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
            
//             // Destructive outlined button
//             CustomOutlinedButton.destructive(
//               text: 'Delete Account',
//               onPressed: () {},
//               icon: Icons.delete_forever,
//               width: double.infinity,
//               context: context,
//             ),
            
//             const Spacer(),
            
//             // Large primary button at bottom
//             CustomFilledButton.large(
//               text: 'Save Changes',
//               onPressed: () {},
//               icon: Icons.save,
//               width: double.infinity,
//               context: context,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /// Example 4: Using buttons in a grid layout
// class FeatureGridScreen extends StatelessWidget {
//   const FeatureGridScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final features = [
//       {'title': 'Events', 'icon': Icons.event},
//       {'title': 'News', 'icon': Icons.article},
//       {'title': 'Photos', 'icon': Icons.photo_library},
//       {'title': 'Members', 'icon': Icons.people},
//       {'title': 'Messages', 'icon': Icons.message},
//       {'title': 'Calendar', 'icon': Icons.calendar_today},
//     ];

//     return Scaffold(
//       appBar: AppBar(title: const Text('Community Features')),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(16),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 1.5,
//           crossAxisSpacing: 16,
//           mainAxisSpacing: 16,
//         ),
//         itemCount: features.length,
//         itemBuilder: (context, index) {
//           final feature = features[index];
//           // Alternating between filled and outlined buttons
//           if (index % 2 == 0) {
//             return CustomFilledButton(
//               text: feature['title'] as String,
//               icon: feature['icon'] as IconData,
//               onPressed: () {},
//               width: double.infinity,
//               height: double.infinity,
//               borderRadius: 16,
//               textStyle: const TextStyle(fontSize: 18),
//               iconSpacing: 12,
//               iconSize: 32,
//             );
//           } else {
//             return CustomOutlinedButton(
//               text: feature['title'] as String,
//               icon: feature['icon'] as IconData,
//               onPressed: () {},
//               width: double.infinity,
//               height: double.infinity,
//               borderRadius: 16,
//               textStyle: const TextStyle(fontSize: 18),
//               iconSpacing: 12,
//               iconSize: 32,
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// /// Example 5: Using buttons in notification management
// class NotificationCenterScreen extends StatefulWidget {
//   const NotificationCenterScreen({Key? key}) : super(key: key);

//   @override
//   State<NotificationCenterScreen> createState() => _NotificationCenterScreenState();
// }

// class _NotificationCenterScreenState extends State<NotificationCenterScreen> {
//   bool _isMarkingAllRead = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Notifications'),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: CustomFilledButton.small(
//               text: 'Mark All Read',
//               onPressed: _markAllAsRead,
//               isLoading: _isMarkingAllRead,
//               icon: Icons.done_all,
//               context: context,
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: 10,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: const CircleAvatar(child: Icon(Icons.notifications)),
//                   title: Text('Notification ${index + 1}'),
//                   subtitle: const Text('This is a notification message'),
//                   trailing: CustomOutlinedButton.small(
//                     text: 'Read',
//                     onPressed: () {},
//                     context: context,
//                   ),
//                 );
//               },
//             ),
//           ),
          
//           // Example of bottom action buttons
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: CustomOutlinedButton(
//                     text: 'Settings',
//                     icon: Icons.settings,
//                     onPressed: () {},
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: CustomFilledButton(
//                     text: 'View All',
//                     icon: Icons.visibility,
//                     onPressed: () {},
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _markAllAsRead() async {
//     setState(() => _isMarkingAllRead = true);
    
//     // Simulate network delay
//     await Future.delayed(const Duration(seconds: 1));
    
//     setState(() => _isMarkingAllRead = false);
//   }
// }

// /// Example 6: Using buttons in photo detail screen
// class PhotoDetailScreen extends StatelessWidget {
//   final String photoUrl;
  
//   const PhotoDetailScreen({
//     Key? key,
//     required this.photoUrl,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Transparent app bar with custom back button
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: Container(
//           margin: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.black.withOpacity(0.5),
//           ),
//           child: IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//         actions: [
//           // Share button
//           Container(
//             margin: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.black.withOpacity(0.5),
//             ),
//             child: IconButton(
//               icon: const Icon(Icons.share, color: Colors.white),
//               onPressed: () {},
//             ),
//           ),
//         ],
//       ),
//       // Full screen image
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           // Photo
//           Image.network(
//             photoUrl,
//             fit: BoxFit.cover,
//           ),
          
//           // Bottom actions overlay
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.transparent,
//                     Colors.black.withOpacity(0.7),
//                   ],
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   // Like button
//                   CustomFilledButton(
//                     text: 'Like',
//                     icon: Icons.favorite,
//                     onPressed: () {},
//                     backgroundColor: Colors.white.withOpacity(0.2),
//                     textColor: Colors.white,
//                   ),
                  
//                   // Comment button
//                   CustomFilledButton(
//                     text: 'Comment',
//                     icon: Icons.comment,
//                     onPressed: () {},
//                     backgroundColor: Colors.white.withOpacity(0.2),
//                     textColor: Colors.white,
//                   ),
                  
//                   // Save button
//                   CustomFilledButton(
//                     text: 'Save',
//                     icon: Icons.bookmark,
//                     onPressed: () {},
//                     backgroundColor: Colors.white.withOpacity(0.2),
//                     textColor: Colors.white,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }