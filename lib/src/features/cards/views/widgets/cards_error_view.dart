// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

class CardsErrorView extends StatelessWidget {
  const CardsErrorView({
    required this.message,
    required this.onRetry,
    super.key,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return FintechErrorView(
      message: message,
      onRetry: onRetry,
    );
  }
}
