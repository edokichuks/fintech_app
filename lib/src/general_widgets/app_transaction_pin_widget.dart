// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:fintech_app/src/core/extensions/extension_exports.dart';
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

class AppTransactionPinWidget extends StatefulWidget {
  const AppTransactionPinWidget({
    super.key,
    this.totalFields = 4,
    this.onKeyPress,
    this.onFinish,
    this.error = false,
    this.onError,
  });
  final int totalFields;
  final bool error;
  final Function()? onError;
  final Function(String currentFieldValues)? onKeyPress;
  final Function(String allFieldValues)? onFinish;
  @override
  State createState() => _AppTransactionPinWidgetState();
}

class _AppTransactionPinWidgetState extends State<AppTransactionPinWidget> {
  final shakeKey = GlobalKey<AppShakeWidgetState>();
  String? selectedValues;
  bool _userEnteredWrongValue = false;

  @override
  void didUpdateWidget(covariant AppTransactionPinWidget oldWidget) {
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
    final theme = Theme.of(context);
    return AppContainer(
      color: theme.colorScheme.secondaryContainer,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //THIS IS A PLACEHOLDER TO ALLOW THE
              //TEXT ALIGN TO THE CENTER REMOVE WITH CAUTION
              const SizedBox(width: 20),
              AppText(
                text: 'Enter Pin',
                style: AppTextStyle.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
                textAlign: TextAlign.center,
              ),
              Icon(Icons.clear, size: 20.sp).addTapGesture(
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Spacing.height(20.h),
          _buildPasscodeDisplay(),
          Spacing.height(16.h),
          AppContainer(
            color: theme.colorScheme.primary.withValues(alpha: .2),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Column(
              children: [
                Spacing.height(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppImageView(
                      svgPath: AppImages.secure,
                      height: 14.h,
                      width: 14.w,
                    ),
                    Spacing.width(5.w),
                    AppText(
                      text: 'Milarn Secure Numeric Keypad',
                      style: AppTextStyle.bodySmall.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Spacing.height(7.h),
                AppKeypad(
                  totalFields: widget.totalFields,
                  keypadBorderRadius: BorderRadius.circular(8),
                  keypadWidth: 100.w,
                  keypadHeight: 52.h,
                  keypadContentPadding: EdgeInsets.zero,
                  aspectRatio: 1 / .54,
                  clearIcon: const Icon(CupertinoIcons.delete_left),
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
            ),
          ),
        ],
      ),
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
            // error: _userEnteredWrongValue,
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
