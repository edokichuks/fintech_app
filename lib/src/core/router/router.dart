// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:fintech_app/src/features/bottom_nav/presentation/app_bottom_nav_bar.dart';
import 'package:fintech_app/src/features/start_up/views/splash_screen.dart';
import 'package:fintech_app/src/features/sample/widget_samples_screen.dart';
import 'package:fintech_app/src/features/sample/file_download_sample_screen.dart';

import 'package:fintech_app/src/features/auth/views/create_account_screen.dart';
import 'package:fintech_app/src/features/cards/views/card_transaction_screen.dart';
import 'package:fintech_app/src/features/cards/views/cards_screen.dart';

class AppRouter {
  static const String login = '/login';
  static const String splashScreen = '/splashScreen';
  static const String createAccountScreen = '/';
  static const String homeContainerScreen = '/homeContainerScreen';

  static const String bottomNavBar = '/bottomNavBar';
  static const String cardsScreen = '/cardsScreen';
  static const String cardTransactionScreen = '/cardTransactionScreen';
  static const String widgetSamples = '/widgetSamples';
  static const String fileDownloadSample = '/fileDownloadSample';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      //SPLASHSCREEN
      case splashScreen:
        return _trasnsitionRouter(screenWidget: const SplashScreen());

      //AUTH
      case createAccountScreen:
        return _trasnsitionRouter(screenWidget: const CreateAccountScreen());


      //BOTTOM NAV BAR
      case bottomNavBar:
        return _trasnsitionRouter(screenWidget: const AppBottomNavScreen());

      case cardsScreen:
        return _trasnsitionRouter(screenWidget: const CardsScreen());

      case cardTransactionScreen:
        return _trasnsitionRouter(
          screenWidget: const CardTransactionScreen(),
        );

      //WIDGET SAMPLES
      case widgetSamples:
        return _trasnsitionRouter(screenWidget: const WidgetSamplesScreen());

      //FILE DOWNLOAD SAMPLE
      case fileDownloadSample:
        return _trasnsitionRouter(
          screenWidget: const FileDownloadSampleScreen(),
        );

      default:
        throw UnimplementedError('Route not found');
    }
  }
}

_trasnsitionRouter({
  required Widget screenWidget,
  bool fullscreenDialog = false,
}) {
  return CupertinoPageRoute(
    fullscreenDialog: fullscreenDialog,
    builder: (context) => screenWidget,
  );
}
