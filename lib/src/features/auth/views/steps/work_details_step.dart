import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WorkDetailsStep extends ConsumerStatefulWidget {
  final VoidCallback onNext;

  const WorkDetailsStep({super.key, required this.onNext});

  @override
  ConsumerState<WorkDetailsStep> createState() => _WorkDetailsStepState();
}

class _WorkDetailsStepState extends ConsumerState<WorkDetailsStep> {
  final _formKey = GlobalKey<FormState>();

  final _companyController = TextEditingController();
  final _addressController = TextEditingController();

  bool _isEnabled = false;

  @override
  void dispose() {
    _companyController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isEnabled = (_formKey.currentState?.validate() ?? false);
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
              text: 'Confirm where you work',
              style: AppTextStyle.headlineSmall.copyWith(
                color: AppColors.neutral500,
                fontWeight: FontWeight.w700,
              ),
            ),
            Spacing.height(8.h),
            AppText(
              text:
                  'Provide information, upload your payslip, payroll doc, and ID.',
              style: AppTextStyle.bodySmall.copyWith(
                color: AppColors.neutral200,
              ),
            ),
            Spacing.height(32.h),

            // Company/Organisation
            AppTextField(
              label: 'Company/Organisation',
              hintText: 'Provide company/organisation name',
              controller: _companyController,
              textInputAction: TextInputAction.next,
              validateFunction: Validators.notEmpty(),
            ),
            Spacing.height(16.h),

            // Work Address
            AppTextField(
              label: 'Work Address',
              hintText: 'Enter workplace address',
              controller: _addressController,
              textInputAction: TextInputAction.next,
              validateFunction: Validators.notEmpty(),
              suffixIcon: Padding(
                padding: EdgeInsets.all(12.r),
                child: Icon(
                  Icons.location_on,
                  color: AppColors.neutral200,
                  size: 20.r,
                ),
              ),
            ),
            Spacing.height(16.h),

            // Proof of Employment
            _buildUploadSection(
              title: 'Proof of Employment (e.g., contract or HR letter)',
            ),
            Spacing.height(16.h),

            // Recent Payslip
            _buildUploadSection(title: 'Recent Payslip'),
            Spacing.height(16.h),

            // ID card
            _buildUploadSection(
              title: 'ID card (e.g., ID Card, passport, driver\'s license)',
            ),

            Spacing.height(32.h),

            // Submit Button
            AppButton(
              text: 'Save & Continue',
              onPressed: _submit,
              isEnabled: _isEnabled,
            ),
            Spacing.height(32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadSection({required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title,
          style: AppTextStyle.titleSmall.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            color: AppColors.neutral500,
          ),
        ),
        Spacing.height(8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 24.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.tertiary.withValues(alpha: 0.21),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                size: 32.r,
                color: AppColors.secondary300,
              ),
              Spacing.height(12.h),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Click here',
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.secondary300,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: ' to upload your file',
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.neutral500,
                      ),
                    ),
                  ],
                ),
              ),
              Spacing.height(4.h),
              AppText(
                text: 'PDF, JPG, PNG (10mb each)',
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.neutral200,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
