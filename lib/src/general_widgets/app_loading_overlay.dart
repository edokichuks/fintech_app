// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';

class AppLoadingOverlay extends StatefulWidget {
  const AppLoadingOverlay({super.key});

  @override
  State<AppLoadingOverlay> createState() => _AppLoadingOverlayState();
}

class _AppLoadingOverlayState extends State<AppLoadingOverlay> {
  late final OverlayPortalController _overlayController;
  @override
  void initState() {
    super.initState();
    _overlayController = OverlayPortalController()..show();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _overlayController,
      overlayChildBuilder: (context) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black.withValues(alpha: .7),
          // child: AppImageView(
          //   lottiePath: AppImages.loadingAnimation,
          child: const AppCircularProgressIndicator(),
        );
      },
    );
  }
}
