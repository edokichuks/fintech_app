// Dart imports:
import 'dart:async';
import 'dart:io';

// Package imports:
import 'package:intl/intl.dart';

class HelperFunctions {
  static bool isAndroid() {
    return Platform.isAndroid;
  }

  static bool isIOS() {
    return Platform.isIOS;
  }

  static Timer? _timer;
  static timerFunction(
      {int countdownTimeInSeconds = 60,
      Duration? timerDuration,
      required bool dispose,
      required void Function(int time, bool isActive) onChange}) {
    _timer?.cancel();
    _timer =
        Timer.periodic(timerDuration ?? const Duration(seconds: 1), (timer) {
      if (dispose) {
        timer.cancel();
        return; // Exit early if dispose is true
      }
      if (countdownTimeInSeconds > 0) {
        //ON CHANGE MUST BE CALLED BEFORE SUBTRACTION
        // TO PASS DOWN THE UPDATED VALUE
        onChange(countdownTimeInSeconds, timer.isActive);
        countdownTimeInSeconds -= 1;
      } else {
        timer.cancel();
        onChange(00, timer.isActive);
      }
    });
  }

  activateTimer({required bool dispose}) async {
    // final user = await UserStoreManager.getSavedUser();
    // final authDetails = await UserStoreManager.getSavedAuthDetails();
    // //THE USER MUST BE ONBOARDED AND SIGNED IN BEFORE THE TIMER STARTS COUNTING
    // final hasOnboarded = (user?.hasOnboarded ?? false);
    // final hasSignedIn = (user?.isLoggedIn ?? false);
    // final hasSetPin = (authDetails?.passcode ?? false);
    // int countDownTime = 300;
    // if (countDownTime != 0 && hasOnboarded && hasSignedIn && hasSetPin) {
    //   timerFunction(
    //     countdownTimeInSeconds: countDownTime,
    //     dispose: dispose,
    //     onChange: (time, isActive) async {
    //       // CHECK IF MOUNTED BEFORE UPDATING VALUE
    //       // if (mounted) {
    //       // print('COUNT DOWN TIME  $countDownTime');
    //       countDownTime = time;
    //       //IF PASSWORD SSCREEN IS ALREAY DISPLAYED
    //       //DON'T SHOW IT AGAIN
    //       if (time == 0) {
    //         if (user != null) {
    //           await UserStoreManager.saveUser(
    //               user: user.copyWith(isLoggedIn: false));
    //         }
    //         //   _passwordScreenIsVisible = true;
    //         // Use  instead of context

    //         await .currentState
    //             ?.pushNamed(AppRoutes.welcomeBackScreen);
    //       }
    //     },
    //   );
    // }
  }

  deactivateTimer({required bool dispose}) async {
    //THE USER MUST BE ONBOARDED AND SIGNED IN BEFORE THE TIMER STARTS COUNTING

    int countDownTime = 0;
    // if (countDownTime != 0 && hasOnboarded && hasSignedIn && hasSetPin) {
    timerFunction(
      countdownTimeInSeconds: countDownTime,
      dispose: dispose,
      onChange: (time, isActive) async {
        // CHECK IF MOUNTED BEFORE UPDATING VALUE
        // if (mounted) {
        _timer?.cancel();
        countDownTime = time;
        //IF PASSWORD SSCREEN IS ALREAY DISPLAYED
        //DON'T SHOW IT AGAIN
      },
    );
    // }
  }

  lockUserOut() async {
    //THE USER MUST BE ONBOARDED AND SIGNED IN BEFORE THE TIMER STARTS COUNTING
    // final user = await UserStoreManager.getSavedUser();
    // if (user != null) {
    //   await UserStoreManager.saveUser(user: user.copyWith(isLoggedIn: false));
    // }
    HelperFunctions().deactivateTimer(dispose: true);
  }

  static String formatTimeToDigit({required int time, int digitCount = 2}) {
    return time.toString().padLeft(digitCount, '0');
  }

  static String decodeText({required String text}) {
    return Uri.decodeComponent(text);
  }

  static String formatAmount({required num amount, int decimalPlaces = 2}) {
    if (decimalPlaces == 0) {
      // Create a NumberFormat for formatting numbers with commas
      final formatter = NumberFormat("#,##0");

      // Format the number
      String formattedAmount = formatter.format(amount);

      return formattedAmount;
    }
    // Create a NumberFormat for formatting numbers with commas
    final formatter = NumberFormat("#,##0.${'0' * decimalPlaces}");

    // Format the number
    String formattedAmount = formatter.format(amount);

    return formattedAmount;
  }

  static String? formatDate({required DateTime? dateTime, String? dateFormat}) {
    final format = DateFormat(dateFormat ?? 'dd/MM/yyyy');
    if (dateTime != null) {
      return format.format(dateTime);
    } else {
      return null;
    }
  }
}
