// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.width,
    this.height,
    this.fit,
    this.trackOutlineColor,
    this.trackOutlineWidth,
  });
  final void Function(bool switchValue) onChanged;
  final bool value;
  final double? height, width, trackOutlineWidth;
  final BoxFit? fit;
  final Color? trackOutlineColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 30.w,
      height: height ?? 18.h,
      child: FittedBox(
        fit: fit ?? BoxFit.cover,
        child: Switch(
          value: value,
          activeTrackColor: AppColors.primary300,
          inactiveTrackColor: AppColors.neutral100,
          trackOutlineWidth: WidgetStatePropertyAll(trackOutlineWidth ?? 0),
          trackOutlineColor: WidgetStatePropertyAll(
            trackOutlineColor ?? AppColors.transparent,
          ),
          //THIS STOPS THE SWITCH FROM REDUCING IT'S SIZE
          //WHEN IN ACTIVE
          thumbIcon: const WidgetStatePropertyAll(Icon(null)),
          activeThumbColor: AppColors.white,
          inactiveThumbColor: AppColors.white,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
