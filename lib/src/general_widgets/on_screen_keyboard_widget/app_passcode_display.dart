// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

class AppPasscodeDisplay extends StatelessWidget {
  const AppPasscodeDisplay({
    super.key,
    this.contentWidget,
    this.obscuringCharacter,
    this.width,
    this.spacing,
    this.height,
    this.decoration,
    this.borderRadius,
    this.border,
    this.error = false,
  });

  final bool error;
  final Widget? contentWidget;
  final double? width, height, spacing;
  final BoxDecoration? decoration;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final String? obscuringCharacter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppContainer(
      //THE SPACING BETWEEN EACH WIDGET
      margin: EdgeInsets.only(right: spacing ?? 8.w),
      alignment: Alignment.center,
      padding: EdgeInsets.zero,
      width: width ?? 44.w,
      height: height ?? 44.w,
      decoration: BoxDecoration(
        border:
            border ??
            Border.all(
              color: error ? AppColors.danger200 : AppColors.transparent,
              width: error ? 1 : 0,
            ),
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        color: theme.colorScheme.primary,
      ),
      child:
          contentWidget ??
          AppText(
            text: obscuringCharacter ?? "＊",
            style: AppTextStyle.bodySmall.copyWith(
              color: error ? AppColors.danger200 : null,
            ),
            textAlign: TextAlign.center,
          ),
    );
  }
}
