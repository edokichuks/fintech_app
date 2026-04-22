// Flutter imports:
import 'package:flutter/material.dart';

class AppTimer extends StatefulWidget {
  final AnimationController animationController;
  final Widget Function(String) builder;
  final Widget Function(String) completedBuilder;

  const AppTimer({
    super.key,
    required this.animationController,
    required this.builder,
    required this.completedBuilder,
  });

  @override
  State<AppTimer> createState() => _AppTimerState();
}

class _AppTimerState extends State<AppTimer> {
  late final Animation<int> _animation;

  @override
  void initState() {
    super.initState();

    _animation = StepTween(
      begin: 120,
      end: 0,
    ).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, child) {
        Duration clockTimer = Duration(seconds: _animation.value);
        String timerText = '${clockTimer.inMinutes.remainder(60).toString()}'
            ':${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}s';
        return !widget.animationController.isCompleted
            ? widget.builder(timerText)
            : widget.completedBuilder(timerText);
      },
    );
  }
}
