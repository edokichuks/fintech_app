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
                        SizedBox(
                          width: 62.w,
                          height: 62.h,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: <Widget>[
                              Positioned.fill(
                                child: ClipOval(
                                  child: Assets.images.png.profileimg.image(
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: -1.w,
                                bottom: -1.h,
                                child: Container(
                                  width: 19.w,
                                  height: 19.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.white,
                                    border: Border.all(
                                      color: AppColors.fintechBlue,
                                      width: 1.2.w,
                                    ),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: AppColors.fintechDarkScrim
                                            .withValues(alpha: 0.18),
                                        blurRadius: 8.r,
                                        offset: Offset(0, 2.h),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    LucideIcons.pencilLine400,
                                    color: AppColors.fintechBlue,
                                    size: 10.r,
                                  ),
                                ),
                              ),
                            ],
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
                          svgPath: Assets.images.svg.eStatement,
                          iconSize: const Size(16, 20),
                          onTap: () => _showPlaceholder(),
                        ),
                        SizedBox(height: FintechSpacing.md.h),
                        _DrawerTile(
                          title: 'Credit Card',
                          svgPath: Assets.images.svg.card,
                          iconSize: const Size(20, 16),
                          onTap: () {
                            ref.read(profileDrawerUiProvider.notifier).close();
                            context.pushNamed(AppRouter.cardsScreen);
                          },
                        ),
                        SizedBox(height: FintechSpacing.md.h),
                        _DrawerTile(
                          title: 'Settings',
                          svgPath: Assets.images.svg.setting,
                          iconSize: const Size(20, 22),
                          onTap: () => _showPlaceholder(),
                        ),
                        SizedBox(height: FintechSpacing.xxxl.h),
                        AppText(
                          text: 'Notification',
                          style: AppTextStyle.titleLarge.copyWith(
                            color: FintechColors.textPrimary(context),
                          ),
                        ),
                        SizedBox(height: FintechSpacing.md.h),
                        _DrawerSwitchTile(
                          title: 'App Notification',
                          icon: LucideIcons.bellDot400,
                          iconSize: 18,
                          value: drawerState.notificationsEnabled,
                          onChanged: (value) {
                            ref
                                .read(profileDrawerUiProvider.notifier)
                                .toggleNotifications(value);
                          },
                        ),
                        SizedBox(height: FintechSpacing.xxxl.h),
                        AppText(
                          text: 'More',
                          style: AppTextStyle.titleLarge.copyWith(
                            color: FintechColors.textPrimary(context),
                          ),
                        ),
                        SizedBox(height: FintechSpacing.md.h),
                        _DrawerTile(
                          title: 'Language',
                          svgPath: Assets.images.svg.language,
                          iconSize: const Size(22, 22),
                          onTap: () => _showPlaceholder(),
                        ),
                        SizedBox(height: FintechSpacing.md.h),
                        _DrawerTile(
                          title: 'Country',
                          svgPath: Assets.images.svg.country,
                          iconSize: const Size(26, 24),
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
                        AppImageView(
                          svgPath: Assets.images.svg.logout,
                          width: 18.w,
                          height: 18.h,
                          fit: BoxFit.contain,
                          color: AppColors.danger500,
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
    required this.svgPath,
    required this.iconSize,
    required this.onTap,
  });

  final String title;
  final String svgPath;
  final Size iconSize;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: FintechSpacing.xs.w,
          vertical: FintechSpacing.xs.h,
        ),
        decoration: BoxDecoration(
          color: FintechColors.surface(context),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          children: <Widget>[
            _DrawerIconBubble(svgPath: svgPath, assetSize: iconSize),
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
    required this.iconSize,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final IconData icon;
  final double iconSize;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: FintechSpacing.xs.w,
        vertical: FintechSpacing.xs.h,
      ),
      decoration: BoxDecoration(
        color: FintechColors.surface(context),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        children: <Widget>[
          _DrawerIconBubble(icon: icon, iconSize: iconSize),
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

class _DrawerIconBubble extends StatelessWidget {
  const _DrawerIconBubble({
    this.svgPath,
    this.assetSize,
    this.icon,
    this.iconSize,
  });

  final String? svgPath;
  final Size? assetSize;
  final IconData? icon;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42.w,
      height: 42.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: FintechColors.mutedSurface(context),
      ),
      child: Center(
        child: svgPath != null
            ? AppImageView(
                svgPath: svgPath,
                width: assetSize!.width.w,
                height: assetSize!.height.h,
                fit: BoxFit.scaleDown,
                color: AppColors.fintechBlue,
              )
            : Icon(
                icon,
                color: AppColors.fintechBlue,
                size: (iconSize ?? 20).r,
              ),
      ),
    );
  }
}
