// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:fintech_app/src/core/extensions/stateless_widget_extensions.dart';
import 'package:fintech_app/src/core/utils/theme/app_text_styles.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

class AppKeypad extends StatefulWidget {
  const AppKeypad({
    GlobalKey<AppKeypadState>? controller,
    this.onKeyPress,
    this.onFinish,
    required this.totalFields,
    this.rightSideWidget,
    this.leftSideWidget,
    this.width,
    this.height,
    this.keypadHeight,
    this.keypadWidth,
    this.keypadBorderRadius,
    this.keypadDecoration,
    this.keypadChildAlignment,
    this.keypadContentPadding,
    this.crossAxisSpacing,
    this.mainAxisSpacing,
    this.maxWidthForEachKeypad,
    this.aspectRatio,
    this.clearIcon,
    this.onClear,
  }) : super(key: controller);
  final int totalFields;
  final double? crossAxisSpacing, mainAxisSpacing;
  final EdgeInsetsGeometry? keypadContentPadding;
  final Alignment? keypadChildAlignment;
  final BoxDecoration? keypadDecoration;
  final BorderRadiusGeometry? keypadBorderRadius;
  final double? width,
      height,
      aspectRatio,
      keypadHeight,
      keypadWidth,
      maxWidthForEachKeypad;
  final Widget? rightSideWidget, leftSideWidget, clearIcon;

  final Function(String currentEnteredValues)? onKeyPress;
  final Function(String totalEnteredValues)? onFinish;
  final Function()? onClear;

  @override
  State<AppKeypad> createState() => AppKeypadState();
}

class AppKeypadState extends State<AppKeypad> {
  List<String>? enteredValues = [];
  //LEAVE THE EMPTY SPACES IT REPRESENTS THE SIDE WIDGETS
  final keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '', '0', ''];

  clear() {
    HapticFeedback.mediumImpact();
    if ((enteredValues ?? []).isNotEmpty) {
      enteredValues?.removeLast();
      if (widget.onClear != null) {
        widget.onClear!();
      }
      if (widget.onKeyPress != null) {
        widget.onKeyPress!(enteredValues!.join());
      }
    }
  }

  clearAllValues() {
    if ((enteredValues ?? []).isNotEmpty) {
      enteredValues?.clear();
      if (widget.onKeyPress != null) {
        widget.onKeyPress!(enteredValues!.join());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppGridview.count(
      height: widget.height,
      width: widget.width,
      childAspectRatio: widget.aspectRatio,
      crossAxisCount: 3,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(keys.length, (index) {
        final key = keys[index];
        if (index == 9) {
          return widget.rightSideWidget ?? const SizedBox.shrink();
        }
        if (index == 11) {
          return widget.leftSideWidget ??
              AppContainer(
                height: widget.keypadHeight ?? 66.h,
                width: widget.keypadWidth ?? 66.w,
                padding: widget.keypadContentPadding ?? EdgeInsets.zero,
                alignment: widget.keypadChildAlignment ?? Alignment.center,
                borderRadius:
                    widget.keypadBorderRadius ?? BorderRadius.circular(33),
                decoration: widget.keypadDecoration,
                child:
                    widget.clearIcon ??
                    const Icon(CupertinoIcons.delete_left_fill),
              ).addTapGesture(
                onTap: () {
                  clear();
                },
              );
        }
        return AppContainer(
          height: widget.keypadHeight ?? 66.h,
          width: widget.keypadWidth ?? 66.w,
          padding: widget.keypadContentPadding ?? EdgeInsets.zero,
          alignment: widget.keypadChildAlignment ?? Alignment.center,
          borderRadius: widget.keypadBorderRadius ?? BorderRadius.circular(33),
          decoration: widget.keypadDecoration,
          child: AppText(
            text: key,
            style: AppTextStyle.titleMedium.copyWith(fontSize: 25.w),
          ),
        ).addTapGesture(
          onTap: () {
            HapticFeedback.mediumImpact();
            if (enteredValues!.length != widget.totalFields) {
              enteredValues?.add(key);
              if (widget.onKeyPress != null) {
                widget.onKeyPress!(enteredValues!.join());
              }
            }
            if (enteredValues!.length == widget.totalFields &&
                widget.onFinish != null) {
              widget.onFinish!(enteredValues!.join());
            }
          },
        );
      }),
    );
  }
}
