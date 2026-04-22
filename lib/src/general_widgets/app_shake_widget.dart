// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

class AppShakeWidget extends StatefulWidget {
  const AppShakeWidget({
    super.key,
    required this.child,
    this.shakeOffset = 10,
    this.shakeCount = 3,
    this.shakeDuration = const Duration(milliseconds: 400),
  });
  final Widget child;
  final double shakeOffset;
  final int shakeCount;
  final Duration shakeDuration;

  @override
  AppShakeWidgetState createState() => AppShakeWidgetState();
}

class AppShakeWidgetState extends State<AppShakeWidget>
    with SingleTickerProviderStateMixin {
  // AppShakeWidgetState(Duration duration) : super(duration);

  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
    animationController.addStatusListener(_updateAnimationStatus);
  }

  @override
  void dispose() {
    animationController.removeStatusListener(_updateAnimationStatus);
    super.dispose();
  }

  void _updateAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reset();
    }
  }

  void shakeWidget() {
    animationController
      ..duration = widget.shakeDuration
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      child: widget.child,
      builder: (context, child) {
        final sineValue =
            sin(widget.shakeCount * 2 * pi * animationController.value);
        return Transform.translate(
          offset: Offset(sineValue * widget.shakeOffset, 0),
          child: child,
        );
      },
    );
  }
}
