import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app_2/src/constants/strings.dart';

/// The scale based on the height of the button
const _appleIconSizeScale = 28 / 48;

class AppleButton extends StatelessWidget {
  const AppleButton({
    super.key,
    this.onPressed,
    this.text = Strings.signInWithApple,
    this.height = 48.0,
    this.isCompact = false,
    this.style = SignInWithAppleButtonStyle.whiteOutlined,
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
  final double height;

  /// Option to show compact button, default is false
  final bool isCompact;

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
    // final fontSize = height != null ? height! * 0.43 : 44 * 0.43;
    final fontSize = height * 0.43;

    final appleIcon = SizedBox(
      width: _appleIconSizeScale * height,
      height: _appleIconSizeScale * height,
      child: Center(
        child: FaIcon(
          FontAwesomeIcons.apple,
          color: _contrastColor,
          size: fontSize,
        ),
      ),
    );

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

    // final appleIcon = Container(
    //   width: _appleIconSizeScale * height!,
    //   height: _appleIconSizeScale * height!,
    //   padding: EdgeInsets.only(
    //     bottom: (12 / 44) * height!,
    //     // width: _appleIconSizeScale * height!,
    //     // height: _appleIconSizeScale * height!,
    //     // padding: EdgeInsets.only(
    //     //   // Properly aligns the Apple icon with the text of the button
    //     //   bottom: (12 / 44) * height!,
    //   ),
    //   child: Center(
    //     child: SizedBox(
    //       width: fontSize * (25 / 31),
    //       height: fontSize,
    //       child: FaIcon(
    //         FontAwesomeIcons.apple,
    //         color: _contrastColor,
    //       ),
    //     ),
    //   ),
    // );

    // var children = <Widget>[];

    // if (isCompact) {
    //   children = [appleIcon];
    // } else {
    //   switch (iconAlignment) {
    //     case IconAlignment.center:
    //       children = [
    //         appleIcon,
    //         const SizedBox(
    //           width: 16.0,
    //         ),
    //         Flexible(child: textWidget),
    //       ];
    //       break;
    //     case IconAlignment.left:
    //       children = [
    //         appleIcon,
    //         Expanded(child: textWidget),
    //         SizedBox(
    //           width: _appleIconSizeScale * height,
    //         ),
    //       ];
    //       break;
    //     default:
    //       children = [
    //         appleIcon,
    //         Flexible(
    //           child: textWidget,
    //         ),
    //       ];
    //       break;
    //   }
    // }

    Widget buttonContent;

    if (isCompact) {
      buttonContent = appleIcon;
    } else {
      buttonContent = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconAlignment == IconAlignment.left) appleIcon,
          if (iconAlignment == IconAlignment.center) ...[
            appleIcon,
            const SizedBox(width: 16.0),
          ],
          Flexible(child: textWidget),
          if (iconAlignment == IconAlignment.left)
            SizedBox(
              width: _appleIconSizeScale * height,
            ),
        ],
      );
    }

    return SizedBox(
      height: height,
      // width: isCompact ? height : null,
      child: CupertinoButton(
        borderRadius: borderRadius,
        padding: EdgeInsets.zero,
        color: _backgroundColor,
        onPressed: onPressed,
        child: Container(
          decoration: _decoration,
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          height: height,
          child: buttonContent,
        ),
      ),
    );
    // return SizedBox(
    //   height: height,
    //   // width: isCompact ? height : null,
    //   child: SizedBox.expand(
    //     child: CupertinoButton(
    //       borderRadius: borderRadius,
    //       padding: EdgeInsets.zero,
    //       color: _backgroundColor,
    //       onPressed: onPressed,
    //       child: Container(
    //         decoration: _decoration,
    //         padding: const EdgeInsets.symmetric(
    //           horizontal: 16.0,
    //         ),
    //         height: height,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: children,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

/// The style of the button according to Apple's documentation.
///
/// https://developer.apple.com/design/human-interface-guidelines/sign-in-with-apple/overview/buttons/
enum SignInWithAppleButtonStyle {
  /// A black button with white text and white icon
  ///
  /// ![Black Button](https://raw.githubusercontent.com/aboutyou/dart_packages/master/packages/sign_in_with_apple/test/sign_in_with_apple_button/goldens/black_button.png)
  black,

  /// A white button with black text and black icon
  ///
  /// ![White Button](https://raw.githubusercontent.com/aboutyou/dart_packages/master/packages/sign_in_with_apple/test/sign_in_with_apple_button/goldens/white_button.png)
  white,

  /// A white button which has a black outline
  ///
  /// ![White Outline Button](https://raw.githubusercontent.com/aboutyou/dart_packages/master/packages/sign_in_with_apple/test/sign_in_with_apple_button/goldens/white_outlined_button.png)
  whiteOutlined,
}

/// This controls the alignment of the Apple Logo on the [SignInWithAppleButton]
enum IconAlignment {
  /// The icon will be centered together with the text
  ///
  /// ![Center Icon Alignment](https://raw.githubusercontent.com/aboutyou/dart_packages/master/packages/sign_in_with_apple/test/sign_in_with_apple_button/goldens/center_aligned_icon.png)
  center,

  /// The icon will be on the left side, while the text will be centered accordingly
  ///
  /// ![Left Icon Alignment](https://raw.githubusercontent.com/aboutyou/dart_packages/master/packages/sign_in_with_apple/test/sign_in_with_apple_button/goldens/left_aligned_icon.png)
  left,
}
