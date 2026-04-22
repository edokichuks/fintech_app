// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

// Project imports:
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/general_widgets/app_button.dart';
import 'package:fintech_app/src/general_widgets/app_scaffold.dart';
import 'package:fintech_app/src/general_widgets/app_text.dart';

class FintechErrorView extends StatelessWidget {
  const FintechErrorView({
    required this.message,
    required this.onRetry,
    super.key,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      applySafeArea: false,
      backgroundColor: FintechColors.scaffold(context),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 68.w,
              height: 68.h,
              decoration: BoxDecoration(
                color: FintechColors.surface(context),
                shape: BoxShape.circle,
              ),
              child: Icon(
                LucideIcons.circleAlert400,
                color: AppColors.fintechDanger,
                size: 30.r,
              ),
            ),
            SizedBox(height: FintechSpacing.lg.h),
            AppText(
              text: 'Something went wrong',
              style: AppTextStyle.titleLarge.copyWith(
                color: FintechColors.textPrimary(context),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: FintechSpacing.xs.h),
            AppText(
              text: message,
              style: AppTextStyle.bodySmall.copyWith(
                color: FintechColors.textSecondary(context),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: FintechSpacing.xl.h),
            SizedBox(
              width: 160.w,
              child: AppButton(
                text: 'Retry',
                onPressed: onRetry,
                cornerRadius: FintechRadius.button.r,
                buttonStyle: _RetryButtonStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RetryButtonStyle extends AppButtonStyle {
  _RetryButtonStyle()
    : super(
        background: AppColors.fintechBlue,
        textColor: AppColors.white,
        borderColor: AppColors.transparent,
        disabledBackgroundColor: AppColors.fintechBlue.withValues(alpha: 0.45),
        disabledTextColor: AppColors.white,
        textStyle: AppTextStyle.bodySmall.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w700,
        ),
      );
}
