// Flutter imports:
import 'package:clean_flutter/src/core/utils/app_utils_exports.dart';
import 'package:clean_flutter/src/general_widgets/general_widget_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_form_field/phone_form_field.dart';

// Project imports:

// Project imports:

class AppTextField extends StatefulWidget {
  final double? width, height;
  final double? labelSize, borderWidth;
  final String? hintText;
  final TextEditingController? controller;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final bool? obscureText;
  final bool? enabled;
  final FormFieldValidator<String>? validateFunction;
  final void Function(String text)? onSaved, onChange;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode, nextFocusNode;
  final VoidCallback? submitAction;
  final bool? enableErrorMessage;
  final void Function(String)? onFieldSubmitted;
  final Widget? suffixIcon, prefixIcon, prefix, suffix;
  final Color? bordercolor, backgroundColor, labelColor, textColor;
  final bool? autofocus;
  final String? label;
  final EdgeInsetsGeometry? contentPadding;
  final String? firstLabel;
  final String? lastLabel;
  final List<TextInputFormatter>? inputFormatters;
  final bool isLoading, readOnly;
  final double borderRadius;
  final BorderRadius? borderRadiusGeometry;
  final BoxConstraints? constraints,
      prefixIconConstraints,
      suffixIconConstraints;
  final TextAlign? textAlign;
  final Key? fieldKey;

  final String? initialValue;

  const AppTextField({
    super.key,
    this.width,
    this.height,
    this.fieldKey,
    this.backgroundColor,
    this.isLoading = false,
    this.hintText,
    this.controller,
    this.minLines = 1,
    this.obscureText = false,
    this.enabled = true,
    this.validateFunction,
    this.onSaved,
    this.onChange,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.nextFocusNode,
    this.submitAction,
    this.enableErrorMessage = true,
    this.maxLines = 1,
    this.maxLength,
    this.readOnly = false,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.prefixIcon,
    this.bordercolor,
    this.autofocus,
    this.label,
    this.firstLabel,
    this.lastLabel,
    this.inputFormatters,
    this.borderRadius = 8,
    this.initialValue,
    this.labelSize,
    this.labelColor,
    this.onTap,
    this.textColor,
    this.borderWidth,
    this.contentPadding,
    this.constraints,
    this.textAlign,
    this.suffix,
    this.prefix,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.borderRadiusGeometry,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  String? error;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final brightness = Theme.of(context).brightness;
    bool isLightMode = brightness == Brightness.light;
    return Container(
      width: widget.width,
      height: widget.height,
      constraints: widget.constraints,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            AppText(
              text: widget.label!,
              style: AppTextStyle.titleSmall.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color:
                    widget.labelColor ?? Theme.of(context).colorScheme.tertiary,
              ),
            ),
          if (widget.label != null) Spacing.height(4.h),
          TextFormField(
            maxLength: widget.maxLength,
            readOnly: widget.readOnly,
            inputFormatters: widget.inputFormatters,
            initialValue: widget.initialValue,
            textAlign: widget.textAlign ?? TextAlign.left,
            autofocus: widget.autofocus ?? false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            enabled: widget.enabled,
            validator: widget.validateFunction != null
                ? widget.validateFunction!
                : (value) {
                    return null;
                  },
            onSaved: (val) {
              error = widget.validateFunction!(val);
              setState(() {});
              widget.onSaved!(val!);
            },
            onChanged: (val) {
              widget.validateFunction != null
                  ? error = widget.validateFunction!(val)
                  : error = null;
              setState(() {});
              if (widget.onChange != null) widget.onChange!(val);
            },
            onTap: widget.onTap,
            style: textTheme.titleSmall?.copyWith(
              color: widget.textColor ??
                  (isLightMode ? AppColors.neutral500 : AppColors.neutral50),
            ),
            // cursorColor: isLightMode ? AppColors.darkBlue : AppColors.white,
            cursorColor: AppColors.primary300,

            key: widget.fieldKey,
            maxLines: widget.maxLines,
            controller: widget.controller,
            obscureText: widget.obscureText!,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction ?? TextInputAction.next,
            focusNode: widget.focusNode,
            onFieldSubmitted: widget.onFieldSubmitted,

            decoration: InputDecoration(
              counter: null,
              counterText: "",
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              prefixIconConstraints: widget.prefixIconConstraints,
              suffixIconConstraints: widget.suffixIconConstraints,
              prefix: widget.prefix,
              suffix: widget.suffix,
              filled: true,
              enabled: false,
              contentPadding: widget.contentPadding,
              fillColor: widget.backgroundColor ??
                  Theme.of(context).scaffoldBackgroundColor,
              hintText: widget.hintText,
              hintStyle:
                  AppTextStyle.titleSmall.copyWith(color: AppColors.neutral100),
              errorStyle:
                  AppTextStyle.titleSmall.copyWith(color: AppColors.danger200),
              errorBorder: OutlineInputBorder(
                borderRadius: widget.borderRadiusGeometry ??
                    BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  color: AppColors.red,
                  width: 0.8,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: widget.borderRadiusGeometry ??
                    BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  color: AppColors.red,
                  width: 1,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: widget.borderRadiusGeometry ??
                    BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  color: widget.bordercolor ??
                      Theme.of(context)
                          .colorScheme
                          .tertiary
                          .withValues(alpha: 0.21),
                  width: widget.borderWidth ?? 0.8,
                ),
              ),
              labelStyle: TextStyle(
                color: AppColors.transparent,
              ),
              border: OutlineInputBorder(
                borderRadius: widget.borderRadiusGeometry ??
                    BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  color: widget.bordercolor ??
                      Theme.of(context)
                          .colorScheme
                          .tertiary
                          .withValues(alpha: 0.21),
                  width: widget.borderWidth ?? 0.8,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: widget.borderRadiusGeometry ??
                    BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  color: widget.bordercolor ??
                      Theme.of(context)
                          .colorScheme
                          .tertiary
                          .withValues(alpha: 0.21),
                  width: widget.borderWidth ?? 0.8,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: widget.borderRadiusGeometry ??
                    BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  color: widget.bordercolor ?? AppColors.primary300,
                  width: widget.borderWidth ?? 0.8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppPinCodeField extends StatelessWidget {
  const AppPinCodeField({
    super.key,
    this.onComplete,
    required this.onChange,
    this.controller,
    this.obscureText,
    this.obscureCharacter,
    this.keyboardType,
    this.fieldBorderStyle,
    this.borderRadius,
    this.fieldBackgroundColor,
    this.activeBackgroundColor,
    this.length,
    this.errorText,
  });
  final Function(String pin)? onChange, onComplete;
  final TextEditingController? controller;
  final bool? obscureText;
  final String? obscureCharacter;
  final String? errorText;
  final int? length;
  final TextInputType? keyboardType;
  final FieldBorderStyle? fieldBorderStyle;
  final BorderRadius? borderRadius;
  final Color? fieldBackgroundColor, activeBackgroundColor;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final brightness = Theme.of(context).brightness;
    bool isLightMode = brightness == Brightness.light;
    final color = Theme.of(context).scaffoldBackgroundColor;

    return Column(
      key: ValueKey(errorText),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PinCodeFields(
          length: length ?? 6,
          onComplete: onComplete ?? (pin) {},
          controller: controller,
          onChange: onChange,
          keyboardType: keyboardType ?? TextInputType.number,
          fieldBorderStyle: fieldBorderStyle ?? FieldBorderStyle.square,
          borderColor: errorText != null
              ? AppColors.danger100
              : Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.21),

          // borderColor: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.21),
          obscureCharacter: obscureCharacter ?? "⚫️",
          obscureText: obscureText ?? false,
          // activeBorderColor: AppColors.primary300,
          activeBorderColor:
              errorText != null ? AppColors.danger100 : AppColors.primary300,
          activeBackgroundColor: activeBackgroundColor ?? color,
          fieldBackgroundColor: fieldBackgroundColor ?? color,
          borderWidth: 1.0,
          fieldWidth: 48.r,
          fieldHeight: 48.r,
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          responsive: true,
          textStyle: textTheme.titleSmall!.copyWith(
            color: isLightMode ? AppColors.neutral500 : AppColors.neutral100,
          ),
          animation: Animations.shrink,
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   final textTheme = Theme.of(context).textTheme;
  //   final brightness = Theme.of(context).brightness;
  //   bool isLightMode = brightness == Brightness.light;
  //   final color = Theme.of(context).scaffoldBackgroundColor;
  //   // final color = isLightMode
  //   //     ? AppColors.defaultBackgroundLight
  //   //     : AppColors.darkgreyMobile;

  //   return PinCodeFields(
  //     length: length ?? 6,
  //     onComplete: onComplete ?? (pin) {},
  //     controller: controller,
  //     onChange: onChange,
  //     keyboardType: keyboardType ?? TextInputType.number,
  //     fieldBorderStyle: fieldBorderStyle ?? FieldBorderStyle.square,
  //     borderColor:
  //         Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.21),
  //     obscureCharacter: obscureCharacter ?? "⚫️",
  //     obscureText: obscureText ?? false,
  //     activeBorderColor: AppColors.primary300,
  //     activeBackgroundColor: activeBackgroundColor ?? color,
  //     fieldBackgroundColor: fieldBackgroundColor ?? color,
  //     borderWidth: 1.0,
  //     fieldWidth: 48.r,
  //     fieldHeight: 48.r,
  //     borderRadius: borderRadius ?? BorderRadius.circular(12),
  //     responsive: true,
  //     // textStyle: textTheme.titleSmall!.copyWith(
  //     //     fontWeight: FontWeight.w600,
  //     //     color: isLightMode ? AppColors.darkBlue : AppColors.white),
  //     textStyle: textTheme.titleSmall!.copyWith(
  //         color: (isLightMode ? AppColors.neutral500 : AppColors.neutral100)),
  //     animation: Animations.shrink,
  //     padding: EdgeInsets.zero,

  //   );

  // }
}

class AppPhoneField extends StatelessWidget {
  const AppPhoneField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius = 8,
    this.backgroundColor,
    this.hintText,
    this.enabled,
    this.onChange,
    this.onSaved,
    this.autofocus = true,
    this.phoneController,
    required this.phoneFieldKey,
    this.countryButtonStyle,
    this.countrySelectorNavigator,
    this.showCountryCode,
    this.label,
    this.bordercolor,
    this.labelColor,
    this.validator,
  });
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double borderRadius;
  final bool autofocus;
  final bool? showCountryCode;
  final bool? enabled;
  final String? hintText;

  final Color? backgroundColor;
  final Color? bordercolor, labelColor;
  final String? label;
  final PhoneController? phoneController;
  final Function(PhoneNumber? phoneNumber, bool isValid)? onSaved, onChange;
  final GlobalKey<FormFieldState> phoneFieldKey;
  final CountryButtonStyle? countryButtonStyle;
  final CountrySelectorNavigator? countrySelectorNavigator;
  final String? Function(PhoneNumber?)? validator;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final brightness = Theme.of(context).brightness;
    bool isLightMode = brightness == Brightness.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          AppText(
            text: label!,
            style: AppTextStyle.titleSmall.copyWith(
              color: labelColor ?? Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
          ),
        if (label != null) Spacing.height(4.h),
        PhoneFormField(
          key: phoneFieldKey,
          controller: phoneController,
          enabled: enabled ?? true,
          // cursorColor: (isLightMode ? AppColors.darkBlue : AppColors.gray100),
          cursorColor: Theme.of(context).colorScheme.primary,
          initialValue: phoneController == null
              ? PhoneNumber.parse(
                  '+1',
                )
              : null,
          validator: validator,
          //!Take this to anywhere validation is required
          // PhoneValidator.compose([
          //   PhoneValidator.required(context),
          //   PhoneValidator.validMobile(context)
          // ]),
          countryButtonStyle: countryButtonStyle ?? const CountryButtonStyle(),
          countrySelectorNavigator: countrySelectorNavigator ??
              CountrySelectorNavigator.draggableBottomSheet(
                minChildSize: 0.4,
                maxChildSize: 0.8,
                initialChildSize: 0.5,
                titleStyle: AppTextStyle.titleSmall
                    .copyWith(fontWeight: FontWeight.w500),
                subtitleStyle: AppTextStyle.titleSmall,
                searchBoxTextStyle: AppTextStyle.titleSmall,
                flagSize: 24.r,
                showDialCode: showCountryCode ?? true,
              ),
          onChanged: (phone) {
            final isValid = phoneFieldKey.currentState!.isValid;
            if (onChange != null) {
              onChange!(phone, isValid);
            }
          },
          onSaved: (phone) {
            final isValid = phoneFieldKey.currentState!.isValid;
            onSaved!(phone, isValid);
          },
          style: textTheme.titleSmall?.copyWith(
            color:
                //  textColor ??
                (isLightMode ? AppColors.neutral500 : AppColors.neutral50),
            //     (isLightMode ? AppColors.neutral500 : AppColors.neutral100),
          ),
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            enabled: true,
            fillColor:
                backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
            hintText: hintText,
            hintStyle:
                AppTextStyle.titleSmall.copyWith(color: AppColors.neutral100),
            errorStyle: AppTextStyle.titleSmall
                .copyWith(color: AppColors.danger200, fontSize: 11.sp),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: AppColors.danger100,
                width: 0.8,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: AppColors.danger100,
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: Theme.of(context)
                    .colorScheme
                    .tertiary
                    .withValues(alpha: 0.21),
                width: 0.8,
              ),
            ),
            labelStyle: TextStyle(
              color: AppColors.transparent,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: Theme.of(context)
                    .colorScheme
                    .tertiary
                    .withValues(alpha: 0.21),
                width: 0.8,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: Theme.of(context)
                    .colorScheme
                    .tertiary
                    .withValues(alpha: 0.21),
                width: 0.8,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: Theme.of(context)
                    .colorScheme
                    .tertiary
                    .withValues(alpha: 0.21),
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
