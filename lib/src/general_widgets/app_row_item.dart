// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:clean_flutter/src/general_widgets/general_widget_exports.dart';

class AppRowItem extends StatelessWidget {
  const AppRowItem({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    required this.firstItem,
    required this.secondItem,
    this.spacing,
    this.containerDecoration,
    this.height,
    this.width,
    this.containerContentPadding,
    this.showDefaulColorDecoration = false,
    this.containerContentAlignment,
    this.borderRadius,
  });

  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final Widget firstItem;
  final Widget secondItem;
  final Spacing? spacing;
  final bool showDefaulColorDecoration;
  final double? width, height;
  final BoxDecoration? containerDecoration;
  final EdgeInsetsGeometry? containerContentPadding;
  final AlignmentGeometry? containerContentAlignment;
  final BorderRadiusGeometry? borderRadius;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: containerContentPadding,
      alignment: containerContentAlignment,
      decoration: containerDecoration ??
          BoxDecoration(
            color: showDefaulColorDecoration ? theme.colorScheme.primary : null,
            borderRadius: borderRadius,
          ),
      height: height,
      width: width,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        children: [firstItem, spacing ?? const Spacing.widthS(), secondItem],
      ),
    );
  }
}
