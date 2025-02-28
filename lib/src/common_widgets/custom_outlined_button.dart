import 'package:flutter/material.dart';

/// A custom outlined button with consistent styling across the app.
///
/// This button provides an outlined style with customizable colors and
/// can include an optional icon. It matches the style of CustomFilledButton
/// but with an outlined appearance.
class CustomOutlinedButton extends StatelessWidget {
  /// The text to display on the button
  final String text;

  /// Called when the button is tapped
  final VoidCallback? onPressed;

  /// Optional icon to display before the text
  final IconData? icon;

  /// Optional loading state - shows a spinner instead of text/icon
  final bool isLoading;

  /// Override the default border color
  final Color? borderColor;

  /// Override the default text color
  final Color? textColor;

  /// Override the default icon color (defaults to textColor if not specified)
  final Color? iconColor;

  /// Space between icon and text
  final double iconSpacing;

  /// Border radius for the button
  final double borderRadius;

  /// Width of the border
  final double borderWidth;

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

  /// Optional background color
  final Color? backgroundColor;

  const CustomOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.borderColor,
    this.textColor,
    this.iconColor,
    this.iconSpacing = 8.0,
    this.borderRadius = 8.0,
    this.borderWidth = 1.5,
    this.elevation = 0,
    this.padding,
    this.textStyle,
    this.iconSize,
    this.width,
    this.height,
    this.minimumSize,
    this.enableFeedback = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Default colors based on theme
    final defaultBorderColor = theme.colorScheme.primary;
    final defaultTextColor = theme.colorScheme.primary;

    // Use provided colors or fall back to defaults
    final bdColor = borderColor ?? defaultBorderColor;
    final txtColor = textColor ?? defaultTextColor;
    final icnColor = iconColor ?? txtColor;
    final bgColor = backgroundColor ?? Colors.transparent;

    // Determine padding based on whether an icon is present
    final buttonPadding = padding ??
        EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        );

    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: txtColor,
          backgroundColor: bgColor,
          elevation: elevation,
          padding: buttonPadding,
          side: BorderSide(
            color: bdColor,
            width: borderWidth,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          minimumSize: minimumSize,
          disabledForegroundColor: txtColor.withOpacity(0.6),
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
}

/// A convenience extension providing common button configurations
extension CustomOutlinedButtonExtensions on CustomOutlinedButton {
  /// Creates a primary outlined button
  static CustomOutlinedButton primary({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isLoading = false,
    BuildContext? context,
  }) {
    final theme = context != null ? Theme.of(context) : null;
    final defaultColor = theme?.colorScheme.primary;

    return CustomOutlinedButton(
      text: text,
      onPressed: onPressed,
      icon: icon,
      isLoading: isLoading,
      borderColor: defaultColor,
      textColor: defaultColor,
      borderRadius: 8.0,
      borderWidth: 1.5,
      // Other properties use defaults
    );
  }

  /// Creates a small outlined button suitable for toolbars
  static CustomOutlinedButton small({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isLoading = false,
    BuildContext? context,
  }) {
    final theme = context != null ? Theme.of(context) : null;
    final defaultColor = theme?.colorScheme.primary;

    return CustomOutlinedButton(
      text: text,
      onPressed: onPressed,
      icon: icon,
      isLoading: isLoading,
      borderColor: defaultColor,
      textColor: defaultColor,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      iconSize: 18,
      textStyle: TextStyle(fontSize: 14),
      borderRadius: 8.0,
      borderWidth: 1.0,
      // Other properties use defaults
    );
  }

  /// Creates a large outlined button for prominent actions
  static CustomOutlinedButton large({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isLoading = false,
    BuildContext? context,
  }) {
    final theme = context != null ? Theme.of(context) : null;
    final defaultColor = theme?.colorScheme.primary;

    return CustomOutlinedButton(
      text: text,
      onPressed: onPressed,
      icon: icon,
      isLoading: isLoading,
      borderColor: defaultColor,
      textColor: defaultColor,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      iconSize: 24,
      borderRadius: 12.0,
      borderWidth: 2.0,
      // Other properties use defaults
    );
  }

  /// Creates a secondary outlined button
  static CustomOutlinedButton secondary({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isLoading = false,
    BuildContext? context,
  }) {
    final theme = context != null ? Theme.of(context) : null;
    final defaultColor = theme?.colorScheme.secondary;

    return CustomOutlinedButton(
      text: text,
      onPressed: onPressed,
      icon: icon,
      isLoading: isLoading,
      borderColor: defaultColor,
      textColor: defaultColor,
      // Other properties use defaults
    );
  }

  /// Creates a destructive outlined button for dangerous actions
  static CustomOutlinedButton destructive({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isLoading = false,
    BuildContext? context,
  }) {
    final theme = context != null ? Theme.of(context) : null;
    final defaultColor = theme?.colorScheme.error ?? Colors.red;

    return CustomOutlinedButton(
      text: text,
      onPressed: onPressed,
      icon: icon,
      isLoading: isLoading,
      borderColor: defaultColor,
      textColor: defaultColor,
      // Other properties use defaults
    );
  }
}
