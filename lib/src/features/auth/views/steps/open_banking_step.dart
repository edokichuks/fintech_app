import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OpenBankingStep extends ConsumerWidget {
  final VoidCallback onNext;

  const OpenBankingStep({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacing.height(8.h),
          AppText(
            text: 'Connect your bank\nsecurely',
            style: AppTextStyle.headlineSmall.copyWith(
              color: AppColors.neutral500,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          Spacing.height(12.h),
          AppText(
            text:
                'We\'ll use Open Banking to confirm your salary deposits, '
                'account ownership, and pay schedule. Please be rest '
                'assured it\'s a safe process:',
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.neutral200,
              height: 1.5,
            ),
          ),

          Spacing.height(48.h),

          // Folder/Bank Connection Illustration Placeholder
          Center(
            child: Container(
              height: 200.h,
              width: 200.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary50.withValues(alpha: 0.5),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.folder_copy,
                    size: 100.r,
                    color: AppColors.primary300,
                  ),
                  Positioned(
                    top: 20,
                    right: 40,
                    child: Icon(
                      Icons.star,
                      color: AppColors.secondary500,
                      size: 20.r,
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Icon(
                      Icons.star_border,
                      color: AppColors.primary200,
                      size: 24.r,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Spacing.height(40.h),

          _buildChecklistItem('Bank-level security'),
          Spacing.height(16.h),
          _buildChecklistItem('No access to spend your money'),
          Spacing.height(16.h),
          _buildChecklistItem('Verification only'),

          Spacing.height(48.h),

          AppButton(
            text: 'Connect Your Bank',
            leading: Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Icon(
                Icons.open_in_new,
                color: AppColors.white,
                size: 18.sp,
              ),
            ),
            onPressed: () {
              // Final Step action
              onNext();
            },
          ),

          Spacing.height(32.h),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(String title) {
    return Row(
      children: [
        Icon(Icons.check, color: AppColors.secondary300, size: 24.sp),
        Spacing.width(16.w),
        AppText(
          text: title,
          style: AppTextStyle.bodyMedium.copyWith(
            color: AppColors.neutral500,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
