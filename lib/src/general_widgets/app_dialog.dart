// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

class AppDialog extends StatefulWidget {
  const AppDialog({required this.child, super.key});

  final Widget child;

  @override
  State<AppDialog> createState() => _MessageDialogState();
}

class _MessageDialogState extends State<AppDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 58.h),
        child: widget.child,
      ),
    );
  }
}

showAppDialogue({
  required BuildContext context,
  String? title,
  String? subtitle,
  Widget? content,
  List<Widget>? actions,
  bool dismissible = true,
  double? width,
  double? height,
  EdgeInsetsGeometry? padding,
  Color? backgroundColor,
  BoxConstraints? constraints,
  Function()? onDismiss,
}) {
  final size = MediaQuery.sizeOf(context);
  showDialog(
    context: context,
    barrierDismissible: dismissible,
    builder: (context) {
      final theme = Theme.of(context);
      return Theme(
        data: Theme.of(context),
        child: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                if (dismissible) {
                  Navigator.pop(context);
                  onDismiss?.call();
                }
              },
              child: Container(
                color: backgroundColor ?? AppColors.transparent,
                alignment: Alignment.center,
                child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    width: width ?? size.width * .9,
                    //DON'T SET A DEFAULT HEIGHT LET THE CHILD TAKE AAS MUCH AS AVAILABLE
                    //TO BE RESPONSIVE ACROSS DEVICES
                    height: height,
                    padding:
                        padding ?? EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 16.h),
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    constraints:
                        constraints ?? BoxConstraints(maxHeight: 600.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (title != null)
                          AppText(
                            text: title,
                            style: AppTextStyle.titleSmall.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        if (subtitle != null) ...[
                          Spacing.height(10.h),
                          AppText(
                            text: subtitle,
                            style: AppTextStyle.titleSmall.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                        if (content != null) ...[Spacing.height(20.h), content],
                        if (actions != null && actions.isNotEmpty) ...[
                          Spacing.height(20.h),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: ,
                          // ),
                          ...actions,
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
