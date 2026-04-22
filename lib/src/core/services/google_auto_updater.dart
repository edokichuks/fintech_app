import 'dart:io';

import 'package:clean_flutter/src/core/utils/app_utils_exports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';

class InAppUpdateAuto {
  static final InAppUpdateAuto _instance = InAppUpdateAuto._internal();
  factory InAppUpdateAuto() => _instance;
  InAppUpdateAuto._internal();

  static bool _isInitialized = false;

  /// check for in-app-update
  static Future<void> checkForUpdate() async {
    debugLog('Checking for update for android');
    // prevent for multiple check
    if (_isInitialized) return;
    _isInitialized = true;

    WidgetsFlutterBinding.ensureInitialized();
    await _instance._checkForUpdate();
  }

  Future<void> _checkForUpdate() async {
    /// in-app-update not support for web platform.
    if (kIsWeb) return;

    if (Platform.isAndroid) {
      await _checkAndroidUpdate();
    } else if (Platform.isIOS) {
      await _checkIOSUpdate();
    }
  }

  Future<void> _checkAndroidUpdate() async {
    try {
      AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();
      debugLog('Update availability: ${updateInfo.updateAvailability}');

      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (updateInfo.immediateUpdateAllowed) {
          debugLog('Starting immediate update');
          await InAppUpdate.performImmediateUpdate();
        } else if (updateInfo.flexibleUpdateAllowed) {
          debugLog('Starting flexible update');
          await InAppUpdate.startFlexibleUpdate();
          _listenForFlexibleUpdateCompletion();
        }
      } else {
        debugLog('No update available');
      }
    } catch (e) {
      debugLog('Android update check failed: $e');
    }
  }

  void _listenForFlexibleUpdateCompletion() {
    InAppUpdate.completeFlexibleUpdate().then((_) {
      debugLog('Flexible update completed and installed');
    }).catchError((error) {
      debugLog('Flexible update completion failed: $error');
    });
  }

  Future<void> _checkIOSUpdate() async {
    debugPrint('iOS update check: Use Upgrader widget in your app');
  }
}
