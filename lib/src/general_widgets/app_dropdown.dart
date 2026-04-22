// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:clean_flutter/src/core/utils/app_utils_exports.dart';
import 'package:clean_flutter/src/general_widgets/general_widget_exports.dart';

class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    super.key,
    this.variant,
    this.alignment,
    this.width,
    this.margin,
    this.focusNode,
    this.initialValue,
    this.hintText,
    this.prefix,
    this.prefixConstraints,
    this.items,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.label,
    this.contentPadding,
    this.dropdownColor,
    this.constraints,
    this.itemTextStyle,
    this.borderColor,
    this.suffix,
    this.dropdownMenuItem,
    this.itemHeight,
    this.menuMaxHeight,
    this.borderRadius,
    this.borderWidth,
    this.radius,
    this.labelColor,
    this.isDense,
    this.height,
  });

  final DropDownVariant? variant;

  final Alignment? alignment;
  final bool? isDense;

  final double? width, height, menuMaxHeight, itemHeight;

  final EdgeInsetsGeometry? margin, contentPadding;

  final FocusNode? focusNode;

  final String? hintText, label;

  final Widget? prefix, suffix;
  final Widget Function(T itemValue)? dropdownMenuItem;
  final TextStyle? itemTextStyle;

  final BoxConstraints? prefixConstraints, constraints;

  final List<T>? items;
  final BorderRadius? borderRadius;
  final double? radius, borderWidth;

  final T? initialValue;
  final Color? dropdownColor, borderColor, labelColor;

  final ValueChanged<T?>? onChanged;
  final ValueChanged<T?>? onSaved;

  final String? Function(dynamic)? validator;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    bool isLightMode = brightness == Brightness.light;
    return alignment != null
        ? _buildDropDownWidget(isLightMode: isLightMode, theme: theme)
        : _buildDropDownWidget(isLightMode: isLightMode, theme: theme);
  }

  _buildDropDownWidget({required bool isLightMode, required ThemeData theme}) {
    return Container(
      width: width,
      alignment: alignment ?? Alignment.center,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            AppText(
              text: label!,
              style: AppTextStyle.titleSmall.copyWith(
                color: labelColor ?? AppColors.neutral100,
              ),
            ),
          if (label != null) Spacing.height(3.h),
          SizedBox(
            height: height,
            child: DropdownButtonFormField(
              focusNode: focusNode,
              initialValue: initialValue,
              dropdownColor: dropdownColor,
              itemHeight: itemHeight,
              isExpanded: true,
              isDense: isDense ?? true,
              menuMaxHeight: menuMaxHeight,
              hint: AppText(
                text: hintText ?? '',
                style: AppTextStyle.titleSmall
                    .copyWith(color: AppColors.neutral100),
                textAlign: TextAlign.center,
              ),
              icon: suffix ??
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: 20.sp,
                  ),
              decoration: _buildDecoration(
                isLightMode: isLightMode,
                theme: theme,
              ),
              items: items?.map<DropdownMenuItem>((value) {
                return DropdownMenuItem(
                  value: value,
                  child: dropdownMenuItem != null
                      ? dropdownMenuItem!(value)
                      : Text(
                          value as String,
                          style: itemTextStyle ?? AppTextStyle.displaySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                );
              }).toList(),
              onChanged: (value) {
                if (onChanged != null) {
                  onChanged!(value);
                }
              },
              validator: validator,
              onSaved: (v) {
                onSaved!(v);
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildDecoration({
    required bool isLightMode,
    required ThemeData theme,
  }) {
    return InputDecoration(
      border: _setBorderStyle(),
      enabledBorder: _setBorderStyle(),
      focusedBorder: _setBorderStyle(),
      hintTextDirection: TextDirection.ltr,
      prefixIcon: prefix,
      prefixIconConstraints: prefixConstraints,
      constraints: constraints,
      fillColor: dropdownColor ??
          (isLightMode
              ? AppColors.defaultBackgroundLight
              : AppColors.defaultBackgroundDark),
      filled: _setFilled(),
      isDense: false,
      contentPadding: contentPadding ??
          EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
    );
  }

  _setBorderStyle() {
    switch (variant) {
      case DropDownVariant.outline:
        return OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 9),
          borderSide: BorderSide(
            color: borderColor ?? AppColors.transparent,
            width: borderWidth ?? 1,
          ),
        );

      case DropDownVariant.underline:
        return UnderlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? AppColors.primary300,
            width: 1,
          ),
        );
      case DropDownVariant.none:
        return InputBorder.none;
      default:
        return OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          borderSide: BorderSide.none,
        );
    }
  }

  _setFilled() {
    switch (variant) {
      case DropDownVariant.outline:
        return true;
      case DropDownVariant.none:
        return false;
      default:
        return true;
    }
  }
}

enum DropDownVariant {
  none,
  underline,
  outline,
}
