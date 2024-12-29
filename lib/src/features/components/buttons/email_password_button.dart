import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app_2/src/constants/strings.dart';
import 'package:social_app_2/src/theme/app_colors.dart';

/// The scale based on the height of the button
const _iconSizeScale = 28 / 48;

class EmailPasswordButton extends StatelessWidget {
  const EmailPasswordButton({
    super.key,
    this.onPressed,
    this.text = Strings.signInWithEmailPassword,
    this.height = 48.0,
    this.style = SignInWithAppleButtonStyle.primaryColor,
    this.iconAlignment = IconAlignment.center,
  });

  /// The callback that is be called when the button is pressed.
  final VoidCallback? onPressed;

  /// The text to display next to the Apple logo.
  ///
  /// Defaults to `Sign in with Apple`.
  final String? text;

  /// The height of the button.
  ///
  /// This defaults to `44` according to Apple's guidelines.
  final double? height;

  /// The style of the button.
  ///
  /// Supported options are in line with Apple's guidelines.
  ///
  /// This defaults to [SignInWithAppleButtonStyle.black].
  final SignInWithAppleButtonStyle? style;

  /// The alignment of the Apple logo inside the button.
  ///
  /// This defaults to [IconAlignment.center].
  final IconAlignment? iconAlignment;

  final borderRadius = const BorderRadius.all(Radius.circular(8));

  /// Returns the background color of the button based on the current [style].
  Color get _backgroundColor {
    switch (style) {
      case SignInWithAppleButtonStyle.black:
        return Colors.black;
      case SignInWithAppleButtonStyle.primaryColor:
        return AppColors.kcPrimaryColor;
      case SignInWithAppleButtonStyle.white:
      case SignInWithAppleButtonStyle.whiteOutlined:
        return Colors.white;
      default:
        return Colors.black;
    }
  }

  /// Returns the contrast color to the [_backgroundColor] derived from the current [style].
  ///
  /// This is used for the text and logo color.
  Color get _contrastColor {
    switch (style) {
      case SignInWithAppleButtonStyle.black:
        return Colors.white;
      case SignInWithAppleButtonStyle.primaryColor:
        return Colors.white;
      case SignInWithAppleButtonStyle.white:
      case SignInWithAppleButtonStyle.whiteOutlined:
        return Colors.black;
      default:
        return Colors.black;
    }
  }

  /// The decoration which should be applied to the inner container inside the button
  ///
  /// This allows to customize the border of the button
  Decoration? get _decoration {
    switch (style) {
      case SignInWithAppleButtonStyle.black:
      case SignInWithAppleButtonStyle.white:
        return null;

      case SignInWithAppleButtonStyle.whiteOutlined:
        return BoxDecoration(
          border: Border.all(width: 1, color: _contrastColor),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // per Apple's guidelines
    final fontSize = height != null ? height! * 0.43 : 48 * 0.43;

    final textWidget = Text(
      text!,
      textAlign: TextAlign.center,
      style: TextStyle(
        inherit: false,
        fontSize: fontSize,
        color: _contrastColor,
        // defaults styles aligned with https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/cupertino/text_theme.dart#L16
        fontFamily: 'Roboto-Medium',
        letterSpacing: -0.41,
      ),
    );

    final emailIcon = Container(
      width: _iconSizeScale * height!,
      height: _iconSizeScale * height!,
      padding: const EdgeInsets.only(
          // Properly aligns the Apple icon with the text of the button
          // bottom: (12 / 48) * height!,
          ),
      child: Center(
        child: SizedBox(
          width: fontSize * (25 / 31),
          height: fontSize,
          child: FaIcon(
            FontAwesomeIcons.envelope,
            color: _contrastColor,
          ),
        ),
      ),
    );

    var children = <Widget>[];

    switch (iconAlignment) {
      case IconAlignment.center:
        children = [
          emailIcon,
          const SizedBox(
            width: 16.0,
          ),
          Flexible(
            child: textWidget,
          ),
        ];
        break;
      case IconAlignment.left:
        children = [
          emailIcon,
          Expanded(
            child: textWidget,
          ),
          SizedBox(
            width: _iconSizeScale * height!,
          ),
        ];
        break;
      default:
        children = [
          emailIcon,
          Flexible(
            child: textWidget,
          ),
        ];
        break;
    }

    return SizedBox(
      height: height,
      child: SizedBox.expand(
        child: CupertinoButton(
          borderRadius: borderRadius,
          padding: EdgeInsets.zero,
          color: _backgroundColor,
          onPressed: onPressed,
          child: Container(
            decoration: _decoration,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}

/// The style of the button according to Apple's documentation.
///
/// https://developer.apple.com/design/human-interface-guidelines/sign-in-with-apple/overview/buttons/
enum SignInWithAppleButtonStyle {
  /// A black button with white text and white icon
  black,

  /// A white button with black text and black icon
  white,

  /// A white button which has a black outline
  whiteOutlined,

  /// A button which has a app's primary color
  ///
  primaryColor,
}

/// This controls the alignment of the Apple Logo on the [SignInWithAppleButton]
enum IconAlignment {
  /// The icon will be centered together with the text
  center,

  /// The icon will be on the left side, while the text will be centered accordingly
  left,
}
