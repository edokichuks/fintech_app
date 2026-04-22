// Flutter imports:
import 'dart:io';

import 'package:clean_flutter/main.dart';
import 'package:clean_flutter/src/core/device_features/device_feature_exports.dart';
import 'package:clean_flutter/src/features/home/views/home_screen.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:clean_flutter/src/core/utils/app_utils_exports.dart';
import 'package:clean_flutter/src/features/bottom_nav/domain/models/app_bottom_nav_model.dart';
import 'package:clean_flutter/src/features/bottom_nav/domain/notifier/app_bottom_nav_notifier.dart';
import 'package:clean_flutter/src/general_widgets/general_widget_exports.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBottomNavScreen extends ConsumerStatefulWidget {
  const AppBottomNavScreen({super.key});
  @override
  ConsumerState createState() => _AppBottomNavScreenState();
}

class _AppBottomNavScreenState extends ConsumerState<AppBottomNavScreen> {
  final List<Widget> _pages = const [
    HomeScreen(),
    TodoScreen(),
    TodoScreen(),
    TodoScreen(),
  ];
  final NewVersionPlus _newVersion = NewVersionPlus();
  Future<void> _checkVersion() async {
    debugPrint('Checking versioning');
    final status = await _newVersion.getVersionStatus();
    if (status != null && status.canUpdate) {
      if (Platform.isAndroid) {
        if (!mounted) return;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              // backgroundColor: const Color(0xFF1C1C1E),
              insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      text: 'Update Available',
                      style: AppTextStyle.titleLarge.copyWith(fontSize: 20.sp),
                    ),
                    Spacing.height(16.h),
                    AppText(
                      text:
                          'A newer version (${status.storeVersion}) of this app is available on the store.\nYou are currently using ${status.localVersion}.',
                      style: AppTextStyle.titleSmall.copyWith(
                        color: AppColors.neutral200,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Spacing.height(24.h),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              final url = Uri.parse(status.appStoreLink);
                              if (await canLaunchUrl(url)) {
                                await launchUrl(
                                  url,
                                  mode: LaunchMode.externalApplication,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary300,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              elevation: 0,
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                            ),
                            child: AppText(
                              text: 'Update',
                              style: AppTextStyle.titleSmall.copyWith(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        _newVersion.showUpdateDialog(
          context: context,
          versionStatus: status,
          dialogTitle: 'Update Available',
          dialogText:
              'A newer version (${status.storeVersion}) of this app is available on the store.\nYou are currently using ${status.localVersion}.',
          updateButtonText: 'Update',
          dismissButtonText: 'Later',
          allowDismissal: false,
          dismissAction: () {
            debugPrint('User dismissed the update dialog');
          },
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _handleNotification();
      await _checkVersion();
    });
  }

  Future<void> _handleNotification() async {
    await DeviceNotification.instance.handleMesssage(
      onMessageReceived: (message, isInit) async {
        if (isInit ?? false) {
        } else {
          debugLog('IN APP BOTTOM NAV TYPE ==> ${message.data['type']}');
        }
      },
    );
  }

  void _onItemTapped(int index) {
    ref.read(appBottomNavProdivder.notifier).moveToTab(index: index);
  }

  final tabs = [
    BottomTabItemModel(
      inActiveIcon: AppImages.homeInactive,
      icon: AppImages.homeActive,
      label: 'Home',
    ),
    BottomTabItemModel(
      inActiveIcon: AppImages.historyInactive,
      icon: AppImages.historyActive,
      label: 'Attendance',
      isMaterialIcon: true,
      materialIcon: Icons.access_time_outlined,
      materialIconActive: Icons.access_time_filled,
    ),
    BottomTabItemModel(
      inActiveIcon: AppImages.historyInactive,
      icon: AppImages.historyActive,
      label: 'History',
    ),
    BottomTabItemModel(
      inActiveIcon: AppImages.profileInactive,
      icon: AppImages.profileActive,
      label: 'Settings',
      isMaterialIcon: true,
      materialIcon: Icons.settings_outlined,
      materialIconActive: Icons.settings,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final tabIndex = ref.watch(appBottomNavProdivder).currentTabIndex;
    // _listenForSignIn();
    return UpgradeAlert(
      upgrader: Upgrader(
        debugLogging: true,
        messages: MyCustomUpgraderMessages(),
        countryCode: 'NG',
        // minAppVersion: '1.0.0',
        debugDisplayAlways: true,
      ),
      showIgnore: false,
      showLater: false,
      barrierDismissible: true,
      navigatorKey: navigatorKey,
      dialogStyle: UpgradeDialogStyle.cupertino,
      child: AppScaffold(
        applySafeArea: false,
        // NOTE: REMOVE THIS BECAUSE EACH TAB USES [AppScaffold] AND IT HAS A DEFALUT PADDING
        padding: EdgeInsets.zero,
        body: _pages[tabIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: List.generate(tabs.length, (index) {
            final tabItem = tabs[index];
            final bool isSelected = tabIndex == index;
            return BottomNavigationBarItem(
              icon: AppContainer(
                padding: EdgeInsets.zero,
                height: 44.h,
                margin: EdgeInsets.only(left: 6.w, right: 6.w, top: 10.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary300 : null,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (tabItem.isMaterialIcon && tabItem.materialIcon != null)
                      Icon(
                        isSelected
                            ? (tabItem.materialIconActive ??
                                  tabItem.materialIcon!)
                            : tabItem.materialIcon!,
                        size: 24.r,
                        color: isSelected ? AppColors.white : null,
                      )
                    else
                      SvgPicture.asset(
                        isSelected ? tabItem.icon : tabItem.inActiveIcon,
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.cover,
                      ),
                    if (isSelected) ...[
                      const Spacing.widthXS(),
                      const Spacing.widthXXS(),
                      Text(
                        tabItem.label,
                        style: AppTextStyle.titleSmall.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          //SET TO NULL SO IT WOULD FALLBACK TO THE THEME COLORS
                          color: isSelected ? AppColors.white : null,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              label: '',
            );
          }),
          currentIndex: tabIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  // _listenForSignIn() async {
  //   final auth = await UserStoreManager.getSavedAuthDetails();
  //   final userHasVerifiedNinPreviously = auth?.nin ?? false;
  //   // print('IS VERIFIFED VALUE IS ? $userHasVerifiedNinPreviously');
  //   //CHECK THE SCREEN IF USER HAS VERIFIED THERE NIN
  //   if (!userHasVerifiedNinPreviously) {
  //     navigatorKey.currentState!
  //         .pushReplacementNamed(AppRoutes.verifyNinScreen);
  //   }
  //   //CHECK THE SCREEN IF USER HAS CREATED A PASSCODE
  //   else if (!(auth?.passcode ?? false)) {
  //     navigatorKey.currentState!
  //         .pushReplacementNamed(AppRoutes.createPasscodeScreen);
  //   }
  //   //CHECK THE SCREEN IF USER HAS SET PIN
  //   else if (!(auth?.pin ?? false)) {
  //     navigatorKey.currentState!
  //         .pushReplacementNamed(AppRoutes.setTranscriptionPinScreen);
  //   } else {}
  //   //GO TO DASHBOARD IF AUTH IS COMPLETE
  // }
}

class MyCustomUpgraderMessages extends UpgraderMessages {
  @override
  String get title => 'Update Required';

  @override
  String get body => 'Please update this app to continue using it.';

  @override
  String get prompt => 'Update Now';
}
