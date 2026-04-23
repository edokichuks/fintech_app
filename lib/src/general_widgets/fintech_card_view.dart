// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:fintech_app/gen/assets.gen.dart';
import 'package:fintech_app/src/application/model/fintech_dashboard_snapshot.dart';
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/general_widgets/app_imageview.dart';
import 'package:fintech_app/src/general_widgets/app_text.dart';

class FintechCardView extends StatelessWidget {
  const FintechCardView({
    required this.card,
    super.key,
    this.isFrozen = false,
    this.isRevealed = false,
  });

  final FintechBankCard card;
  final bool isFrozen;
  final bool isRevealed;

  static const double cardWidth = 262;
  static const double cardHeight = 158.5;
  static const double _cardRadius = 10.66;
  static const double _cardBorderWidth = 0.92;

  Color _backgroundColor(BuildContext context) => FintechColors.isDark(context)
      ? AppColors.fintechBalanceOverviewDark
      : AppColors.fintechBalanceOverviewLight;

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

  @override
  Widget build(BuildContext context) {
    final isDark = FintechColors.isDark(context);
    final textPrimary = FintechColors.textPrimary(context);
    final textSecondary = FintechColors.textSecondary(context);
    final cardNumber = isRevealed
        ? _groupCardNumber(card.cardNumber)
        : card.maskedNumber;

    return Align(
      alignment: Alignment.center,
      widthFactor: 1,
      heightFactor: 1,
      child: SizedBox(
        width: cardWidth.w,
        height: cardHeight.h,
        child: RepaintBoundary(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_cardRadius.r),
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
              padding: EdgeInsets.all(_cardBorderWidth.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  (_cardRadius - _cardBorderWidth).r,
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: ColoredBox(color: _backgroundColor(context)),
                    ),
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.1,
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
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isCompact = true;
                        final contentPadding = 12.w;
                        final headerPlaceholderHeight = 16.h;
                        final numberSpacing = 8.h;
                        final detailsSpacing = 10.h;
                        final chipGap = 8.w;

                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                            contentPadding,
                            8.h,
                            contentPadding,
                            10.h,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  if (isFrozen)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: FintechSpacing.sm.w,
                                        vertical: FintechSpacing.xxs.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.fintechBlue.withValues(
                                          alpha: 0.16,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          FintechRadius.pill.r,
                                        ),
                                        border: Border.all(
                                          color: AppColors.fintechBlue
                                              .withValues(alpha: 0.4),
                                        ),
                                      ),
                                      child: AppText(
                                        text: 'Frozen',
                                        style: AppTextStyle.displaySmall
                                            .copyWith(
                                              color: AppColors.fintechBlueGlow,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 8.sp,
                                              height: 1,
                                            ),
                                      ),
                                    )
                                  else
                                    SizedBox(height: headerPlaceholderHeight),
                                  AppImageView(
                                    svgPath: Assets.images.svg.master,
                                    width: 34.w,
                                    height: 20.h,
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: <Widget>[
                                  const _Chip(),
                                  SizedBox(width: chipGap),
                                  AppImageView(
                                    svgPath: Assets.images.svg.contactless,
                                    width: 25.w,
                                    height: 29.h,
                                    fit: BoxFit.contain,
                                    color: textPrimary,
                                  ),
                                ],
                              ),
                              SizedBox(height: numberSpacing),
                              AppText(
                                text: cardNumber,
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                style: AppTextStyle.bodyMedium.copyWith(
                                  color: textPrimary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13.sp,
                                  height: 1,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(height: detailsSpacing),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 4,
                                    child: _CardDetail(
                                      label: 'Card Holder',
                                      value: card.holderName,
                                      labelColor: textSecondary,
                                      valueColor: textPrimary,
                                      isCompact: isCompact,
                                    ),
                                  ),
                                  SizedBox(width: FintechSpacing.sm.w),
                                  Expanded(
                                    flex: 3,
                                    child: _CardDetail(
                                      label: 'Valid',
                                      value: card.expiryLabel,
                                      labelColor: textSecondary,
                                      valueColor: textPrimary,
                                      isCompact: isCompact,
                                    ),
                                  ),
                                  SizedBox(width: FintechSpacing.sm.w),
                                  Expanded(
                                    flex: 2,
                                    child: _CardDetail(
                                      label: 'CVV',
                                      value: card.cvv,
                                      labelColor: textSecondary,
                                      valueColor: textPrimary,
                                      isCompact: isCompact,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _groupCardNumber(String value) {
    final buffer = StringBuffer();
    for (int index = 0; index < value.length; index += 4) {
      final end = (index + 4 < value.length) ? index + 4 : value.length;
      buffer.write(value.substring(index, end));
      if (end != value.length) {
        buffer.write(' ');
      }
    }
    return buffer.toString();
  }
}

class _CardDetail extends StatelessWidget {
  const _CardDetail({
    required this.label,
    required this.value,
    required this.labelColor,
    required this.valueColor,
    required this.isCompact,
  });

  final String label;
  final String value;
  final Color labelColor;
  final Color valueColor;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppText(
          text: label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.displaySmall.copyWith(
            color: labelColor,
            fontSize: isCompact ? 9.sp : 12.sp,
            height: 1,
          ),
        ),
        SizedBox(height: 3.h),
        AppText(
          text: value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style:
              (isCompact ? AppTextStyle.displaySmall : AppTextStyle.bodySmall)
                  .copyWith(
                    color: valueColor,
                    fontWeight: FontWeight.w700,
                    fontSize: isCompact ? 10.sp : 14.sp,
                    height: 1.05,
                  ),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip();

  @override
  Widget build(BuildContext context) {
    return AppImageView(
      svgPath: Assets.images.svg.chip,
      width: 35.w,
      height: 26.h,
      fit: BoxFit.contain,
    );
  }
}
