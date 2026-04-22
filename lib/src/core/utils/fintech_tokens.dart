// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:fintech_app/src/core/utils/app_colors.dart';

class FintechSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;
}

class FintechRadius {
  static const double pill = 999;
  static const double button = 14;
  static const double card = 22;
  static const double panel = 20;
  static const double drawer = 26;
}

class FintechDurations {
  static const Duration press = Duration(milliseconds: 160);
  static const Duration content = Duration(milliseconds: 420);
  static const Duration stagger = Duration(milliseconds: 100);
}

class FintechColors {
  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color scaffold(BuildContext context) => isDark(context)
      ? AppColors.fintechDarkBackground
      : AppColors.fintechLightBackground;

  static Color surface(BuildContext context) => isDark(context)
      ? AppColors.fintechDarkSurface
      : AppColors.fintechLightSurface;

  static Color mutedSurface(BuildContext context) => isDark(context)
      ? AppColors.fintechDarkSurfaceMuted
      : AppColors.fintechLightSurfaceMuted;

  static Color card(BuildContext context) => isDark(context)
      ? AppColors.fintechDarkCard
      : AppColors.fintechLightCard;

  static Color border(BuildContext context) => isDark(context)
      ? AppColors.fintechDarkBorder
      : AppColors.fintechLightBorder;

  static Color textPrimary(BuildContext context) => isDark(context)
      ? AppColors.fintechDarkTextPrimary
      : AppColors.fintechLightTextPrimary;

  static Color textSecondary(BuildContext context) => isDark(context)
      ? AppColors.fintechDarkTextSecondary
      : AppColors.fintechLightTextSecondary;

  static Color textMuted(BuildContext context) => isDark(context)
      ? AppColors.fintechDarkTextMuted
      : AppColors.fintechLightTextMuted;

  static Color scrim(BuildContext context) =>
      (isDark(context) ? AppColors.fintechDarkScrim : AppColors.fintechLightScrim)
          .withValues(alpha: 0.72);
}
