// Flutter imports:
// ignore_for_file: deprecated_member_use

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

// Project imports:
import 'package:fintech_app/src/core/extensions/extension_exports.dart';
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

// Project imports:

/// [AppBottomSheet] is a bottomsheet widget built
/// with flutter widgets.
/// ### Params:
/// * [title] - An optional title of the view.
/// * [width] - Optional preferred width of the view
/// * [height] - Optional preferred height of the view
/// * [content] - required body for the sheet where all your custom views
/// goes in.
///
class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    required this.content,
    super.key,
    this.title,
    this.height,
    this.width,
    this.subtitle,
    this.onExitTap,
    this.cancelPadding,
    this.titleWidget,
    this.padding,
    this.canExit = true,
    this.hasHeaders = true,
  });
  final String? title;
  final Widget? titleWidget;
  final String? subtitle;
  final Widget content;
  final double? height;
  final double? width;
  final GestureTapCallback? onExitTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? cancelPadding;
  final bool canExit;
  final bool hasHeaders;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ColorFilter.mode(
        Colors.black.withOpacity(0.2),
        BlendMode.srcOver,
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * .95,
          minHeight: 100,
          minWidth: width ?? MediaQuery.of(context).size.width,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          color: Colors.white,
        ),
        padding: padding ?? const EdgeInsets.all(20),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (canExit)
                  Padding(
                    padding: cancelPadding ?? EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Text(
                          title ?? '',
                          style: context.textTheme.s18w700.copyWith(
                            color: AppColors.defaultBG,
                          ),
                        ),
                        GestureDetector(
                          onTap: onExitTap ?? () => Navigator.pop(context),
                          child: Container(
                            height: 32.h,
                            width: 32.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.neutral50,
                            ),
                            child: SvgPicture.asset(
                              'assets/svgs/exit.svg',
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: content,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

showAppBottomSheet({
  required BuildContext context,
  required Widget child,
  double? width,
  double? height,
  double? paddingTop,
  double? paddingLeft,
  double? paddingRight,
  AlignmentGeometry? alignment,
  BorderRadiusGeometry? borderRadius,
  Color? backgroundColor,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Theme(
        data: Theme.of(context),
        child: Builder(
          builder: (context) {
            final theme = Theme.of(context);
            return Material(
              type: MaterialType.transparency,
              child: Container(
                alignment: alignment ?? Alignment.topLeft,
                height: height ?? 300.h,
                padding: EdgeInsets.fromLTRB(
                  paddingLeft ?? 16.w,
                  paddingTop ?? 20.h,
                  paddingRight ?? 16.w,
                  MediaQuery.viewInsetsOf(context).bottom,
                ),
                decoration: BoxDecoration(
                  color: backgroundColor ?? theme.scaffoldBackgroundColor,
                  borderRadius:
                      borderRadius ??
                      const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: SingleChildScrollView(child: child),
              ),
            );
          },
        ),
      );
    },
  );
}

showDraggableBottomsheet({
  required BuildContext context,
  required Widget Function(ScrollController scrollController) child,
  double? paddingTop,
  double? paddingLeft,
  double? paddingRight,
  bool showHandle = true,
  bool useSafeArea = false,
  AlignmentGeometry? alignment,
  BorderRadiusGeometry? borderRadius,
  Color? backgroundColor,
  double? maxChildSize,
  double? handleWidth,
  double? handleAndContentBottomSpace,
  initialChildSize,
  minChildSize,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: useSafeArea,
    backgroundColor: Colors.transparent,
    builder: (context) => _makeDissmissible(
      context: context,
      child: Theme(
        data: Theme.of(context),
        child: DraggableScrollableSheet(
          initialChildSize: initialChildSize ?? 0.5,
          minChildSize: minChildSize ?? 0.25,
          maxChildSize: maxChildSize ?? 1.0,
          builder: (_, controller) {
            final theme = Theme.of(context);
            return Material(
              type: MaterialType.transparency,
              child: Container(
                // alignment: alignment ?? Alignment.topRight,
                padding: EdgeInsets.only(
                  left: paddingLeft ?? 16.w,
                  top: 8.h,
                  right: paddingRight ?? 16.w,
                  bottom: MediaQuery.viewInsetsOf(context).bottom,
                ),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius:
                      borderRadius ??
                      const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: NotificationListener(
                  onNotification:
                      (OverscrollIndicatorNotification? overScroll) {
                        overScroll?.disallowIndicator();
                        return true;
                      },
                  child: Column(
                    children: [
                      if (showHandle) ...[
                        Spacing.height(10.h),
                        AppListView(
                          height: 6.h,
                          width: handleWidth ?? 48.w,
                          shrinkWrap: true,
                          decoration: BoxDecoration(
                            color: AppColors.white100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          scrollController: controller,
                          children: const [],
                        ),
                        Spacing.height(handleAndContentBottomSpace ?? 10.h),
                        Expanded(child: child(controller)),
                      ] else
                        Expanded(child: child(controller)),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}

Widget _makeDissmissible({
  required Widget child,
  required BuildContext context,
}) => GestureDetector(
  behavior: HitTestBehavior.opaque,
  onTap: () => Navigator.pop(context),
  child: GestureDetector(onTap: () {}, child: child),
);
