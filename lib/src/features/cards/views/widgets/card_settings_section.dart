// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

// Project imports:
import 'package:fintech_app/gen/assets.gen.dart';
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/features/cards/domain/notifiers/cards_ui_notifier.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

class CardSettingsSection extends StatelessWidget {
  const CardSettingsSection({
    required this.controls,
    required this.onChangePin,
    required this.onQrPayment,
    required this.onOnlineShopping,
    required this.onTapPay,
    required this.onTransactionsTap,
    super.key,
  });

  final FintechCardControlState controls;
  final ValueChanged<bool> onChangePin;
  final ValueChanged<bool> onQrPayment;
  final ValueChanged<bool> onOnlineShopping;
  final ValueChanged<bool> onTapPay;
  final VoidCallback onTransactionsTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppText(
          text: 'Card Settings',
          style: AppTextStyle.headlineSmall.copyWith(
            color: FintechColors.textPrimary(context),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: FintechSpacing.lg.h),
        _SettingTile(
          title: 'Change Pin',
          svgPath: Assets.images.svg.changePin,
          svgSize: const Size(28, 28),
          trailing: AppSwitch(
            value: controls.changePinEnabled,
            onChanged: onChangePin,
          ),
        ),
        SizedBox(height: FintechSpacing.md.h),
        _SettingTile(
          title: 'QR Payment',
          svgPath: Assets.images.svg.qrPayment,
          svgSize: const Size(28, 28),
          trailing: AppSwitch(
            value: controls.qrPaymentEnabled,
            onChanged: onQrPayment,
          ),
        ),
        SizedBox(height: FintechSpacing.md.h),
        _SettingTile(
          title: 'Online Shopping',
          icon: LucideIcons.shoppingBag400,
          trailing: AppSwitch(
            value: controls.onlineShoppingEnabled,
            onChanged: onOnlineShopping,
          ),
        ),
        SizedBox(height: FintechSpacing.md.h),
        _SettingTile(
          title: 'Card Transactions',
          svgPath: Assets.images.svg.cardTransactions,
          svgSize: const Size(27, 21),
          onTap: onTransactionsTap,
          trailing: Icon(
            LucideIcons.chevronRight400,
            color: FintechColors.textPrimary(context),
            size: 18.r,
          ),
        ),
        SizedBox(height: FintechSpacing.md.h),
        _SettingTile(
          title: 'Tap Pay',
          svgPath: Assets.images.svg.contactless,
          svgSize: const Size(25, 29),
          trailing: AppSwitch(
            value: controls.tapPayEnabled,
            onChanged: onTapPay,
          ),
        ),
      ],
    );
  }
}

class _SettingTile extends StatelessWidget {
  const _SettingTile({
    required this.title,
    required this.trailing,
    this.icon,
    this.svgPath,
    this.svgSize,
    this.onTap,
  });

  final String title;
  final IconData? icon;
  final String? svgPath;
  final Size? svgSize;
  final Widget trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: FintechSpacing.md.w,
          vertical: FintechSpacing.md.h,
        ),
        decoration: BoxDecoration(
          color: FintechColors.surface(context),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: <Widget>[
            if (svgPath != null)
              AppImageView(
                svgPath: svgPath,
                width: svgSize!.width.w,
                height: svgSize!.height.h,
                fit: BoxFit.scaleDown,
                color: FintechColors.textPrimary(context),
              )
            else
              Icon(icon, color: FintechColors.textPrimary(context), size: 20.r),
            SizedBox(width: FintechSpacing.md.w),
            Expanded(
              child: AppText(
                text: title,
                style: AppTextStyle.bodyLarge.copyWith(
                  color: FintechColors.textPrimary(context),
                ),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
