// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:clean_flutter/src/general_widgets/general_widget_exports.dart';

class TileWidget extends StatelessWidget {
  const TileWidget({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.subtrailing,
    this.padding,
    this.spacing,
    this.trailingSpace,
    this.height,
    this.onTap,
  });
  final Widget? leading, title, subtitle, trailing, subtrailing;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Spacing? spacing, trailingSpace;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: SizedBox(
          height: height,
          child: Row(
            children: [
              if (leading != null) leading!,
              spacing ?? Spacing.width(6.w),
              if (title != null || subtitle != null) ...[
                if (title != null) ...[
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (title != null) title!,
                        if (subtitle != null) subtitle!,
                      ],
                    ),
                  ),
                ] else ...[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null) title!,
                      if (subtitle != null) subtitle!,
                    ],
                  ),
                  const Spacer(),
                ]
              ],
              if (trailing != null) trailing!,
              trailingSpace ?? Spacing.width(6.w),
              if (subtrailing != null) subtrailing!,
            ],
          ),
        ),
      ),
    );
  }
}
