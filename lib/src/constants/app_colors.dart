import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:social_app_2/src/extensions/as_html_color_to_color.dart';

class AppColors {
  // https://rydmike.com/flexcolorscheme/themesplayground-latest/
  // Bahama Blue colors:
  static const primary = Color(0xFF285C99);
  static const heart = Color(0xFFDD520F);
  static const error = Color(0xFFB1384E);

  static Color greyShade200(bool isLight) =>
      isLight ? Colors.grey.shade200 : Colors.grey.shade900;
  static Color greyShade300(bool isLight) =>
      isLight ? Colors.grey.shade300 : Colors.grey.shade800;
  static Color greyShade400(bool isLight) =>
      isLight ? Colors.grey.shade400 : Colors.grey.shade700;
  static Color greyShade500(bool isLight) =>
      isLight ? Colors.grey.shade500 : Colors.grey.shade600;

  static const flexScheme = FlexScheme.bahamaBlue;

  // Auth Screen Colors
  static final kcLoginButtonColor = '#cfc9c2'.htmlColorToColor();
  static final kcLoginButtonColorTextColor = '#000000'.htmlColorToColor();
  static final kcGoogleColor = '#4285F4'.htmlColorToColor();
  static final kcFacebookColor = '#3b5998'.htmlColorToColor();
  static final primaryColor = '#8E4954'.htmlColorToColor();

  static final kcPrimaryColor = '#40C0E8'.htmlColorToColor();
  static final kcMediumGreyColor = '#868686'.htmlColorToColor();
  static final kcLightGreyColor = '#e5e5e5'.htmlColorToColor();
  static final kcVeryLightGreyColor = '#f2f2f2'.htmlColorToColor();
  static final kcLightTextColor = '#827379'.htmlColorToColor();
  static final kcTextColor = '#1f1a1c'.htmlColorToColor();
  static final kcRedColor = '#ff0000'.htmlColorToColor();
  static final kcCharcoalGray = '#333333'.htmlColorToColor();
  static final kcWhiteColor = '#fffbff'.htmlColorToColor();
  static final kcAppBarBackgroundColor = '#ffffff'.htmlColorToColor();
  static final kcScaffoldBackgroundColor = '#ffffff'.htmlColorToColor();
  static final kcAppTitleColor = '#604F6D'.htmlColorToColor();
  static final kcBottomBarColor = '#f2e2e5'.htmlColorToColor();
  static final kcBottomBarInactiveColor = '#604f6d'.htmlColorToColor();
  static final kcLightBlackColor = '#3d3f45'.htmlColorToColor();
  static final kcBlackColor = '#000000'.htmlColorToColor();

  /// Light Mode
  static final kcLightPrimaryColor = "#09677F".htmlColorToColor();
  static final kcLightSurfaceTintColor = "#09677F".htmlColorToColor();
  static final kcLightOnPrimaryColor = "#FFFFFF".htmlColorToColor();
  static final kcLightPrimaryContainerColor = "#B8EAFF".htmlColorToColor();
  static final kcLightOnPrimaryContainerColor = "#001F29".htmlColorToColor();
  static final kcLightSecondaryColor = "#4C626B".htmlColorToColor();
  static final kcLightOnSecondaryColor = "#071E26".htmlColorToColor();
  static final kcLightSecondaryContainerColor = "#CFE6F1".htmlColorToColor();
  static final kcLightOnSecondaryContainerColor = "#071E26".htmlColorToColor();
  static final kcLightTertiaryColor = "#5B5B7E".htmlColorToColor();
  static final kcLightOnTertiaryColor = "#FFFFFF".htmlColorToColor();
  static final kcLightTertiaryContainerColor = "#E1E0FF".htmlColorToColor();
  static final kcLightOnTertiaryContainerColor = "#171837".htmlColorToColor();
  static final kcLightErrorColor = "#BA1A1A".htmlColorToColor();
  static final kcLightOnErrorColor = "#FFFFFF".htmlColorToColor();
  static final kcLightErrorContainerColor = "#FFDAD6".htmlColorToColor();
  static final kcLightOnErrorConTintColor = "#410002".htmlColorToColor();
  static final kcLightBackgroundColor = "#F5FAFD".htmlColorToColor();
  static final kcLightOnBackgroundColor = "#171C1F".htmlColorToColor();
  static final kcLightSurfaceColor = "#F5FAFD".htmlColorToColor();
  static final kcLightOnSurfaceColor = "#171C1F".htmlColorToColor();
  static final kcLightSurfaceVariantColor = "#DCE4E8".htmlColorToColor();
  static final kcLightOnSurfaceVariantColor = "#40484C".htmlColorToColor();
  static final kcLightOutlineColor = "#70787C".htmlColorToColor();
  static final kcLightOutlineVariantColor = "#BFC8CC".htmlColorToColor();
  static final kcLightShadowColor = "#000000".htmlColorToColor();
  static final kcLightScrimColor = "#000000".htmlColorToColor();
  static final kcLightInverseSurfaceColor = "#2C3134".htmlColorToColor();
  static final kcLightOnInverseSurfaceColor = "#EDF1F4".htmlColorToColor();
  static final kcLightInversePrimaryColor = "#88D0ED".htmlColorToColor();
  static final kcLightPrimaryFixedColor = "#B8EAFF".htmlColorToColor();
  static final kcLightOnPrimaryFixedColor = "#001F29".htmlColorToColor();
  static final kcLightPrimaryFixedDimColor = "#88D0ED".htmlColorToColor();
  static final kcLightOnPrimaryFixedVariantColor = "#004D61".htmlColorToColor();
  static final kcLightSecondFixedColor = "#CFE6F1".htmlColorToColor();
  static final kcLightOnSecondFixedColor = "#071E26".htmlColorToColor();
  static final kcLightSecondFixedDimColor = "#B3CAD5".htmlColorToColor();
  static final kcLightOnSecondFixedVariantColor = "#354A53".htmlColorToColor();
  static final kcLightTertiaryFixedColor = "#E1E0FF".htmlColorToColor();
  static final kcLightOnTertiaryFixedColor = "#171837".htmlColorToColor();
  static final kcLightTertiaryFixedDimColor = "#C4C3EB".htmlColorToColor();
  static final kcLightOnTertiaryFixedVariantColor =
      "#434465".htmlColorToColor();
  static final kcLightSurfaceDimColor = "#D6DBDE".htmlColorToColor();
  static final kcLightSurfaceBrightColor = "#F5FAFD".htmlColorToColor();
  static final kcLightSurfaceContainerLowestColor =
      "#FFFFFF".htmlColorToColor();
  static final kcLightSurfaceContainerLowColor = "#F0F4F7".htmlColorToColor();
  static final kcLightSurfaceContainerColor = "#EAEEF2".htmlColorToColor();
  static final kcLightSurfaceContainerHighColor = "#E4E9EC".htmlColorToColor();
  static final kcLightSurfaceContainerHighestColor =
      "#DEE3E6".htmlColorToColor();

  /// Dark Mode
  static final kcDarkPrimaryColor = "#88D0ED".htmlColorToColor();
  static final kcDarkSurfaceTintColor = "#88D0ED".htmlColorToColor();
  static final kcDarkOnPrimaryColor = "#003544".htmlColorToColor();
  static final kcDarkPrimaryContainerColor = "#004D61".htmlColorToColor();
  static final kcDarkOnPrimaryContainerColor = "#B8EAFF".htmlColorToColor();
  static final kcDarkSecondaryColor = "#B3CAD5".htmlColorToColor();
  static final kcDarkOnSecondaryColor = "#1E333C".htmlColorToColor();
  static final kcDarkSecondaryContainerColor = "#354A53".htmlColorToColor();
  static final kcDarkOnSecondaryContainerColor = "#CFE6F1".htmlColorToColor();
  static final kcDarkTertiaryColor = "#C4C3EB".htmlColorToColor();
  static final kcDarkOnTertiaryColor = "#2C2D4D".htmlColorToColor();
  static final kcDarkTertiaryContainerColor = "#434465".htmlColorToColor();
  static final kcDarkOnTertiaryContainerColor = "#E1E0FF".htmlColorToColor();
  static final kcDarkErrorColor = "#FFB4AB".htmlColorToColor();
  static final kcDarkOnErrorColor = "#690005".htmlColorToColor();
  static final kcDarkErrorContainerColor = "#93000A".htmlColorToColor();
  static final kcDarkOnErrorConTintColor = "#FFDAD6".htmlColorToColor();
  static final kcDarkBackgroundColor = "#0F1416".htmlColorToColor();
  static final kcDarkOnBackgroundColor = "#DEE3E6".htmlColorToColor();
  static final kcDarkSurfaceColor = "#0F1416".htmlColorToColor();
  static final kcDarkOnSurfaceColor = "#DEE3E6".htmlColorToColor();
  static final kcDarkSurfaceVariantColor = "#40484C".htmlColorToColor();
  static final kcDarkOnSurfaceVariantColor = "#BFC8CC".htmlColorToColor();
  static final kcDarkOutlineColor = "#8A9296".htmlColorToColor();
  static final kcDarkOutlineVariantColor = "#40484C".htmlColorToColor();
  static final kcDarkShadowColor = "#000000".htmlColorToColor();
  static final kcDarkScrimColor = "#000000".htmlColorToColor();
  static final kcDarkInverseSurfaceColor = "#DEE3E6".htmlColorToColor();
  static final kcDarkOnInverseSurfaceColor = "#2C3134".htmlColorToColor();
  static final kcDarkInversePrimaryColor = "#09677F".htmlColorToColor();
  static final kcDarkPrimaryFixedColor = "#B8EAFF".htmlColorToColor();
  static final kcDarkOnPrimaryFixedColor = "#001F29".htmlColorToColor();
  static final kcDarkPrimaryFixedDimColor = "#88D0ED".htmlColorToColor();
  static final kcDarkOnPrimaryFixedVariantColor = "#004D61".htmlColorToColor();
  static final kcDarkSecondFixedColor = "#CFE6F1".htmlColorToColor();
  static final kcDarkOnSecondFixedColor = "#071E26".htmlColorToColor();
  static final kcDarkSecondFixedDimColor = "#B3CAD5".htmlColorToColor();
  static final kcDarkOnSecondFixedVariantColor = "#354A53".htmlColorToColor();
  static final kcDarkTertiaryFixedColor = "#E1E0FF".htmlColorToColor();
  static final kcDarkOnTertiaryFixedColor = "#171837".htmlColorToColor();
  static final kcDarkTertiaryFixedDimColor = "#C4C3EB".htmlColorToColor();
  static final kcDarkOnTertiaryFixedVariantColor = "#434465".htmlColorToColor();
  static final kcDarkSurfaceDimColor = "#0F1416".htmlColorToColor();
  static final kcDarkSurfaceBrightColor = "#353A3D".htmlColorToColor();
  static final kcDarkSurfaceContainerLowestColor = "#0A0F11".htmlColorToColor();
  static final kcDarkSurfaceContainerLowColor = "#171C1F".htmlColorToColor();
  static final kcDarkSurfaceContainerColor = "#1B2023".htmlColorToColor();
  static final kcDarkSurfaceContainerHighColor = "#252B2D".htmlColorToColor();
  static final kcDarkSurfaceContainerHighestColor =
      "#303638".htmlColorToColor();

  // primary palettes
  static final kcPrimary0 = "#000000".htmlColorToColor();
  static final kcPrimary5 = "#00131B".htmlColorToColor();
  static final kcPrimary10 = "#001F29".htmlColorToColor();
  static final kcPrimary15 = "#002A36".htmlColorToColor();
  static final kcPrimary20 = "#003544".htmlColorToColor();
  static final kcPrimary25 = "#004152".htmlColorToColor();
  static final kcPrimary30 = "#004D61".htmlColorToColor();
  static final kcPrimary35 = "#005A71".htmlColorToColor();
  static final kcPrimary40 = "#006780".htmlColorToColor();
  static final kcPrimary50 = "#0082A1".htmlColorToColor();
  static final kcPrimary60 = "#009DC3".htmlColorToColor();
  static final kcPrimary70 = "#35B9E0".htmlColorToColor();
  static final kcPrimary80 = "#5BD5FD".htmlColorToColor();
  static final kcPrimary90 = "#B8EAFF".htmlColorToColor();
  static final kcPrimary95 = "#DEF4FF".htmlColorToColor();
  static final kcPrimary98 = "#F3FBFF".htmlColorToColor();
  static final kcPrimary99 = "#FAFDFF".htmlColorToColor();
  static final kcPrimary100 = "#FFFFFF".htmlColorToColor();

  // secondary palettes
  static final kcSecondary0 = "#000000".htmlColorToColor();
  static final kcSecondary5 = "#00131B".htmlColorToColor();
  static final kcSecondary10 = "#071E26".htmlColorToColor();
  static final kcSecondary15 = "#122931".htmlColorToColor();
  static final kcSecondary20 = "#1D333C".htmlColorToColor();
  static final kcSecondary25 = "#293E47".htmlColorToColor();
  static final kcSecondary30 = "#344A53".htmlColorToColor();
  static final kcSecondary35 = "#40565F".htmlColorToColor();
  static final kcSecondary40 = "#4C626B".htmlColorToColor();
  static final kcSecondary50 = "#647A84".htmlColorToColor();
  static final kcSecondary60 = "#7E949E".htmlColorToColor();
  static final kcSecondary70 = "#98AFB9".htmlColorToColor();
  static final kcSecondary80 = "#B3CAD5".htmlColorToColor();
  static final kcSecondary90 = "#CFE6F1".htmlColorToColor();
  static final kcSecondary95 = "#DEF4FF".htmlColorToColor();
  static final kcSecondary98 = "#F3FBFF".htmlColorToColor();
  static final kcSecondary99 = "#FAFDFF".htmlColorToColor();
  static final kcSecondary100 = "#FFFFFF".htmlColorToColor();

  // tertiary palettes
  static final kcTertiary0 = "#000000".htmlColorToColor();
  static final kcTertiary5 = "#0C0D2C".htmlColorToColor();
  static final kcTertiary10 = "#171837".htmlColorToColor();
  static final kcTertiary15 = "#222342".htmlColorToColor();
  static final kcTertiary20 = "#2C2D4D".htmlColorToColor();
  static final kcTertiary25 = "#373859".htmlColorToColor();
  static final kcTertiary30 = "#434465".htmlColorToColor();
  static final kcTertiary35 = "#4F4F72".htmlColorToColor();
  static final kcTertiary40 = "#5B5B7E".htmlColorToColor();
  static final kcTertiary50 = "#737498".htmlColorToColor();
  static final kcTertiary60 = "#8D8DB3".htmlColorToColor();
  static final kcTertiary70 = "#A8A8CF".htmlColorToColor();
  static final kcTertiary80 = "#C3C3EB".htmlColorToColor();
  static final kcTertiary90 = "#E1E0FF".htmlColorToColor();
  static final kcTertiary95 = "#F2EFFF".htmlColorToColor();
  static final kcTertiary98 = "#FCF8FF".htmlColorToColor();
  static final kcTertiary99 = "#FFFBFF".htmlColorToColor();
  static final kcTertiary100 = "#FFFFFF".htmlColorToColor();

  // neutral palettes
  static final kcNeutral0 = "#000000".htmlColorToColor();
  static final kcNeutral5 = "#0E1113".htmlColorToColor();
  static final kcNeutral10 = "#191C1D".htmlColorToColor();
  static final kcNeutral15 = "#232628".htmlColorToColor();
  static final kcNeutral20 = "#2E3132".htmlColorToColor();
  static final kcNeutral25 = "#393C3D".htmlColorToColor();
  static final kcNeutral30 = "#444749".htmlColorToColor();
  static final kcNeutral35 = "#505354".htmlColorToColor();
  static final kcNeutral40 = "#5C5F60".htmlColorToColor();
  static final kcNeutral50 = "#757779".htmlColorToColor();
  static final kcNeutral60 = "#8F9193".htmlColorToColor();
  static final kcNeutral70 = "#A9ABAD".htmlColorToColor();
  static final kcNeutral80 = "#C5C7C8".htmlColorToColor();
  static final kcNeutral90 = "#E1E3E4".htmlColorToColor();
  static final kcNeutral95 = "#EFF1F2".htmlColorToColor();
  static final kcNeutral98 = "#F8F9FB".htmlColorToColor();
  static final kcNeutral99 = "#FBFCFE".htmlColorToColor();
  static final kcNeutral100 = "#FFFFFF".htmlColorToColor();

  // neutral-variant palettes
  static final kcNeutralVariant0 = "#000000".htmlColorToColor();
  static final kcNeutralVariant5 = "#0A1215".htmlColorToColor();
  static final kcNeutralVariant10 = "#151D20".htmlColorToColor();
  static final kcNeutralVariant15 = "#1F272A".htmlColorToColor();
  static final kcNeutralVariant20 = "#2A3235".htmlColorToColor();
  static final kcNeutralVariant25 = "#353D40".htmlColorToColor();
  static final kcNeutralVariant30 = "#40484C".htmlColorToColor();
  static final kcNeutralVariant35 = "#4B5458".htmlColorToColor();
  static final kcNeutralVariant40 = "#576064".htmlColorToColor();
  static final kcNeutralVariant50 = "#70787C".htmlColorToColor();
  static final kcNeutralVariant60 = "#8A9296".htmlColorToColor();
  static final kcNeutralVariant70 = "#A4ACB1".htmlColorToColor();
  static final kcNeutralVariant80 = "#BFC8CC".htmlColorToColor();
  static final kcNeutralVariant90 = "#DCE4E8".htmlColorToColor();
  static final kcNeutralVariant95 = "#EAF2F7".htmlColorToColor();
  static final kcNeutralVariant98 = "#F3FBFF".htmlColorToColor();
  static final kcNeutralVariant99 = "#FAFDFF".htmlColorToColor();
  static final kcNeutralVariant100 = "#FFFFFF".htmlColorToColor();
}
