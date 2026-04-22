// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:clean_flutter/src/core/utils/app_colors.dart';
import 'package:clean_flutter/src/core/utils/theme/app_text_styles.dart';
import 'package:clean_flutter/src/general_widgets/general_widget_exports.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String userName = 'Shalom';
    const String availableBalance = '£ 225.00';
    const String repaymentDue = '£ 525.00';
    const String perCycleLimit = '£ 750.00';

    final transactions = _sampleTransactions();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.secondary200,
              AppColors.primary300,
              AppColors.primary100,
            ],
          ),
        ),
        child: Column(
          children: [
            _HomeHeader(
              userName: userName,
              availableBalance: availableBalance,
              repaymentDue: repaymentDue,
              perCycleLimit: perCycleLimit,
            ),
            Expanded(child: _TransactionsSection(transactions: transactions)),
          ],
        ),
      ),
    );
  }

  List<_TransactionItem> _sampleTransactions() => [
    const _TransactionItem(
      label: 'Withdrawal',
      date: '20 Sep 2025 • 12:14PM',
      amount: '- £220.00',
      isDebit: true,
      type: _TxType.withdrawal,
    ),
    const _TransactionItem(
      label: 'Withdrawal',
      date: '20 Sep 2025 • 12:14PM',
      amount: '- £150.00',
      isDebit: true,
      type: _TxType.withdrawal,
    ),
    const _TransactionItem(
      label: 'Withdrawal',
      date: '20 Sep 2025 • 12:14PM',
      amount: '- £150.00',
      isDebit: true,
      type: _TxType.withdrawal,
    ),
    const _TransactionItem(
      label: 'Repayment',
      date: '20 Sep 2025 • 12:14PM',
      amount: '+ £150.00',
      isDebit: false,
      type: _TxType.repayment,
    ),
    const _TransactionItem(
      label: 'Pay Earned',
      date: '20 Sep 2025 • 12:14PM',
      amount: '+ £1,500.00',
      isDebit: false,
      type: _TxType.payEarned,
    ),
  ];
}

// ─── Header ────────────────────────────────────────────────────────────────

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({
    required this.userName,
    required this.availableBalance,
    required this.repaymentDue,
    required this.perCycleLimit,
  });

  final String userName;
  final String availableBalance;
  final String repaymentDue;
  final String perCycleLimit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 28.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ── Greeting row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: 'Hi $userName!',
                  style: AppTextStyle.titleLarge.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      Icons.notifications_outlined,
                      color: AppColors.white,
                      size: 26.r,
                    ),
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        width: 8.r,
                        height: 8.r,
                        decoration: BoxDecoration(
                          color: AppColors.danger300,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Spacing.height(24.h),

            // ── Available to Withdraw label
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: 'Available to Withdraw',
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.white.withOpacity(0.85),
                  ),
                ),
                SizedBox(width: 6.w),
                Icon(
                  Icons.info_outline,
                  color: AppColors.white.withOpacity(0.85),
                  size: 16.r,
                ),
              ],
            ),

            Spacing.height(4.h),

            // ── Balance amount
            AppText(
              text: availableBalance,
              style: AppTextStyle.headlineLarge.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
                fontSize: 38.sp,
              ),
            ),

            Spacing.height(20.h),

            // ── Repayment + Limit card
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.92),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _BalanceInfoTile(
                      icon: Icons.payments_outlined,
                      iconColor: const Color(0xFF9C27B0),
                      label: 'Repayment Due',
                      value: repaymentDue,
                    ),
                  ),
                  Container(width: 1, height: 40.h, color: AppColors.stroke),
                  Expanded(
                    child: _BalanceInfoTile(
                      icon: Icons.credit_card,
                      iconColor: AppColors.success300,
                      label: 'Per Cycle Limit',
                      value: perCycleLimit,
                      leftPadding: 16.w,
                    ),
                  ),
                ],
              ),
            ),

            Spacing.height(16.h),

            // ── Withdraw button
            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  color: AppColors.primary50,
                  borderRadius: BorderRadius.circular(40.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.reply, color: AppColors.neutral700, size: 22.r),
                    SizedBox(width: 8.w),
                    AppText(
                      text: 'Withdraw',
                      style: AppTextStyle.titleMedium.copyWith(
                        color: AppColors.neutral700,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Balance info tile ────────────────────────────────────────────────────────

class _BalanceInfoTile extends StatelessWidget {
  const _BalanceInfoTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    this.leftPadding,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final double? leftPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding ?? 0),
      child: Row(
        children: [
          Container(
            width: 36.r,
            height: 36.r,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: iconColor, size: 18.r),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: label,
                style: AppTextStyle.displaySmall.copyWith(
                  color: AppColors.neutral200,
                ),
              ),
              SizedBox(height: 2.h),
              AppText(
                text: value,
                style: AppTextStyle.titleSmall.copyWith(
                  color: AppColors.neutral500,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Transactions Section ─────────────────────────────────────────────────────

class _TransactionsSection extends StatelessWidget {
  const _TransactionsSection({required this.transactions});

  final List<_TransactionItem> transactions;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: 'Recent Transactions',
                  style: AppTextStyle.titleMedium.copyWith(
                    color: AppColors.neutral500,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: AppText(
                    text: 'See more',
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.primary300,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: transactions.length,
              separatorBuilder: (_, __) =>
                  Divider(height: 1, color: AppColors.stroke),
              itemBuilder: (context, index) {
                return _TransactionRow(item: transactions[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Transaction Row ──────────────────────────────────────────────────────────

enum _TxType { withdrawal, repayment, payEarned }

class _TransactionItem {
  const _TransactionItem({
    required this.label,
    required this.date,
    required this.amount,
    required this.isDebit,
    required this.type,
  });

  final String label;
  final String date;
  final String amount;
  final bool isDebit;
  final _TxType type;
}

class _TransactionRow extends StatelessWidget {
  const _TransactionRow({required this.item});

  final _TransactionItem item;

  Color get _iconBgColor {
    switch (item.type) {
      case _TxType.withdrawal:
        return AppColors.danger50;
      case _TxType.repayment:
        return AppColors.warning50;
      case _TxType.payEarned:
        return AppColors.success50;
    }
  }

  Color get _iconColor {
    switch (item.type) {
      case _TxType.withdrawal:
        return AppColors.danger300;
      case _TxType.repayment:
        return AppColors.warning300;
      case _TxType.payEarned:
        return AppColors.success300;
    }
  }

  IconData get _icon {
    switch (item.type) {
      case _TxType.withdrawal:
        return Icons.reply_rounded;
      case _TxType.repayment:
        return Icons.redo_rounded;
      case _TxType.payEarned:
        return Icons.payments_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final amountColor = AppColors.neutral500;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: Row(
        children: [
          // Icon container
          Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: _iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(_icon, color: _iconColor, size: 18.r),
          ),
          SizedBox(width: 12.w),

          // Label + date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: item.label,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.neutral500,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                AppText(
                  text: item.date,
                  style: AppTextStyle.displaySmall.copyWith(
                    color: AppColors.neutral200,
                  ),
                ),
              ],
            ),
          ),

          // Amount
          AppText(
            text: item.amount,
            style: AppTextStyle.bodySmall.copyWith(
              color: amountColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
