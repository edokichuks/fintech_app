// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:fintech_app/gen/assets.gen.dart';
import 'package:fintech_app/src/application/model/fintech_dashboard_snapshot.dart';
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

class QuickActionsPanel extends StatelessWidget {
  const QuickActionsPanel({required this.actions, super.key});

  final List<FintechQuickAction> actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: FintechSpacing.md.h),
      decoration: BoxDecoration(
        color: FintechColors.surface(context),
        borderRadius: BorderRadius.circular(FintechRadius.panel.r),
      ),
      child: Row(
        children: actions
            .asMap()
            .entries
            .map(
              (entry) => Expanded(
                child: Row(
                  children: <Widget>[
                    if (entry.key != 0)
                      Container(
                        width: 1.w,
                        height: 50.h,
                        color: FintechColors.border(context),
                      ),
                    Expanded(child: _QuickActionItem(action: entry.value)),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  const _QuickActionItem({required this.action});

  final FintechQuickAction action;

  @override
  Widget build(BuildContext context) {
    final iconSize = _iconSizeFor(action.type);

    return PressableScale(
      onTap: () => showSuccessToast(message: '${action.title} coming soon'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 42.w,
            height: 42.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: FintechColors.mutedSurface(context),
            ),
            child: Center(
              child: AppImageView(
                svgPath: _iconAssetFor(action.type),
                width: iconSize.width.w,
                height: iconSize.height.h,
                fit: BoxFit.contain,
                color: FintechColors.textPrimary(context),
              ),
            ),
          ),
          SizedBox(height: FintechSpacing.sm.h),
          AppText(
            text: action.title,
            style: AppTextStyle.bodySmall.copyWith(
              color: FintechColors.textPrimary(context),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _iconAssetFor(FintechQuickActionType type) {
    switch (type) {
      case FintechQuickActionType.billPay:
        return Assets.images.svg.billsPay;
      case FintechQuickActionType.donations:
        return Assets.images.svg.donations;
      case FintechQuickActionType.deposit:
        return Assets.images.svg.deposit;
      case FintechQuickActionType.more:
        return Assets.images.svg.more;
    }
  }

  Size _iconSizeFor(FintechQuickActionType type) {
    switch (type) {
      case FintechQuickActionType.billPay:
        return const Size(20, 20);
      case FintechQuickActionType.donations:
        return const Size(23, 22);
      case FintechQuickActionType.deposit:
        return const Size(20, 20);
      case FintechQuickActionType.more:
        return const Size(18, 18);
    }
  }
}
