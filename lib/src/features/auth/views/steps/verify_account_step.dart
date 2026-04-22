import 'dart:async';
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VerifyAccountStep extends ConsumerStatefulWidget {
  final VoidCallback onNext;

  const VerifyAccountStep({super.key, required this.onNext});

  @override
  ConsumerState<VerifyAccountStep> createState() => _VerifyAccountStepState();
}

class _VerifyAccountStepState extends ConsumerState<VerifyAccountStep> {
  final _pinController = TextEditingController();
  bool _isEnabled = false;
  int _secondsLeft = 50;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0) {
        setState(() {
          _secondsLeft--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_isEnabled) {
      widget.onNext();
    }
  }

  void _resendCode() {
    if (_secondsLeft == 0) {
      setState(() {
        _secondsLeft = 50;
      });
      _startTimer();
      // Logic for resending OTP would go here
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacing.height(8.h),
          AppText(
            text: 'Verify your Account',
            style: AppTextStyle.headlineSmall.copyWith(
              color: AppColors.neutral500,
              fontWeight: FontWeight.w700,
            ),
          ),
          Spacing.height(8.h),
          RichText(
            text: TextSpan(
              text:
                  'We sent you a 6-digit verification code to your phone number ',
              style: AppTextStyle.bodySmall.copyWith(
                color: AppColors.neutral200,
              ),
              children: [
                TextSpan(
                  text: '+44 *** *** 3051',
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.primary300,
                  ),
                ),
              ],
            ),
          ),
          Spacing.height(32.h),

          AppPinCodeField(
            length: 6,
            controller: _pinController,
            fieldBackgroundColor: AppColors.white,
            activeBackgroundColor: AppColors.white,
            onChange: (pin) {
              setState(() {
                _isEnabled = pin.length == 6;
              });
            },
            onComplete: (pin) {
              setState(() {
                _isEnabled = true;
              });
              _submit();
            },
          ),

          Spacing.height(24.h),

          Row(
            children: [
              AppText(
                text: 'Yet to receive code? ',
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.neutral500,
                ),
              ),
              GestureDetector(
                onTap: _resendCode,
                child: AppText(
                  text: _secondsLeft > 0
                      ? 'Resend in ${_secondsLeft}s'
                      : 'Resend Code',
                  style: AppTextStyle.labelLarge.copyWith(
                    color: AppColors.secondary300,
                  ),
                ),
              ),
            ],
          ),

          Spacing.height(48.h),
          // Submit Button
          AppButton(
            text: 'Verify Account',
            onPressed: _submit,
            isEnabled: _isEnabled,
          ),
        ],
      ),
    );
  }
}
