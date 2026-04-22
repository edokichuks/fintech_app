// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

// THIS IS THE ICON CONTAINER THAT PROVIDES THE
// THEMED BACKGROUND (light and dark mode)
class AppIconContainer extends StatelessWidget {
  const AppIconContainer({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.padding,
    this.alignment,
    this.borderRadius,
  });
  final double? height, width;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Alignment? alignment;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLightMode = theme.brightness == Brightness.light;
    final color = isLightMode
        ? AppColors.defaultBackgroundLight
        : AppColors.charcoalGrey;
    return AppContainer(
      height: height ?? 32.h,
      width: width ?? 28.w,
      padding: padding ?? EdgeInsets.zero,
      alignment: alignment ?? Alignment.center,
      borderRadius: borderRadius ?? BorderRadius.circular(4),
      color: color,
      child: child,
    );
  }
}
