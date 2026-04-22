// Flutter imports:
import 'package:fintech_app/src/core/extensions/extension_exports.dart';
import 'package:fintech_app/src/core/router/router.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

// Project imports:
import 'package:fintech_app/gen/assets.gen.dart';
import 'package:fintech_app/src/application/model/fintech_dashboard_snapshot.dart';
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/features/home/domain/notifiers/profile_drawer_ui_notifier.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

class FintechProfileDrawer extends ConsumerWidget {
  const FintechProfileDrawer({required this.user, super.key});

  final FintechUserSummary user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drawerState = ref.watch(profileDrawerUiProvider);

    return Material(
      color: FintechColors.scaffold(context),
      child: SizedBox(
        width: 280.w,
        child: SafeArea(
          right: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 18.h, 12.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 52.w,
                            height: 52.h,
                            decoration: BoxDecoration(
                              color: FintechColors.mutedSurface(context),
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                            child: Icon(
                              LucideIcons.bellDot400,
                              color: FintechColors.textPrimary(context),
                              size: 20.r,
                            ),
                          ),
                        ),
                        SizedBox(height: FintechSpacing.md.h),
                        ClipOval(
                          child: Assets.images.png.profileimg.image(
                            width: 62.w,
                            height: 62.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: FintechSpacing.sm.h),
                        AppText(
                          text: 'Welcome',
                          style: AppTextStyle.bodySmall.copyWith(
                            color: FintechColors.textSecondary(context),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        AppText(
                          text: user.fullName,
                          style: AppTextStyle.titleMedium.copyWith(
                            color: FintechColors.textPrimary(context),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: FintechSpacing.xxl.h),
                        AppText(
                          text: 'Profile Settings',
                          style: AppTextStyle.titleLarge.copyWith(
                            color: FintechColors.textPrimary(context),
                          ),
                        ),
                        SizedBox(height: FintechSpacing.md.h),
                        _DrawerTile(
                          title: 'E-Statement',
                          icon: LucideIcons.fileText400,
                          onTap: () => _showPlaceholder(),
                        ),
                        SizedBox(height: FintechSpacing.md.h),
                        _DrawerTile(
                          title: 'Credit Card',
                          icon: LucideIcons.creditCard400,
                          onTap: () {
                            ref.read(profileDrawerUiProvider.notifier).close();
                            context.pushNamed(AppRouter.cardsScreen);
                          },
                        ),
                        SizedBox(height: FintechSpacing.md.h),
                        _DrawerTile(
                          title: 'Settings',
                          icon: LucideIcons.settings400,
                          onTap: () => _showPlaceholder(),
                        ),
                        SizedBox(height: FintechSpacing.xl.h),
                        AppText(
                          text: 'Notification',
                          style: AppTextStyle.titleLarge.copyWith(
                            color: FintechColors.textPrimary(context),
                          ),
                        ),
                        SizedBox(height: FintechSpacing.md.h),
                        _DrawerSwitchTile(
                          title: 'App Notification',
                          icon: LucideIcons.bell400,
                          value: drawerState.notificationsEnabled,
                          onChanged: (value) {
                            ref
                                .read(profileDrawerUiProvider.notifier)
                                .toggleNotifications(value);
                          },
                        ),
                        SizedBox(height: FintechSpacing.xl.h),
                        AppText(
                          text: 'More',
                          style: AppTextStyle.titleLarge.copyWith(
                            color: FintechColors.textPrimary(context),
                          ),
                        ),
                        SizedBox(height: FintechSpacing.md.h),
                        _DrawerTile(
                          title: 'Language',
                          icon: LucideIcons.languages400,
                          onTap: () => _showPlaceholder(),
                        ),
                        SizedBox(height: FintechSpacing.md.h),
                        _DrawerTile(
                          title: 'Country',
                          icon: LucideIcons.globe400,
                          onTap: () => _showPlaceholder(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: FintechSpacing.lg.h),
                PressableScale(
                  onTap: () => showSuccessToast(
                    message: 'Logout flow is not part of this assessment',
                    backgroundColor: AppColors.danger75,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: FintechSpacing.md.w,
                      vertical: FintechSpacing.sm.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.danger50,
                      borderRadius: BorderRadius.circular(
                        FintechRadius.button.r,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        AppText(
                          text: 'Logout',
                          style: AppTextStyle.bodyMedium.copyWith(
                            color: AppColors.danger500,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: FintechSpacing.xs.w),
                        Icon(
                          LucideIcons.logOut400,
                          color: AppColors.danger500,
                          size: 18.r,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPlaceholder() {
    showSuccessToast(message: 'Demo item wired for the UI assessment');
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

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
          borderRadius: BorderRadius.circular(FintechRadius.button.r),
        ),
        child: Row(
          children: <Widget>[
            Icon(icon, color: AppColors.fintechBlue, size: 20.r),
            SizedBox(width: FintechSpacing.md.w),
            Expanded(
              child: AppText(
                text: title,
                style: AppTextStyle.bodyMedium.copyWith(
                  color: FintechColors.textPrimary(context),
                ),
              ),
            ),
            Icon(
              LucideIcons.chevronRight400,
              color: FintechColors.textPrimary(context),
              size: 18.r,
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerSwitchTile extends StatelessWidget {
  const _DrawerSwitchTile({
    required this.title,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: FintechSpacing.md.w,
        vertical: FintechSpacing.md.h,
      ),
      decoration: BoxDecoration(
        color: FintechColors.surface(context),
        borderRadius: BorderRadius.circular(FintechRadius.button.r),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, color: AppColors.fintechBlue, size: 20.r),
          SizedBox(width: FintechSpacing.md.w),
          Expanded(
            child: AppText(
              text: title,
              style: AppTextStyle.bodyMedium.copyWith(
                color: FintechColors.textPrimary(context),
              ),
            ),
          ),
          AppSwitch(
            value: value,
            onChanged: onChanged,
            width: 38.w,
            height: 22.h,
          ),
        ],
      ),
    );
  }
}
