import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.color,
    this.isLoading = false,
  });
  final String text;
  final IconData? icon;
  final Color? color;
  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final style = TextButton.styleFrom(
      backgroundColor: color,
    );

    final child = AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: isLoading
          ? const CircularProgressIndicator()
          : Text(
              text.toUpperCase(),
              textAlign: TextAlign.center,
            ),
    );

    if (icon != null) {
      return TextButton.icon(
        style: style,
        onPressed: onPressed,
        icon: Icon(icon),
        label: Expanded(child: child),
      );
    }
    return TextButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
