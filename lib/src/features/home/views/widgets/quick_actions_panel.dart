// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

// Project imports:
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
            child: Icon(
              _iconFor(action.type),
              color: FintechColors.textPrimary(context),
              size: 20.r,
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

  IconData _iconFor(FintechQuickActionType type) {
    switch (type) {
      case FintechQuickActionType.billPay:
        return LucideIcons.badgeDollarSign400;
      case FintechQuickActionType.donations:
        return LucideIcons.heartHandshake400;
      case FintechQuickActionType.deposit:
        return LucideIcons.landmark400;
      case FintechQuickActionType.more:
        return LucideIcons.layoutGrid400;
    }
  }
}
