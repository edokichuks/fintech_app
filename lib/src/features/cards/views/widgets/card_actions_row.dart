// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

// Project imports:
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/features/cards/domain/notifiers/cards_ui_notifier.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

class CardActionsRow extends StatelessWidget {
  const CardActionsRow({
    required this.controls,
    required this.onFreezeTap,
    required this.onRevealTap,
    required this.onSecureTap,
    super.key,
  });

  final FintechCardControlState controls;
  final VoidCallback onFreezeTap;
  final VoidCallback onRevealTap;
  final VoidCallback onSecureTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _ActionButton(
          label: controls.isFrozen ? 'Unfreeze' : 'Freeze Card',
          icon: LucideIcons.snowflake400,
          onTap: onFreezeTap,
        ),
        _ActionButton(
          label: controls.isRevealed ? 'Hide' : 'Reveal',
          icon: controls.isRevealed
              ? LucideIcons.eye400
              : LucideIcons.eyeOff400,
          onTap: onRevealTap,
        ),
        _ActionButton(
          label: 'Secure Card',
          icon: LucideIcons.shield400,
          onTap: onSecureTap,
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: FintechColors.surface(context),
            ),
            child: Icon(
              icon,
              color: FintechColors.textPrimary(context),
              size: 22.r,
            ),
          ),
          SizedBox(height: FintechSpacing.sm.h),
          SizedBox(
            width: 100.w,
            child: AppText(
              text: label,
              style: AppTextStyle.bodySmall.copyWith(
                color: FintechColors.textPrimary(context),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
