import 'package:flutter/material.dart';

class CustomPrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool isLoading;

  const CustomPrimaryButton({
    super.key,
    required this.onPressed,
    this.text,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ButtonStyle style = ElevatedButton.styleFrom(
      // Adapt to theme:
      foregroundColor: theme.colorScheme.onPrimary,
      backgroundColor: theme.colorScheme.primary,
      // Minimum size for both platforms:
      minimumSize: const Size(88, 48), // Material Design min
      padding: const EdgeInsets.symmetric(horizontal: 16), // Adjust as needed
      // iOS specific styling:
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // iOS typical border radius
      ),
      elevation: 0, // Flat appearance common in iOS
    ).copyWith(
        // Android specific styling:
        // Adjust elevation or other properties if needed for Material 3
        // Or wrap with Material if needed for Material 2 compatibility.
        );

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: style,
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leadingIcon != null) leadingIcon!,
                if (text != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(text!),
                  ),
                if (trailingIcon != null) trailingIcon!,
              ],
            ),
    );
  }
}
