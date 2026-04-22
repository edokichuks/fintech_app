// Package imports:
import 'package:url_launcher/url_launcher.dart';

class DeviceUrlLauncher {
  static openMailApp(
      {required String email, String? body, String? subject}) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: (subject != null && body != null)
          ? _encodeQueryParameters(
              <String, String>{'subject': subject, 'body': body})
          : null,
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }

  static openPhoneApp({required String phoneNumber}) async {
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(phoneLaunchUri)) {
      await launchUrl(phoneLaunchUri);
    }
  }

  static openSMSApp({required String phoneNumber, String? smsBody}) async {
    final Uri smsLaunchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: (smsBody != null)
          ? <String, String>{
              'body': Uri.encodeComponent(smsBody),
            }
          : null,
    );
    if (await canLaunchUrl(smsLaunchUri)) {
      await launchUrl(smsLaunchUri);
    }
  }

  static openDeviceBrowser({required Uri? url}) async {
    if (url != null) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}

String? _encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}
