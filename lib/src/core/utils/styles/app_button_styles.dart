// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../app_utils_exports.dart';

class AppButtonStyle {
  final Color background;
  final Color textColor;
  final Color borderColor;
  final Color disabledBackgroundColor;
  final Color disabledTextColor;
  final TextStyle? textStyle;

  ///Button default values
  static const double buttonDefaultHeight = 54.0;
  static const double buttonDefaultWidth = double.infinity;
  static const double badgeDefaultHeight = 20.0;
  static const double badgeDefaultWidth = 46.0;
  static const double buttonCornerRadius = 1000.0;
  static const double badgeCornerRadius = 100.0;
  static const bool buttonIsEnable = true;
  static const bool buttonIsLoading = false;

  AppButtonStyle({
    required this.background,
    required this.textColor,
    required this.borderColor,
    required this.disabledBackgroundColor,
    required this.disabledTextColor,
    this.textStyle,
  });

  factory AppButtonStyle.primary() = AppButtonPrimary;

  factory AppButtonStyle.secondary() = AppButtonSecondary;
}

class AppButtonPrimary extends AppButtonStyle {
  AppButtonPrimary()
    : super(
        background: AppColors.white,
        disabledBackgroundColor: AppColors.neutral50,
        textColor: AppColors.primary300,
        disabledTextColor: AppColors.white,
        borderColor: Colors.transparent,
      );
}

class AppButtonSecondary extends AppButtonStyle {
  AppButtonSecondary()
    : super(
        background: AppColors.white,
        disabledBackgroundColor: AppColors.neutral50,
        textColor: AppColors.primary300,
        disabledTextColor: AppColors.neutral50,
        borderColor: AppColors.primary300,
      );
}
