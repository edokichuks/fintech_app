// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:clean_flutter/src/core/helpers/helper_functions.dart';
import 'package:clean_flutter/src/core/utils/app_utils_exports.dart';

//MAIN SCAFFOLD FOR APPLICATION CHECK BELOW FOR THE
//OF WHITE SCAFFOLD
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.backgroundColor,
    this.appBar,
    this.padding,
    this.applySafeArea = true,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.resizeToAvoidBottomInset = true,
  });
  final Widget body;
  final Widget? bottomNavigationBar, bottomSheet;
  final PreferredSizeWidget? appBar;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final bool applySafeArea, resizeToAvoidBottomInset;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final orientation = MediaQuery.orientationOf(context);
    final isLandscape = orientation == Orientation.landscape && applySafeArea;
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor ?? theme.scaffoldBackgroundColor,
      body: Padding(
        padding: (HelperFunctions.isAndroid() &&
                applySafeArea &&
                !isLandscape) // BOTTOM SAFE AREA SETUP FOR ANDROID
            ? EdgeInsets.only(bottom: 16.h)
            : EdgeInsets.zero,
        child: SafeArea(
          left: isLandscape,
          right: isLandscape,
          top: applySafeArea,
          bottom: applySafeArea,
          child: Padding(
            padding: padding ?? EdgeInsets.symmetric(horizontal: 14.w),
            child: body,
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}

//THIS SCAFFOLD IS USED FOR SCREENS WHERE THEIR LIGHT MODE
//USES A OFFWHITE BACKGROUND COLOR e.g [DashboardScreen]
class AppScaffoldOffWhite extends StatelessWidget {
  const AppScaffoldOffWhite({
    super.key,
    required this.body,
    this.backgroundColor,
    this.appBar,
    this.padding,
    this.applySafeArea = true,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.resizeToAvoidBottomInset = true,
  });
  final Widget body;
  final Widget? bottomNavigationBar, bottomSheet;
  final PreferredSizeWidget? appBar;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final bool applySafeArea, resizeToAvoidBottomInset;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLightMode = theme.brightness == Brightness.light;
    final scaffoldBackgroundColor =
        isLightMode ? AppColors.defaultBackgroundLight : AppColors.neutral500;
    final orientation = MediaQuery.orientationOf(context);
    final isLandscape = orientation == Orientation.landscape && applySafeArea;
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor ?? scaffoldBackgroundColor,
      body: Padding(
        padding: (HelperFunctions.isAndroid() &&
                applySafeArea &&
                !isLandscape) // BOTTOM SAFE AREA SETUP FOR ANDROID
            ? EdgeInsets.only(bottom: 16.h)
            : EdgeInsets.zero,
        child: SafeArea(
          left: isLandscape,
          right: isLandscape,
          top: applySafeArea,
          bottom: applySafeArea,
          child: Padding(
            padding: padding ?? EdgeInsets.symmetric(horizontal: 14.w),
            child: body,
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}
