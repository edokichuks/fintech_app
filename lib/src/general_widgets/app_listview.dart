// Flutter imports:
import 'package:flutter/material.dart';

class AppListView extends StatelessWidget {
  const AppListView({
    super.key,
    required this.children,
    this.shrinkWrap = false,
    this.padding,
    this.scrollDirection,
    this.scrollController,
    this.height,
    this.width,
    this.physics,
    this.decoration,
    this.keyboardDismissBehavior,
  });
  final List<Widget> children;
  final bool shrinkWrap;
  final EdgeInsets? padding;
  final Axis? scrollDirection;
  final ScrollController? scrollController;
  final ScrollPhysics? physics;
  final double? height, width;
  final BoxDecoration? decoration;
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;

  static builder({
    required Widget? Function(BuildContext context, int index) itemBuilder,
    required int? itemCount,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    ScrollPhysics? physics,
    Axis? scrollDirection,
    ScrollController? scrollController,
    double? height,
    width,
    BoxDecoration? decoration,
    AlignmentGeometry? alignSelf,
    alignContent,
    ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior,
  }) {
    return Align(
      alignment: alignSelf ?? Alignment.topLeft,
      child: Container(
        alignment: alignContent,
        height: height,
        width: width,
        decoration: decoration,
        child: ListView.builder(
          itemBuilder: itemBuilder,
          itemCount: itemCount ?? 0,
          padding: padding,
          scrollDirection: scrollDirection ?? Axis.vertical,
          keyboardDismissBehavior: keyboardDismissBehavior ??
              ScrollViewKeyboardDismissBehavior.manual,
          controller: scrollController,
          shrinkWrap: shrinkWrap,
          physics: physics,
        ),
      ),
    );
  }

  static separated({
    required Widget? Function(BuildContext context, int index) itemBuilder,
    required int? itemCount,
    bool shrinkWrap = false,
    required Widget Function(BuildContext context, int index) separatorBuilder,
    EdgeInsetsGeometry? padding,
    ScrollPhysics? physics,
    Axis? scrollDirection,
    ScrollController? scrollController,
    double? height,
    width,
    BoxDecoration? decoration,
    AlignmentGeometry? alignSelf,
    alignContent,
    ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior,
  }) {
    return Align(
      alignment: alignSelf ?? Alignment.topLeft,
      child: Container(
        height: height,
        width: width,
        alignment: alignContent,
        decoration: decoration,
        child: ListView.separated(
          itemBuilder: itemBuilder,
          padding: padding,
          itemCount: itemCount ?? 0,
          shrinkWrap: shrinkWrap,
          controller: scrollController,
          scrollDirection: scrollDirection ?? Axis.vertical,
          keyboardDismissBehavior: keyboardDismissBehavior ??
              ScrollViewKeyboardDismissBehavior.manual,
          physics: physics,
          separatorBuilder: separatorBuilder,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: decoration,
      child: ListView(
        shrinkWrap: shrinkWrap,
        physics: physics,
        controller: scrollController,
        keyboardDismissBehavior:
            keyboardDismissBehavior ?? ScrollViewKeyboardDismissBehavior.onDrag,
        scrollDirection: scrollDirection ?? Axis.vertical,
        padding: padding,
        children: children,
      ),
    );
  }
}
