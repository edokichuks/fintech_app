// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

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

    return RepaintBoundary(
      child: Container(
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
            borderRadius: BorderRadius.circular((FintechRadius.card - 1).r),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: ColoredBox(color: _backgroundColor(context)),
                ),
                Positioned.fill(
                  child: Opacity(
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
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isCompact = constraints.maxWidth < 240.w;
                    final contentPadding = isCompact
                        ? 12.w
                        : FintechSpacing.lg.w;
                    final headerPlaceholderHeight = isCompact ? 14.h : 22.h;
                    final numberSpacing = isCompact ? 8.h : FintechSpacing.lg.h;
                    final detailsSpacing = isCompact
                        ? 10.h
                        : FintechSpacing.lg.h;
                    final chipGap = isCompact ? 10.w : FintechSpacing.md.w;

                    return Padding(
                      padding: EdgeInsets.all(contentPadding),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      color: AppColors.fintechBlue.withValues(
                                        alpha: 0.4,
                                      ),
                                    ),
                                  ),
                                  child: AppText(
                                    text: 'Frozen',
                                    style: AppTextStyle.displaySmall.copyWith(
                                      color: AppColors.fintechBlueGlow,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )
                              else
                                SizedBox(height: headerPlaceholderHeight),
                              AppImageView(
                                svgPath: Assets.images.svg.master,
                                width: isCompact ? 34.w : 40.w,
                                height: isCompact ? 20.h : 24.h,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                          SizedBox(height: isCompact ? 12.h : 18.h),
                          Row(
                            children: <Widget>[
                              const _Chip(),
                              SizedBox(width: chipGap),
                              Icon(
                                LucideIcons.wifi300,
                                color: textPrimary,
                                size: isCompact ? 16.r : 18.r,
                              ),
                            ],
                          ),
                          SizedBox(height: numberSpacing),
                          AppText(
                            text: cardNumber,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style:
                                (isCompact
                                        ? AppTextStyle.bodyMedium
                                        : AppTextStyle.titleMedium)
                                    .copyWith(
                                      color: textPrimary,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: isCompact ? 0.4 : 0.8,
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
          style: AppTextStyle.displaySmall.copyWith(color: labelColor),
        ),
        SizedBox(height: 4.h),
        AppText(
          text: value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style:
              (isCompact ? AppTextStyle.displaySmall : AppTextStyle.bodySmall)
                  .copyWith(color: valueColor, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38.w,
      height: 28.h,
      decoration: BoxDecoration(
        color: AppColors.fintechPeach,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 14.w,
              margin: EdgeInsets.only(left: 8.w),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: AppColors.fintechPeachDark,
                    width: 1.4,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 12.w,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: AppColors.fintechPeachDark,
                    width: 1.2,
                  ),
                  right: BorderSide(
                    color: AppColors.fintechPeachDark,
                    width: 1.2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
