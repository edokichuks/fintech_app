// Flutter imports:
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

// Project imports:
import 'package:fintech_app/src/application/model/fintech_dashboard_snapshot.dart';
import 'package:fintech_app/src/core/helpers/helper_functions.dart';
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

class SpendChartCard extends StatefulWidget {
  const SpendChartCard({
    required this.totalSpend,
    required this.points,
    required this.selectedRange,
    required this.onRangeChanged,
    super.key,
  });

  final double totalSpend;
  final List<FintechSpendPoint> points;
  final FintechSpendRange selectedRange;
  final ValueChanged<FintechSpendRange> onRangeChanged;

  @override
  State<SpendChartCard> createState() => _SpendChartCardState();
}

class _SpendChartCardState extends State<SpendChartCard> {
  int _touchedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final chartPoints = widget.points.isEmpty
        ? <FintechSpendPoint>[
            const FintechSpendPoint(x: 0, y: 1, label: 'Jan'),
            const FintechSpendPoint(x: 1, y: 2, label: 'Feb'),
          ]
        : widget.points;
    final maxY =
        chartPoints
            .map((point) => point.y)
            .reduce((current, next) => current > next ? current : next) +
        1.4;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: FintechColors.surface(context),
        borderRadius: BorderRadius.circular(FintechRadius.panel.r),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 340.w;

                final selector = PressableScale(
                  onTap: () => widget.onRangeChanged(
                    widget.selectedRange == FintechSpendRange.weekly
                        ? FintechSpendRange.monthly
                        : FintechSpendRange.weekly,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(FintechRadius.pill.r),
                      border: Border.all(color: AppColors.fintechBlue),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        AppText(
                          text: widget.selectedRange == FintechSpendRange.weekly
                              ? 'Weekly'
                              : 'Monthly',
                          style: AppTextStyle.bodySmall.copyWith(
                            color: FintechColors.textPrimary(context),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          LucideIcons.chevronDown400,
                          color: FintechColors.textPrimary(context),
                          size: 16.r,
                        ),
                      ],
                    ),
                  ),
                );

                final summary = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppText(
                      text: 'Total Spend',
                      style: AppTextStyle.bodyLarge.copyWith(
                        color: FintechColors.textPrimary(context),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: AnimatedCurrencyText(
                        value: widget.totalSpend,
                        suffix: '\$',
                        style: AppTextStyle.titleLarge.copyWith(
                          color: FintechColors.textPrimary(context),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                );

                if (isCompact) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(child: summary),
                      SizedBox(width: 12.w),
                      Flexible(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: selector,
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return Row(
                  children: <Widget>[
                    Expanded(child: summary),
                    SizedBox(width: 12.w),
                    selector,
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            height: 220.h,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: chartPoints.length.toDouble() - 1,
                minY: 0,
                maxY: maxY,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30.h,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final index = value.round();
                        final isWholePoint = (value - index).abs() < 0.01;
                        if (!isWholePoint ||
                            index < 0 ||
                            index >= chartPoints.length) {
                          return const SizedBox.shrink();
                        }

                        final title = chartPoints[index].label;
                        return SideTitleWidget(
                          meta: meta,
                          space: 0,
                          fitInside: SideTitleFitInsideData.fromTitleMeta(
                            meta,
                            distanceFromEdge: 0,
                          ),
                          child: AppText(
                            text: title,
                            style: AppTextStyle.bodyMedium.copyWith(
                              color: FintechColors.textSecondary(context),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                lineTouchData: LineTouchData(
                  handleBuiltInTouches: true,
                  touchCallback: (event, response) {
                    final touched =
                        (response?.lineBarSpots?.isNotEmpty ?? false)
                        ? response!.lineBarSpots!.first
                        : null;
                    if (touched != null) {
                      setState(() {
                        _touchedIndex = touched.spotIndex;
                      });
                    }
                  },
                  getTouchedSpotIndicator: (barData, spotIndexes) {
                    return spotIndexes.map((_) {
                      return TouchedSpotIndicatorData(
                        FlLine(
                          color: FintechColors.border(
                            context,
                          ).withValues(alpha: 0.7),
                          strokeWidth: 1,
                          dashArray: const <int>[4, 4],
                        ),
                        FlDotData(
                          getDotPainter: (spot, percent, bar, index) {
                            return FlDotCirclePainter(
                              radius: 6.r,
                              color: AppColors.fintechBlue,
                              strokeColor: AppColors.white,
                              strokeWidth: 3,
                            );
                          },
                        ),
                      );
                    }).toList();
                  },
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBorderRadius: BorderRadius.circular(10.r),
                    tooltipPadding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 8.h,
                    ),
                    getTooltipColor: (_) => AppColors.white,
                    getTooltipItems: (spots) {
                      return spots.map((spot) {
                        final amount = HelperFunctions.formatAmount(
                          amount: spot.y * 620,
                          decimalPlaces: 0,
                        );
                        return LineTooltipItem(
                          '\$$amount',
                          AppTextStyle.bodySmall.copyWith(
                            color: FintechColors.textPrimary(context),
                            fontWeight: FontWeight.w700,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
                lineBarsData: <LineChartBarData>[
                  LineChartBarData(
                    isCurved: true,
                    barWidth: 3.5.w,
                    isStrokeCapRound: true,
                    color: AppColors.fintechBlueSoft,
                    dotData: FlDotData(
                      show: true,
                      checkToShowDot: (spot, _) =>
                          spot.x.toInt() == _touchedIndex,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 6.r,
                          color: AppColors.fintechBlue,
                          strokeWidth: 3,
                          strokeColor: AppColors.white,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          AppColors.fintechBlue.withValues(alpha: 0.88),
                          AppColors.fintechBlue.withValues(alpha: 0),
                        ],
                      ),
                    ),
                    spots: chartPoints
                        .map((point) => FlSpot(point.x, point.y))
                        .toList(),
                  ),
                ],
              ),
              duration: const Duration(milliseconds: 550),
            ),
          ),
        ],
      ),
    );
  }
}
