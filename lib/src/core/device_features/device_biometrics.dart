// Flutter imports:
import 'package:flutter/services.dart';

// Package imports:
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';

// Project imports:
import 'package:clean_flutter/src/general_widgets/general_widget_exports.dart';

class DeviceBiometrics {
  static Future<bool> deviceBiometricsAuth(
      {required String localizedReason}) async {
    final LocalAuthentication auth = LocalAuthentication();
    try {
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: localizedReason,
          options: const AuthenticationOptions(
            useErrorDialogs: false,
            stickyAuth: false,
          ),
          authMessages: {});
      return didAuthenticate;
    } on PlatformException catch (e) {
      _biometricsPlatromErrorCases(errorCode: e.code);
      return false;
    } catch (error) {
      showErrorToast(message: 'An error occured biometrics failed');
      return false;
    }
  }
}

_biometricsPlatromErrorCases({String? errorCode}) {
  switch (errorCode) {
    case auth_error.passcodeNotSet:

      /// Indicates that the user has not yet configured a passcode (iOS) or
      /// PIN/pattern/password (Android) on the device.
      showErrorToast(message: 'Passcode has not been set');
      break;
    case auth_error.notEnrolled:

      /// Indicates the user has not enrolled any biometrics on the device.
      showErrorToast(message: 'Biometrics is unavailable/unenrolled');
      break;
    case auth_error.notAvailable:

      /// Indicates the device does not have hardware support for biometrics..
      showErrorToast(message: 'Biometrics is unavailable');
      break;
    case auth_error.otherOperatingSystem:

      /// Indicates the device operating system is unsupported.
      showErrorToast(message: 'OS is not supported');
      break;
    case auth_error.lockedOut || auth_error.permanentlyLockedOut:

      /// Indicates the API is temporarily and more persistently than [lockedOut], locked out due to too many attempts.
      showErrorToast(message: 'Too many wrong attempts');
      break;
    default:
      showErrorToast(message: 'An error occured...try again later');
      break;
  }
}
