// Flutter imports:
import 'package:flutter/material.dart';

class AppCrossfade extends StatefulWidget {
  const AppCrossfade({
    required GlobalKey<AppCrossfadeState> key,
    required this.children,
    this.currentWidgetIndex,
    this.onFadeItems,
  }) : super(key: key);

  final int? currentWidgetIndex;
  final List<Widget> children;
  final Function(int index)? onFadeItems;
  @override
  State createState() => AppCrossfadeState();
}

class AppCrossfadeState extends State<AppCrossfade>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentIndex = 0;

  //CONNTROL FLOW FOR THE [_animation] Object
  bool isFirstTime = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1, end: 1.0).animate(_controller);

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (widget.currentWidgetIndex != null) {
          //IF THE DEVELOPER WANTS TO SET THE INDEX FROM OUTISIDE HERE
          setState(() {
            _currentIndex = widget.currentWidgetIndex!;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AppCrossfade oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentWidgetIndex != null &&
        widget.currentWidgetIndex != null &&
        oldWidget.currentWidgetIndex != widget.currentWidgetIndex) {
      //IF THE DEVELOPER WANTS TO SET THE INDEX FROM OUTISIDE HERE
      setState(() {
        _currentIndex = widget.currentWidgetIndex!;
      });
      _controller.reset();
      _controller.forward();
      //ENSURES THE ANIMATION IS REASSIGNED ONCE
      if (isFirstTime) {
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
        isFirstTime = false;
      }
    }
  }

  void fadeItems() {
    if (_currentIndex != (widget.children.length - 1)) {
      _currentIndex = (_currentIndex + 1);

      if (widget.onFadeItems != null) {
        widget.onFadeItems!(_currentIndex);
      }
      //ENSURES THE ANIMATION IS REASSIGNED ONCE
      if (isFirstTime) {
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
        isFirstTime = false;
      }
      _controller.reset();
      _controller.forward();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.children[_currentIndex],
    );
  }
}
