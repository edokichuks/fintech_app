// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:fintech_app/src/core/helpers/helper_functions.dart';
import 'package:fintech_app/src/general_widgets/app_text.dart';

class AnimatedCurrencyText extends StatefulWidget {
  const AnimatedCurrencyText({
    required this.value,
    required this.style,
    super.key,
    this.prefix = '',
    this.suffix = '',
    this.decimalPlaces = 0,
    this.textAlign,
  });

  final double value;
  final TextStyle style;
  final String prefix;
  final String suffix;
  final int decimalPlaces;
  final TextAlign? textAlign;

  @override
  State<AnimatedCurrencyText> createState() => _AnimatedCurrencyTextState();
}

class _AnimatedCurrencyTextState extends State<AnimatedCurrencyText> {
  late double _previousValue;

  @override
  void initState() {
    super.initState();
    _previousValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant AnimatedCurrencyText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _previousValue = oldWidget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutCubic,
      tween: Tween<double>(begin: _previousValue, end: widget.value),
      builder: (context, value, _) {
        final formattedValue = HelperFunctions.formatAmount(
          amount: value,
          decimalPlaces: widget.decimalPlaces,
        );

        return AppText(
          text: '${widget.prefix}$formattedValue${widget.suffix}',
          style: widget.style,
          textAlign: widget.textAlign,
        );
      },
    );
  }
}
