// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: GoogleFonts.arimo().fontFamily,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.white, elevation: 0),
    splashFactory: NoSplash.splashFactory,
    highlightColor: AppColors.transparent,
    scaffoldBackgroundColor: AppColors.fintechLightBackground,
    colorScheme: ColorScheme.light(
      primary: AppColors.fintechBlue,
      onPrimary: AppColors.white,
      secondary: AppColors.fintechBlueSoft,
      onSecondary: AppColors.white,
      tertiary: AppColors.fintechLightTextSecondary,
      onTertiary: AppColors.fintechLightTextSecondary,
      inverseSurface: AppColors.fintechLightTextPrimary,
      onInverseSurface: AppColors.fintechLightTextPrimary,
      inversePrimary: AppColors.fintechLightSurfaceMuted,
      surface: AppColors.fintechLightSurface,
      onSurface: AppColors.fintechLightTextPrimary,
      brightness: Brightness.light,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.fintechLightSurface,
    ),
    iconTheme: IconThemeData(color: AppColors.fintechLightTextPrimary),
    textTheme: TextTheme(
      bodyLarge: AppTextStyle.bodyLarge,
      bodyMedium: AppTextStyle.bodyMedium,
      bodySmall: AppTextStyle.bodySmall,
      displaySmall: AppTextStyle.displaySmall,
      headlineLarge: AppTextStyle.headlineLarge,
      headlineSmall: AppTextStyle.headlineSmall,
      labelLarge: AppTextStyle.labelLarge,
      labelMedium: AppTextStyle.labelMedium,
      titleLarge: AppTextStyle.titleLarge,
      titleMedium: AppTextStyle.titleMedium,
      titleSmall: AppTextStyle.titleSmall,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.arimo().fontFamily,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.fintechDarkBackground,
      elevation: 0,
    ),
    scaffoldBackgroundColor: AppColors.fintechDarkBackground,
    colorScheme: ColorScheme.dark(
      primary: AppColors.fintechBlue,
      onPrimary: AppColors.white,
      secondary: AppColors.fintechBlueSoft,
      onSecondary: AppColors.white,
      tertiary: AppColors.fintechDarkTextSecondary,
      onTertiary: AppColors.fintechDarkTextSecondary,
      inverseSurface: AppColors.fintechDarkTextPrimary,
      onInverseSurface: AppColors.fintechDarkTextPrimary,
      inversePrimary: AppColors.fintechDarkSurfaceMuted,
      surface: AppColors.fintechDarkSurface,
      onSurface: AppColors.fintechDarkTextPrimary,
      brightness: Brightness.dark,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.fintechDarkSurface,
    ),
    iconTheme: IconThemeData(color: AppColors.fintechDarkTextPrimary),
    splashFactory: NoSplash.splashFactory,
    highlightColor: AppColors.transparent,
    textTheme: TextTheme(
      bodyLarge: AppTextStyle.bodyLarge,
      bodyMedium: AppTextStyle.bodyMedium,
      bodySmall: AppTextStyle.bodySmall,
      displaySmall: AppTextStyle.displaySmall,
      headlineLarge: AppTextStyle.headlineLarge,
      headlineSmall: AppTextStyle.headlineSmall,
      labelLarge: AppTextStyle.labelLarge,
      labelMedium: AppTextStyle.labelMedium,
      titleLarge: AppTextStyle.titleLarge,
      titleMedium: AppTextStyle.titleMedium,
      titleSmall: AppTextStyle.titleSmall,
    ),
  );
}
