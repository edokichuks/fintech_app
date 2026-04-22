// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/widgets.dart';

class AppErrorLog {
  static void init() {
    FlutterError.onError = (details) {
      log(details.exceptionAsString(), stackTrace: details.stack);
    };
  }
}
