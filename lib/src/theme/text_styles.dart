// Text Styles

// To make it clear which weight we are using, we'll define the weight even for regular
// fonts
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_app_2/src/theme/app_colors.dart';

TextStyle heading1Style = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.w400,
  color: AppColors.kcTextColor,
);

TextStyle heading2Style = TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.w600,
  color: AppColors.kcTextColor,
);

TextStyle heading3Style = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w600,
  color: AppColors.kcTextColor,
);
TextStyle heading4Style = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: AppColors.kcTextColor,
);

TextStyle headlineStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.w700,
  color: AppColors.kcTextColor,
);

TextStyle bodyStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: AppColors.kcTextColor,
);
TextStyle bodyStyle2 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: AppColors.kcTextColor,
);

TextStyle subheadingStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w400,
  color: AppColors.kcLightTextColor,
);

TextStyle captionStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: AppColors.kcLightTextColor,
);

TextStyle statusTextStyle = heading4Style.copyWith(
  fontFamily: 'Spectral',
  color: Colors.grey.shade600,
  fontWeight: FontWeight.w300,
);

TextStyle nameTextStyle = headlineStyle.copyWith(
  fontFamily: 'Roboto',
  color: AppColors.kcMediumGreyColor,
);

TextStyle statLabelTextStyle = bodyStyle.copyWith(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w200,
);

TextStyle statCountTextStyle = const TextStyle(
  color: Colors.black54,
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
);

TextStyle bioTextStyle = bodyStyle.copyWith(
  fontFamily: 'Spectral',
  fontWeight: FontWeight.w400, //try changing weight to w500 if not thin
  fontStyle: FontStyle.italic,
  color: const Color(0xFF799497),
);

TextTheme buildTextTheme(TextTheme base, Color color) {
  // Define the font family here
  const String fontFamily = 'Lato';

  // Helper function to apply common properties
  TextStyle getTextStyle(
      double fontSize, FontWeight fontWeight, double letterSpacing) {
    return GoogleFonts.getFont(
      fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      color: color,
    );
  }

  return base.copyWith(
    displayLarge: getTextStyle(57, FontWeight.w400, -0.25),
    displayMedium: getTextStyle(45, FontWeight.w400, 0),
    displaySmall: getTextStyle(36, FontWeight.w400, 0),
    headlineLarge: getTextStyle(32, FontWeight.w400, 0),
    headlineMedium: getTextStyle(28, FontWeight.w400, 0),
    headlineSmall: getTextStyle(24, FontWeight.w400, 0),
    titleLarge: getTextStyle(22, FontWeight.w500, 0),
    titleMedium: getTextStyle(16, FontWeight.w500, 0.15),
    titleSmall: getTextStyle(14, FontWeight.w500, 0.1),
    bodyLarge: getTextStyle(16, FontWeight.w400, 0.5),
    bodyMedium: getTextStyle(14, FontWeight.w400, 0.25),
    bodySmall: getTextStyle(12, FontWeight.w400, 0.4),
    labelLarge: getTextStyle(14, FontWeight.w500, 0.1),
    labelMedium: getTextStyle(12, FontWeight.w500, 0.5),
    labelSmall: getTextStyle(11, FontWeight.w500, 0.5),
  );
}
