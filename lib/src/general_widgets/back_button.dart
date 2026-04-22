// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../core/utils/app_colors.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? callback;
  final bool clear;
  final bool hasShadow;
  const AppBackButton(
      {super.key, this.callback, this.clear = false, this.hasShadow = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback ??
          () {
            Navigator.pop(context);
          },
      child: Container(
        height: 30.h,
        width: 30.w,
        decoration: BoxDecoration(
            boxShadow: hasShadow
                ? [
                    BoxShadow(
                        color: AppColors.neutral600.withValues(alpha: .25),
                        spreadRadius: 0,
                        blurRadius: 14,
                        offset: const Offset(-11, 1))
                  ]
                : null,
            color: Theme.of(context).colorScheme.inverseSurface,
            shape: BoxShape.circle),
        child: Icon(
          clear ? Icons.clear : Icons.arrow_back,
          color: AppColors.neutral300,
          size: 19,
        ),
      ),
    );
  }
}
