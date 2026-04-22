// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:clean_flutter/src/core/utils/app_utils_exports.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart'; // Adjust the import based on your project structure.

class AppIndicator extends StatelessWidget {
  const AppIndicator({
    super.key,
    required this.isActive,
    this.activeColor,
    this.inActiveColor,
    this.height,
    this.width,
    this.margin,
  });
  final bool isActive;
  final double? width, height;
  final Color? activeColor, inActiveColor;
  final EdgeInsetsGeometry? margin;
  @override
  Widget build(BuildContext context) {
    final activeIndicatorColor = (activeColor ?? AppColors.primary300);
    final inactiveIndicatorColor = (inActiveColor ?? AppColors.neutral50);
    final indicatorColor =
        isActive ? activeIndicatorColor : inactiveIndicatorColor;
    return AnimatedContainer(
      margin: margin ?? EdgeInsets.only(left: 8.w),
      duration: const Duration(milliseconds: 350),
      width: width ?? (isActive ? 24.w : 8.w),
      height: height ?? 8.h,
      decoration: BoxDecoration(
        color: indicatorColor,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
