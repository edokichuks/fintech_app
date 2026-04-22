// Flutter imports:
import 'package:flutter/material.dart';

// A CUSTOM CONTAINER THAT CHANGES ITS BG COLOR ACCORDING TO THE THEME
class AppContainer extends StatelessWidget {
  const AppContainer({
    super.key,
    this.alignment,
    this.height,
    this.padding,
    this.decoration,
    this.width,
    this.paddingSelf,
    this.borderRadius,
    required this.child,
    this.color,
    this.border,
    this.margin,
    this.constraints,
    this.alignSelf,
  });
  final double? height, width;
  final Widget child;
  final EdgeInsetsGeometry? padding, margin, paddingSelf;
  final BoxDecoration? decoration;
  final Alignment? alignment;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final BoxBorder? border;
  final AlignmentGeometry? alignSelf;
  final BoxConstraints? constraints;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: alignSelf ?? Alignment.center,
      child: Padding(
        padding: paddingSelf ?? EdgeInsets.zero,
        child: Container(
          height: height,
          width: width,
          margin: margin,
          constraints: constraints,
          padding: padding ?? const EdgeInsets.all(16),
          decoration: decoration ??
              BoxDecoration(
                color: color ?? theme.colorScheme.primary,
                borderRadius: borderRadius ?? BorderRadius.circular(16),
                border: border,
              ),
          alignment: alignment,
          child: child,
        ),
      ),
    );
  }
}
