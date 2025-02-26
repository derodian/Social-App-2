import 'package:flutter/material.dart';

// class EditButton extends StatelessWidget {
//   final VoidCallback? onPressed;
//   final bool isLoading;
//   final double size;
//   final Color? backgroundColor;

//   const EditButton({
//     super.key,
//     required this.onPressed,
//     this.isLoading = false,
//     this.size = 40,
//     this.backgroundColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: isLoading ? null : onPressed,
//         customBorder: const CircleBorder(),
//         child: Container(
//           width: size,
//           height: size,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: backgroundColor ?? Theme.of(context).colorScheme.primary,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.2),
//                 blurRadius: 6,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: isLoading
//               ? const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation(Colors.white),
//                   ),
//                 )
//               : Icon(
//                   Icons.edit,
//                   color: Colors.white,
//                   size: size * 0.5,
//                 ),
//         ),
//       ),
//     );
//   }
// }

/// A standardized edit button widget for use throughout the app.
///
/// This button maintains a consistent look and feel for edit functionality
/// across the entire application.
class EditButton extends StatelessWidget {
  /// Callback function when the button is pressed.
  final VoidCallback onPressed;

  /// Size of the button. Available options are:
  /// - `small`: Minimal footprint for constrained spaces (FAB.small equivalent)
  /// - `normal`: Standard size for most edit button needs
  /// - `large`: Larger button for primary editing actions
  final EditButtonSize size;

  /// Whether the edit action is currently loading.
  /// Shows a CircularProgressIndicator when true.
  final bool isLoading;

  /// Optional tooltip text for the button.
  final String? tooltip;

  /// Additional text to show next to the edit icon. Only shown for normal and large sizes.
  final String? label;

  /// Button style variant:
  /// - `circle`: Round button with icon only
  /// - `pill`: Pill-shaped button that can include text
  /// - `standard`: Regular Material button shape
  final EditButtonStyle style;

  /// Optional background color override. If null, uses the theme's primary color.
  final Color? backgroundColor;

  /// Optional foreground/icon color override. If null, uses an appropriate contrasting color.
  final Color? foregroundColor;

  /// Creates an EditButton with the specified configuration.
  ///
  /// The [onPressed] callback is required. When null, the button will be disabled.
  ///
  /// Example usages:
  /// ```dart
  /// // Basic small circular edit button
  /// EditButton(
  ///   onPressed: () => print('Edit pressed'),
  ///   size: EditButtonSize.small,
  /// )
  ///
  /// // Pill-shaped button with text label
  /// EditButton(
  ///   onPressed: () => print('Edit pressed'),
  ///   label: 'Edit Profile',
  ///   style: EditButtonStyle.pill,
  /// )
  /// ```
  const EditButton({
    super.key,
    required this.onPressed,
    this.size = EditButtonSize.normal,
    this.isLoading = false,
    this.tooltip,
    this.label,
    this.style = EditButtonStyle.circle,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Size configurations
    final double iconSize = switch (size) {
      EditButtonSize.small => 18.0,
      EditButtonSize.normal => 24.0,
      EditButtonSize.large => 28.0,
    };

    final double buttonSize = switch (size) {
      EditButtonSize.small => 36.0,
      EditButtonSize.normal => 48.0,
      EditButtonSize.large => 56.0,
    };

    final double padding = switch (size) {
      EditButtonSize.small => 8.0,
      EditButtonSize.normal => 12.0,
      EditButtonSize.large => 16.0,
    };

    // Colors
    final Color bgColor = backgroundColor ?? colorScheme.primary;
    final Color fgColor = foregroundColor ?? colorScheme.onPrimary;

    // Loading indicator
    if (isLoading) {
      return SizedBox(
        width: buttonSize,
        height: buttonSize,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(bgColor),
        ),
      );
    }

    // Main button content
    Widget buttonContent;

    switch (style) {
      case EditButtonStyle.circle:
        buttonContent = Container(
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bgColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              customBorder: const CircleBorder(),
              child: Icon(
                Icons.edit,
                size: iconSize,
                color: fgColor,
              ),
            ),
          ),
        );
        break;

      case EditButtonStyle.pill:
        buttonContent = Container(
          height: buttonSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(buttonSize / 2),
            color: bgColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(buttonSize / 2),
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(buttonSize / 2),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.edit,
                      size: iconSize,
                      color: fgColor,
                    ),
                    if (label != null) ...[
                      SizedBox(width: 8),
                      Text(
                        label!,
                        style: TextStyle(
                          color: fgColor,
                          fontWeight: FontWeight.w500,
                          fontSize: iconSize * 0.75,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
        break;

      case EditButtonStyle.standard:
        buttonContent = SizedBox(
          height: buttonSize,
          child: ElevatedButton.icon(
            onPressed: onPressed,
            icon: Icon(
              Icons.edit,
              size: iconSize,
              color: fgColor,
            ),
            label: label != null
                ? Text(
                    label!,
                    style: TextStyle(
                      color: fgColor,
                    ),
                  )
                : const SizedBox.shrink(),
            style: ElevatedButton.styleFrom(
              backgroundColor: bgColor,
              foregroundColor: fgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: padding,
                vertical: padding / 2,
              ),
            ),
          ),
        );
        break;
    }

    // Apply tooltip if provided
    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        child: buttonContent,
      );
    }

    return buttonContent;
  }
}

/// Size variants for the edit button
enum EditButtonSize {
  small,
  normal,
  large,
}

/// Style variants for the edit button
enum EditButtonStyle {
  circle,
  pill,
  standard,
}

/// Factory extension for quickly creating floating action buttons
extension EditButtonExtensions on EditButton {
  /// Creates a floating action button variant of this edit button
  static Widget floatingActionButton({
    required VoidCallback onPressed,
    bool isLoading = false,
    String? tooltip,
    EditButtonSize size = EditButtonSize.large,
  }) {
    return EditButton(
      onPressed: onPressed,
      size: size,
      isLoading: isLoading,
      tooltip: tooltip ?? 'Edit',
      style: EditButtonStyle.circle,
    );
  }

  /// Creates a mini floating action button variant
  static Widget miniFloatingActionButton({
    required VoidCallback onPressed,
    bool isLoading = false,
    String? tooltip,
  }) {
    return EditButton(
      onPressed: onPressed,
      size: EditButtonSize.small,
      isLoading: isLoading,
      tooltip: tooltip ?? 'Edit',
      style: EditButtonStyle.circle,
    );
  }

  /// Creates a labeled edit button with pill shape
  static Widget labeled({
    required VoidCallback onPressed,
    required String label,
    bool isLoading = false,
    String? tooltip,
    EditButtonSize size = EditButtonSize.normal,
  }) {
    return EditButton(
      onPressed: onPressed,
      size: size,
      isLoading: isLoading,
      tooltip: tooltip,
      label: label,
      style: EditButtonStyle.pill,
    );
  }
}
