// Flutter imports:
import 'package:flutter/material.dart';

class AppGridview extends StatelessWidget {
  const AppGridview({
    super.key,
    this.shrinkWrap = false,
    this.paddingSelf,
    this.padding,
    this.physics,
    this.scrollDirection,
    this.scrollController,
    this.height,
    this.width,
    this.decoration,
    this.alignSelf,
    this.keyboardDismissBehavior,
    this.constraints,
    required this.gridDelegate,
    required this.children,
  });
  final List<Widget> children;
  final SliverGridDelegate gridDelegate;
  final bool shrinkWrap;
  final EdgeInsets? paddingSelf, padding;
  final Axis? scrollDirection;
  final ScrollController? scrollController;
  final ScrollPhysics? physics;
  final double? height, width;
  final BoxDecoration? decoration;
  final AlignmentGeometry? alignSelf;
  final BoxConstraints? constraints;
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;

  static builder({
    required int itemCount,
    required SliverGridDelegate gridDelegate,
    bool shrinkWrap = false,
    EdgeInsets? paddingSelf,
    padding,
    Axis? scrollDirection,
    ScrollController? scrollController,
    ScrollPhysics? physics,
    double? height,
    width,
    BoxDecoration? decoration,
    AlignmentGeometry? alignSelf,
    BoxConstraints? constraints,
    ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior,
    required Widget? Function(BuildContext context, int index) itemBuilder,
  }) {
    return Padding(
      padding: paddingSelf ?? EdgeInsets.zero,
      child: Container(
        height: height,
        width: width,
        alignment: alignSelf,
        constraints: constraints,
        decoration: decoration,
        child: GridView.builder(
          shrinkWrap: shrinkWrap,
          physics: physics,
          padding: padding,
          controller: scrollController,
          keyboardDismissBehavior: keyboardDismissBehavior ??
              ScrollViewKeyboardDismissBehavior.onDrag,
          scrollDirection: scrollDirection ?? Axis.vertical,
          gridDelegate: gridDelegate,
          itemCount: itemCount,
          itemBuilder: itemBuilder,
        ),
      ),
    );
  }

  static count({
    required int crossAxisCount,
    required List<Widget> children,
    bool shrinkWrap = false,
    EdgeInsets? paddingSelf,
    padding,
    Axis? scrollDirection,
    ScrollController? scrollController,
    ScrollPhysics? physics,
    double? height,
    width,
    BoxDecoration? decoration,
    AlignmentGeometry? alignSelf,
    BoxConstraints? constraints,
    double? mainAxisSpacing,
    double? crossAxisSpacing,
    double? childAspectRatio,
    ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior,
  }) {
    return Padding(
      padding: paddingSelf ?? EdgeInsets.zero,
      child: Container(
        height: height,
        width: width,
        alignment: alignSelf,
        constraints: constraints,
        decoration: decoration,
        child: GridView.count(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: mainAxisSpacing ?? 0.0,
          crossAxisSpacing: crossAxisSpacing ?? 0.0,
          childAspectRatio: childAspectRatio ?? 1.0,
          shrinkWrap: shrinkWrap,
          physics: physics,
          padding: padding,
          controller: scrollController,
          keyboardDismissBehavior: keyboardDismissBehavior ??
              ScrollViewKeyboardDismissBehavior.onDrag,
          scrollDirection: scrollDirection ?? Axis.vertical,
          children: children,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingSelf ?? EdgeInsets.zero,
      child: Container(
        height: height,
        width: width,
        alignment: alignSelf,
        constraints: constraints,
        decoration: decoration,
        child: GridView(
          shrinkWrap: shrinkWrap,
          physics: physics,
          padding: padding,
          controller: scrollController,
          keyboardDismissBehavior: keyboardDismissBehavior ??
              ScrollViewKeyboardDismissBehavior.onDrag,
          scrollDirection: scrollDirection ?? Axis.vertical,
          gridDelegate: gridDelegate,
          children: children,
        ),
      ),
    );
  }
}
