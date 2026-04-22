// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:clean_flutter/src/core/utils/app_utils_exports.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: AppColors.white, elevation: 0),
    splashFactory: NoSplash.splashFactory,
    highlightColor: AppColors.transparent,
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary300,
      onPrimary: AppColors.primary300,
      secondary: AppColors.secondary300,
      onSecondary: AppColors.secondary300,
      tertiary: AppColors.neutral200,
      onTertiary: AppColors.neutral200,
      inverseSurface: AppColors.defaultBG,
      onInverseSurface: AppColors.defaultBG,
      inversePrimary: AppColors.greyMobile,
      brightness: Brightness.light,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
    ),
    iconTheme: IconThemeData(color: AppColors.neutral500),
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
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.neutral500,
      elevation: 0,
    ),
    scaffoldBackgroundColor: AppColors.defaultBG,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryDark300,
      onPrimary: AppColors.primaryDark300,
      secondary: AppColors.secondaryDark300,
      onSecondary: AppColors.secondaryDark300,
      tertiary: AppColors.neutral50, //USED FOR BOTTOMSHEET
      onTertiary: AppColors.neutral50, //USED FOR BOTTOMSHEET or text
      inverseSurface: AppColors.white,
      onInverseSurface: AppColors.white,
      inversePrimary: AppColors.darkgreyMobile,
      brightness: Brightness.dark,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.defaultBackgroundDark,
    ),
    iconTheme: IconThemeData(color: AppColors.white),
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
