// Flutter imports:
import 'package:fintech_app/src/application/repositories/user/user_repository_impl.dart';
import 'package:fintech_app/src/core/device_features/device_feature_exports.dart';
import 'package:fintech_app/src/core/services/device_info_service.dart';
import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:fintech_app/src/general_widgets/general_widget_exports.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:fintech_app/src/core/router/router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _init();
    DeviceNotification.instance.firebaseInit();
    DeviceNotification.instance.initForgroundMessage();
  }

  void _init() async {
    _initializeDeviceToken();
    await Future<void>.delayed(const Duration(seconds: 4));
    if (!mounted) {
      return;
    }
    Navigator.pushReplacementNamed(context, AppRouter.homeContainerScreen);
  }

  Future<void> _initializeDeviceToken() async {
    try {
      debugLog('🔍 Checking for existing device token...');

      // Check if device token already exists

      final existingToken = ref.read(userRepositoryProvider).getDeviceToken();

      if (existingToken.isEmpty) {
        debugLog('⚠️ No device token found, fetching from backend...');
        _sendDeviceInfoToBackend();

        return;
      } else {
        debugLog('✅ Device token found: $existingToken');
      }
    } catch (e) {
      debugLog('❌ Error initializing device token: $e');
    }
  }

  Future<void> _sendDeviceInfoToBackend() async {
    try {
      debugLog('🔄 Sending device auth data to backend...');

      final deviceAuthModel = await DeviceInfoService.getDeviceAuthModel();
      final userRepo = ref.read(userRepositoryProvider);

      //! Send device auth data to backend
      final response = await userRepo.sendDevice(deviceAuthModel);

      if (response.data != null) {
        debugPrint('saving the device token');
        ref
            .read(userRepositoryProvider)
            .saveDeviceToken(response.data?.deviceToken ?? '');
        debugLog(
          '✅ Device token saved successfully: ${response.data!.deviceToken}',
        );
      } else {
        debugLog('❌ No device token received from backend');
      }
    } catch (e) {
      debugLog('❌ Error sending device auth data: $e');
    }
  }

  String? datePicked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('PROD Template'),
            AppTextField(
              label: 'Sample Input',
              textInputAction: TextInputAction.done,
            ),
            GestureDetector(
              onTap: () async {
                final result = await showAppDatePicker(context: context);
                // final result = await showAppTimePicker(context: context);
                setState(() {
                  datePicked = result;
                });
              },
              child: AppText(
                text: 'Date Selection Example:\n ${datePicked ?? ''}',
              ),
            ),
            Center(child: FlutterLogo(size: 100.r)),
          ],
        ),
      ),
    );
  }
}
