// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:fintech_app/src/application/model/fintech_dashboard_snapshot.dart';
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

class TransactionHistorySection extends StatelessWidget {
  const TransactionHistorySection({
    required this.transactions,
    required this.selectedFilter,
    required this.onFilterChanged,
    super.key,
  });

  final List<FintechTransactionRecord> transactions;
  final FintechHistoryFilter selectedFilter;
  final ValueChanged<FintechHistoryFilter> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: AppText(
                text: 'Transaction History',
                style: AppTextStyle.titleLarge.copyWith(
                  color: FintechColors.textPrimary(context),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            PressableScale(
              onTap: () =>
                  showSuccessToast(message: 'Full history coming soon'),
              child: AppText(
                text: 'See all',
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.blue100,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: FintechSpacing.md.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: FintechHistoryFilter.values.map((filter) {
              final isSelected = filter == selectedFilter;
              return Padding(
                padding: EdgeInsets.only(right: FintechSpacing.sm.w),
                child: PressableScale(
                  onTap: () => onFilterChanged(filter),
                  child: AnimatedContainer(
                    duration: FintechDurations.press,
                    curve: Curves.easeOutCubic,
                    padding: EdgeInsets.symmetric(
                      horizontal: FintechSpacing.lg.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? FintechColors.surface(context)
                          : FintechColors.mutedSurface(context),
                      borderRadius: BorderRadius.circular(FintechRadius.pill.r),
                    ),
                    child: AppText(
                      text: _labelFor(filter),
                      style: AppTextStyle.displaySmall.copyWith(
                        color: isSelected
                            ? FintechColors.textPrimary(context)
                            : FintechColors.textSecondary(context),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: FintechSpacing.md.h),
        ...transactions.map(
          (transaction) => FintechTransactionRow(transaction: transaction),
        ),
      ],
    );
  }

  String _labelFor(FintechHistoryFilter filter) {
    switch (filter) {
      case FintechHistoryFilter.weekly:
        return 'Weekly';
      case FintechHistoryFilter.monthly:
        return 'Monthly';
      case FintechHistoryFilter.today:
        return 'Today';
    }
  }
}
