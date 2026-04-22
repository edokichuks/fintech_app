import 'package:clean_flutter/gen/assets.gen.dart';
import 'package:clean_flutter/src/core/extensions/navigation_extensions.dart';
import 'package:clean_flutter/src/core/utils/app_utils_exports.dart';
import 'package:clean_flutter/src/general_widgets/general_widget_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthFlowHeader extends StatelessWidget {
  final int currentStep;
  final VoidCallback? onBack;

  const AuthFlowHeader({super.key, required this.currentStep, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack ?? () => context.pop(),
            child: const Icon(Icons.arrow_back, size: 24),
          ),
          Spacing.width(16.w),
          Expanded(
            child: Row(
              children: List.generate(4, (index) {
                final isCompleted = index < currentStep;
                return Expanded(
                  child: Container(
                    height: 4.h,
                    margin: EdgeInsets.symmetric(horizontal: 2.w),
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? AppColors.secondary300
                          : AppColors.neutral50,
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                  ),
                );
              }),
            ),
          ),
          Spacing.width(16.w),
          SvgPicture.asset(Assets.images.svg.hintIcon, width: 24, height: 24),
        ],
      ),
    );
  }
}
