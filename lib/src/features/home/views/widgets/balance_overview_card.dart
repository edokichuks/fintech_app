// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

// Project imports:
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

class BalanceOverviewCard extends StatelessWidget {
  const BalanceOverviewCard({required this.balance, super.key});

  final double balance;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(FintechSpacing.xl.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(FintechRadius.card.r),
        border: Border.all(color: FintechColors.border(context)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            FintechColors.card(context),
            FintechColors.surface(context),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppText(
                      text: 'Total Balance',
                      style: AppTextStyle.bodyLarge.copyWith(
                        color: FintechColors.textSecondary(context),
                      ),
                    ),
                    SizedBox(height: FintechSpacing.md.h),
                    AnimatedCurrencyText(
                      value: balance,
                      suffix: '\$',
                      style: AppTextStyle.headlineLarge.copyWith(
                        color: FintechColors.textPrimary(context),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  const _MastercardStamp(),
                  SizedBox(height: 26.h),
                  Container(
                    width: 42.w,
                    height: 42.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: FintechColors.mutedSurface(context),
                    ),
                    child: Icon(
                      LucideIcons.qrCode400,
                      color: FintechColors.textPrimary(context),
                      size: 20.r,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: FintechSpacing.xl.h),
          Row(
            children: <Widget>[
              Expanded(
                child: AppButton(
                  text: 'Add Cash',
                  onPressed: () =>
                      showSuccessToast(message: 'Add Cash coming soon'),
                  cornerRadius: FintechRadius.button.r,
                  leading: Icon(
                    LucideIcons.plus400,
                    color: AppColors.white,
                    size: 16.r,
                  ),
                  buttonStyle: _FintechPrimaryButtonStyle(),
                ),
              ),
              SizedBox(width: FintechSpacing.md.w),
              Expanded(
                child: AppButton(
                  text: 'Send Money',
                  onPressed: () =>
                      showSuccessToast(message: 'Send Money coming soon'),
                  cornerRadius: FintechRadius.button.r,
                  leading: Icon(
                    LucideIcons.arrowUpRight400,
                    color: AppColors.white,
                    size: 16.r,
                  ),
                  buttonStyle: _FintechPrimaryButtonStyle(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FintechPrimaryButtonStyle extends AppButtonStyle {
  _FintechPrimaryButtonStyle()
    : super(
        background: AppColors.fintechBlue,
        textColor: AppColors.white,
        borderColor: AppColors.transparent,
        disabledBackgroundColor: AppColors.fintechBlue.withValues(alpha: 0.5),
        disabledTextColor: AppColors.white,
      );
}

class _MastercardStamp extends StatelessWidget {
  const _MastercardStamp();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        SizedBox(
          width: 40.w,
          height: 24.h,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                child: CircleAvatar(
                  radius: 11.r,
                  backgroundColor: AppColors.fintechDanger,
                ),
              ),
              Positioned(
                right: 0,
                child: CircleAvatar(
                  radius: 11.r,
                  backgroundColor: AppColors.fintechWarning,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 2.h),
        AppText(
          text: 'mastercard',
          style: AppTextStyle.displaySmall.copyWith(
            color: FintechColors.textSecondary(context),
          ),
        ),
      ],
    );
  }
}
