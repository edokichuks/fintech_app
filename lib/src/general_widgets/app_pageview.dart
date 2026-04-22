// Flutter imports:
import 'package:flutter/material.dart';

class AppPageView extends StatelessWidget {
  const AppPageView({
    super.key,
    required this.children,
    this.shrinkWrap = false,
    this.pageController,
    this.pageSnapping = true,
    this.height,
    this.width,
    this.scrollDirection,
  });
  final List<Widget> children;
  final bool shrinkWrap, pageSnapping;
  final PageController? pageController;

  final double? height;
  final double? width;
  final Axis? scrollDirection;

  static builder({
    required Widget? Function(BuildContext context, int index) itemBuilder,
    required int? itemCount,
    bool shrinkWrap = false,
    reverse = false,
    pageSnapping = true,
    double? height,
    double? width,
    ScrollPhysics? physics,
    PageController? controller,
    void Function(int)? onPageChanged,
    ScrollBehavior? scrollBehavior,
    Axis scrollDirection = Axis.horizontal,
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      child: PageView.builder(
        itemBuilder: itemBuilder,
        itemCount: itemCount ?? 0,
        pageSnapping: pageSnapping,
        physics: physics,
        controller: controller,
        onPageChanged: onPageChanged,
        scrollBehavior: scrollBehavior,
        scrollDirection: scrollDirection,
        reverse: reverse,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      pageSnapping: pageSnapping,
      controller: pageController,
      scrollDirection: scrollDirection ?? Axis.horizontal,
      children: children,
    );
  }
}
