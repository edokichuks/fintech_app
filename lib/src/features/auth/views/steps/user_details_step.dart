import 'package:fintech_app/src/core/router/router.dart';
import 'package:fintech_app/src/core/extensions/navigation_extensions.dart';
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserDetailsStep extends ConsumerStatefulWidget {
  final VoidCallback onNext;

  const UserDetailsStep({super.key, required this.onNext});

  @override
  ConsumerState<UserDetailsStep> createState() => _UserDetailsStepState();
}

class _UserDetailsStepState extends ConsumerState<UserDetailsStep> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _workEmailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isTermsAccepted = false;
  bool _isEnabled = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _workEmailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isEnabled =
          (_formKey.currentState?.validate() ?? false) && _isTermsAccepted;
    });
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_isEnabled) {
      widget.onNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Form(
        key: _formKey,
        onChanged: _validateForm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacing.height(8.h),
            AppText(
              text: 'Let\'s get to know you',
              style: AppTextStyle.headlineSmall.copyWith(
                color: AppColors.neutral500,
                fontWeight: FontWeight.w700,
              ),
            ),
            Spacing.height(8.h),
            AppText(
              text:
                  'Tell us your name, contact details, and set a secure password.',
              style: AppTextStyle.bodySmall.copyWith(
                color: AppColors.neutral200,
              ),
            ),
            Spacing.height(32.h),

            // First Name
            AppTextField(
              label: 'First Name',
              hintText: 'Enter your full name',
              controller: _firstNameController,
              textInputAction: TextInputAction.next,
              validateFunction: Validators.notEmpty(),
            ),
            Spacing.height(16.h),

            // Last Name
            AppTextField(
              label: 'Last Name',
              hintText: 'Enter your last name',
              controller: _lastNameController,
              textInputAction: TextInputAction.next,
              validateFunction: Validators.notEmpty(),
            ),
            Spacing.height(16.h),

            // Work Email
            AppTextField(
              label: 'Work Email',
              hintText: 'Enter your work email',
              controller: _workEmailController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              validateFunction: Validators.email(),
            ),
            Spacing.height(16.h),

            // Phone Number
            AppTextField(
              label: 'Phone Number',
              hintText: 'Enter your number',
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(text: "🇬🇧", style: AppTextStyle.titleMedium),
                    Spacing.width(4.w),
                    AppText(
                      text: "+44",
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.neutral500,
                      ),
                    ),
                    Spacing.width(8.w),
                  ],
                ),
              ),
              controller: _phoneController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              validateFunction: Validators.notEmpty(),
            ),
            Spacing.height(16.h),

            // Password
            AppPasswordField(
              label: 'Password',
              hintText: 'Create your password',
              controller: _passwordController,
              textInputAction: TextInputAction.next,
              validateFunction: Validators.password(),
            ),
            Spacing.height(16.h),

            // Confirm Password
            AppPasswordField(
              label: 'Confirm Password',
              hintText: 'Confirm your password',
              controller: _confirmPasswordController,
              textInputAction: TextInputAction.done,
              validateFunction: (value) => Validators.confirmPass(
                _passwordController.text,
                value ?? '',
              )(value),
            ),
            Spacing.height(24.h),

            // Terms and Conditions
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppCheckBox(
                  initialValue: _isTermsAccepted,
                  onCheck: (val) {
                    setState(() {
                      _isTermsAccepted = val;
                      _validateForm();
                    });
                  },
                ),
                Spacing.width(12.w),
                Expanded(
                  child: AppText(
                    text:
                        'I agree to the Terms and Conditions and Privacy Policy',
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.neutral500,
                    ),
                  ),
                ),
              ],
            ),
            Spacing.height(32.h),

            // Submit Button
            AppButton(
              text: 'Sign Up',
              onPressed: _submit,
              isEnabled: _isEnabled,
            ),
            Spacing.height(24.h),

            // Login Link
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: 'Already have an account? ',
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.neutral500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(AppRouter.login);
                    },
                    child: AppText(
                      text: 'Log In',
                      style: AppTextStyle.labelLarge.copyWith(
                        color: AppColors.secondary300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacing.height(32.h),
          ],
        ),
      ),
    );
  }
}
