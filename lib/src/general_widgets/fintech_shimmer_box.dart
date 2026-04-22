// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/general_widgets/shimmer.dart';

class FintechShimmer extends StatelessWidget {
  const FintechShimmer({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = FintechColors.isDark(context);

    return Shimmer(
      linearGradient: LinearGradient(
        colors: isDarkMode
            ? <Color>[
                AppColors.fintechDarkSurfaceMuted,
                AppColors.fintechDarkBorder,
                AppColors.fintechDarkSurfaceMuted,
              ]
            : <Color>[
                AppColors.fintechLightSurfaceMuted,
                AppColors.fintechLightBorder,
                AppColors.fintechLightSurfaceMuted,
              ],
        stops: const <double>[0.1, 0.3, 0.4],
        begin: const Alignment(-1, -0.3),
        end: const Alignment(1, 0.3),
      ),
      child: child,
    );
  }
}

class FintechShimmerBox extends StatelessWidget {
  const FintechShimmerBox({
    super.key,
    this.height,
    this.width,
    this.radius,
    this.margin,
  });

  final double? height;
  final double? width;
  final double? radius;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      isLoading: true,
      child: Container(
        height: height ?? 16.h,
        width: width,
        margin: margin,
        decoration: BoxDecoration(
          color: FintechColors.mutedSurface(context),
          borderRadius: BorderRadius.circular(radius ?? 12.r),
        ),
      ),
    );
  }
}
