// Flutter imports:
import 'package:fintech_app/src/features/home/views/home_screen.dart';
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:fintech_app/src/features/bottom_nav/presentation/app_bottom_nav_bar.dart';
import 'package:fintech_app/src/features/cards/views/card_transaction_screen.dart';
import 'package:fintech_app/src/features/cards/views/cards_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String bottomNavBar = '/bottomNavBar';
  static const String cardsScreen = '/cardsScreen';
  static const String cardTransactionScreen = '/cardTransactionScreen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _trasnsitionRouter(screenWidget: const HomeScreen());

      //BOTTOM NAV BAR
      case bottomNavBar:
        return _trasnsitionRouter(screenWidget: const AppBottomNavScreen());

      case cardsScreen:
        return _trasnsitionRouter(screenWidget: const CardsScreen());

      case cardTransactionScreen:
        return _trasnsitionRouter(screenWidget: const CardTransactionScreen());

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
