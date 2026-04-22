// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

// Project imports:
import 'package:fintech_app/gen/assets.gen.dart';
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

class BalanceOverviewCard extends StatelessWidget {
  const BalanceOverviewCard({required this.balance, super.key});

  final double balance;

  Color _backgroundColor(BuildContext context) => FintechColors.isDark(context)
      ? AppColors.fintechBalanceOverviewDark
      : AppColors.fintechBalanceOverviewLight;

  Color _badgeColor(BuildContext context) => FintechColors.isDark(context)
      ? AppColors.fintechBalanceOverviewBadgeDark
      : AppColors.fintechBalanceOverviewBadgeLight;

  List<Color> _borderGradient(BuildContext context) =>
      FintechColors.isDark(context)
      ? <Color>[
          AppColors.fintechBalanceOverviewBorderStart,
          AppColors.fintechBalanceOverviewBorderEnd,
        ]
      : <Color>[
          AppColors.fintechBalanceOverviewBorderLightStart,
          AppColors.fintechBalanceOverviewBorderLightEnd,
        ];

  Widget _buildBarcodeBadge(BuildContext context) {
    final iconColor = FintechColors.textPrimary(context);

    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _badgeColor(context),
        border: Border.all(
          color: AppColors.white.withValues(
            alpha: FintechColors.isDark(context) ? 0.06 : 0.28,
          ),
        ),
      ),
      child: Center(
        child: AppImageView(
          svgPath: Assets.images.svg.barcode,
          width: 18.w,
          height: 18.w,
          color: iconColor,
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: <Widget>[
        Expanded(
          child: AppButton(
            text: 'Add Cash',
            height: 44.h,
            onPressed: () => showSuccessToast(message: 'Add Cash coming soon'),
            cornerRadius: 4.r,
            leading: Icon(
              LucideIcons.plus600,
              color: AppColors.white,
              size: 16.r,
            ),
            buttonStyle: _FintechPrimaryButtonStyle(),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: AppButton(
            text: 'Send Money',
            height: 44.h,
            onPressed: () =>
                showSuccessToast(message: 'Send Money coming soon'),
            cornerRadius: 4.r,
            leading: Icon(
              LucideIcons.arrowUpRight600,
              color: AppColors.white,
              size: 16.r,
            ),
            buttonStyle: _FintechPrimaryButtonStyle(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = FintechColors.isDark(context);
    final contentRadius = BorderRadius.circular((FintechRadius.card - 1).r);
    final headingColor = isDark
        ? AppColors.white.withValues(alpha: 0.84)
        : FintechColors.textSecondary(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(FintechRadius.card.r),
        gradient: LinearGradient(
          begin: const Alignment(-0.92, -1),
          end: const Alignment(1, 1),
          colors: _borderGradient(context),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.fintechDarkScrim.withValues(
              alpha: isDark ? 0.34 : 0.08,
            ),
            blurRadius: isDark ? 36.r : 18.r,
            offset: Offset(0, 18.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(1.w),
        child: ClipRRect(
          borderRadius: contentRadius,
          child: SizedBox(
            height: 204.h,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: ColoredBox(color: _backgroundColor(context)),
                ),
                Positioned.fill(
                  child: Opacity(
                    // opacity: isDark ? 0.42 : 0.12,
                    opacity: 0.09,
                    child: AppImageView(
                      imagePath: Assets.images.png.homeBackground.path,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          AppColors.white.withValues(
                            alpha: isDark ? 0.04 : 0.12,
                          ),
                          AppColors.transparent,
                          AppColors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 29.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 12.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  AppText(
                                    text: 'Total Balance',
                                    style: AppTextStyle.bodyLarge.copyWith(
                                      fontSize: 17.sp,
                                      height: 1.15,
                                      color: headingColor,
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  AnimatedCurrencyText(
                                    value: balance,
                                    suffix: '\$',
                                    decimalPlaces: 0,
                                    useGrouping: false,
                                    style: AppTextStyle.headlineLarge.copyWith(
                                      fontSize: 40.sp,
                                      height: 1,
                                      letterSpacing: -1.2,
                                      color: FintechColors.textPrimary(context),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              AppImageView(
                                svgPath: Assets.images.svg.master,
                                width: 44.w,
                                height: 26.h,
                              ),
                              SizedBox(height: 18.h),
                              _buildBarcodeBadge(context),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      _buildActionButtons(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
        textStyle: AppTextStyle.bodyMedium.copyWith(
          fontWeight: FontWeight.w700,
          height: 1,
        ),
      );
}
