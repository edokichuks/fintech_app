// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

// import 'package:flutter/material.dart';

class AppOnScreenKeyboard extends StatefulWidget {
  const AppOnScreenKeyboard({
    super.key,
    this.onKeyPress,
    this.totalFields = 6,
    this.onFinish,
    this.keyboardHeight,
    this.keyboardWidth,
    this.error = false,
    this.fieldsAndKeypadVerticalSpace,
    this.onError,
    this.leftSideWidget,
    this.rightSideWidget,
    this.onClear,
  });

  final Widget? leftSideWidget, rightSideWidget;
  final int totalFields;
  final bool error;
  final Spacing? fieldsAndKeypadVerticalSpace;
  final double? keyboardWidth, keyboardHeight;
  final Function(String currentFieldValues)? onKeyPress;
  final Function(String allFieldValues)? onFinish;
  final Function()? onError;
  final Function()? onClear;

  @override
  State<AppOnScreenKeyboard> createState() => _AppOnScreenKeyboardState();
}

class _AppOnScreenKeyboardState extends State<AppOnScreenKeyboard> {
  String? selectedValues;
  final shakeKey = GlobalKey<AppShakeWidgetState>();

  bool _userEnteredWrongValue = false;

  @override
  void didUpdateWidget(covariant AppOnScreenKeyboard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.error) {
      setState(() {
        _userEnteredWrongValue = widget.error;
      });
      shakeKey.currentState?.shakeWidget();
      if (widget.onError != null) {
        widget.onError!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPasscodeDisplay(),
        widget.fieldsAndKeypadVerticalSpace ?? Spacing.height(28.h),
        AppKeypad(
          totalFields: widget.totalFields,
          height: widget.keyboardHeight,
          width: widget.keyboardWidth,
          leftSideWidget: widget.leftSideWidget,
          rightSideWidget: widget.rightSideWidget,
          onClear: widget.onClear,
          onKeyPress: (currentEnteredValues) {
            setState(() {
              selectedValues = currentEnteredValues;
              //IF THERE WAS AN ERROR PREVIOUS THE WOULD
              //RESET AND UPDATE THE UI
              if (_userEnteredWrongValue) {
                setState(() {
                  _userEnteredWrongValue = false;
                });
              }
            }); // UPDATES THE OTP FIELDS UI AND ANIMATION
            if (widget.onKeyPress != null && selectedValues != null) {
              widget.onKeyPress!(selectedValues!);
            }
          },
          onFinish: (totalEnteredValues) {
            selectedValues = totalEnteredValues;
            if (widget.onFinish != null && selectedValues != null) {
              widget.onFinish!(selectedValues!);
            }
          },
        ),
      ],
    );
  }

  Widget _buildPasscodeDisplay() {
    final totalOtpFields = (selectedValues?.length ?? 0);
    return AppShakeWidget(
      key: shakeKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.totalFields, (index) {
          // THE INDEX MUST BE <= TO THE ENTERED TEXT FROM THE UI TO BE ACTIVE
          final hasEnteredValueInFields = index <= totalOtpFields - 1;
          return AppPasscodeDisplay(
            error: _userEnteredWrongValue,
            //THE SPACING BETWEEN EACH WIDGET
            spacing: 8.w,
            //IF THE USER HAS NOT ENTERED VALUES IN THE FIELD THE PASSCODE
            // WIDGET SHOULD BE EMPTY IF NOT EMPTY USE THE DEFAULT WIDGET
            contentWidget: !hasEnteredValueInFields
                ? const SizedBox.shrink()
                : null,
          );
        }),
      ),
    );
  }
}
