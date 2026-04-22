// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:fintech_app/src/core/utils/fintech_tokens.dart';

class PressableScale extends StatefulWidget {
  const PressableScale({
    required this.child,
    super.key,
    this.onTap,
    this.onLongPress,
    this.scale = 0.97,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double scale;

  @override
  State<PressableScale> createState() => _PressableScaleState();
}

class _PressableScaleState extends State<PressableScale> {
  bool _isPressed = false;

  void _setPressed(bool value) {
    if (_isPressed == value) {
      return;
    }
    setState(() {
      _isPressed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      child: AnimatedScale(
        duration: FintechDurations.press,
        curve: Curves.easeOutCubic,
        scale: _isPressed ? widget.scale : 1,
        child: widget.child,
      ),
    );
  }
}
