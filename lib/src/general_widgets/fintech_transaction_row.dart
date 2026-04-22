// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

// Project imports:
import 'package:fintech_app/gen/assets.gen.dart';
import 'package:fintech_app/src/application/model/fintech_dashboard_snapshot.dart';
import 'package:fintech_app/src/core/helpers/helper_functions.dart';
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/general_widgets/app_text.dart';
import 'package:fintech_app/src/general_widgets/app_imageview.dart';
import 'package:fintech_app/src/general_widgets/pressable_scale.dart';

class FintechTransactionRow extends StatelessWidget {
  const FintechTransactionRow({
    required this.transaction,
    super.key,
    this.onTap,
  });

  final FintechTransactionRecord transaction;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textPrimary = FintechColors.textPrimary(context);
    final textSecondary = FintechColors.textSecondary(context);
    final assetIcon = _assetIconFor(transaction.icon);
    final assetIconSize = _assetIconSizeFor(transaction.icon);
    final amountText = HelperFunctions.formatAmount(
      amount: transaction.amount,
      decimalPlaces: 0,
    );
    final amountPrefix = transaction.isCredit ? '+ ' : '- ';
    final iconColor = transaction.isCredit
        ? AppColors.fintechBlue
        : AppColors.fintechDanger;

    return PressableScale(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: FintechSpacing.md.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: FintechColors.border(context).withValues(alpha: 0.55),
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: FintechColors.surface(context),
                border: Border.all(color: FintechColors.border(context)),
              ),
              child: Center(
                child: assetIcon != null
                    ? AppImageView(
                        svgPath: assetIcon,
                        width: assetIconSize.width.w,
                        height: assetIconSize.height.h,
                        fit: BoxFit.contain,
                        color: textPrimary,
                      )
                    : Icon(
                        _iconFor(transaction.icon),
                        color: textPrimary,
                        size: 20.r,
                      ),
              ),
            ),
            SizedBox(width: FintechSpacing.md.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AppText(
                    text: transaction.title,
                    style: AppTextStyle.bodyMedium.copyWith(
                      color: textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  AppText(
                    text: DateFormat(
                      'hh:mm a · dd-MM-yyyy',
                    ).format(transaction.occurredAt),
                    style: AppTextStyle.bodySmall.copyWith(
                      color: textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            AppText(
              text: '$amountPrefix$amountText',
              style: AppTextStyle.bodyMedium.copyWith(
                color: iconColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _assetIconFor(FintechTransactionIcon icon) {
    switch (icon) {
      case FintechTransactionIcon.wallet:
        return Assets.images.svg.eWallet;
      case FintechTransactionIcon.shopping:
        return Assets.images.svg.onlineShopping;
      case FintechTransactionIcon.bank:
        return Assets.images.svg.bankingFee;
      case FintechTransactionIcon.globe:
      case FintechTransactionIcon.savings:
        return null;
    }
  }

  Size _assetIconSizeFor(FintechTransactionIcon icon) {
    switch (icon) {
      case FintechTransactionIcon.wallet:
      case FintechTransactionIcon.shopping:
        return const Size(24, 24);
      case FintechTransactionIcon.bank:
        return const Size(21, 20);
      case FintechTransactionIcon.globe:
      case FintechTransactionIcon.savings:
        return const Size(20, 20);
    }
  }

  IconData _iconFor(FintechTransactionIcon icon) {
    switch (icon) {
      case FintechTransactionIcon.wallet:
        return LucideIcons.walletCards;
      case FintechTransactionIcon.shopping:
        return LucideIcons.shoppingBag;
      case FintechTransactionIcon.globe:
        return LucideIcons.globe;
      case FintechTransactionIcon.bank:
        return LucideIcons.landmark;
      case FintechTransactionIcon.savings:
        return LucideIcons.piggyBank;
    }
  }
}
