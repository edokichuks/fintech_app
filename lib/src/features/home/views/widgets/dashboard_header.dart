// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

// Project imports:
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    required this.title,
    required this.unreadNotifications,
    required this.onMenuTap,
    super.key,
    this.onNotificationsTap,
  });

  final String title;
  final int unreadNotifications;
  final VoidCallback onMenuTap;
  final VoidCallback? onNotificationsTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 8.h),
        child: Row(
          children: <Widget>[
            PressableScale(
              onTap: onMenuTap,
              child: Icon(
                LucideIcons.menu400,
                color: FintechColors.textPrimary(context),
                size: 22.r,
              ),
            ),
            Expanded(
              child: AppText(
                text: title,
                style: AppTextStyle.bodySmall.copyWith(
                  color: FintechColors.textPrimary(context),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            PressableScale(
              onTap: onNotificationsTap,
              child: Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: FintechColors.surface(context),
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Icon(
                        LucideIcons.bellDot400,
                        color: FintechColors.textPrimary(context),
                        size: 18.r,
                      ),
                    ),
                    if (unreadNotifications > 0)
                      Positioned(
                        top: 8.h,
                        right: 8.w,
                        child: Container(
                          width: 7.w,
                          height: 7.h,
                          decoration: BoxDecoration(
                            color: AppColors.fintechBlue,
                            shape: BoxShape.circle,
                          ),
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
