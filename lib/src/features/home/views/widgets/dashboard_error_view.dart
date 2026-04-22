import 'package:flutter/material.dart';

import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

class DashboardErrorView extends StatelessWidget {
  const DashboardErrorView({
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
