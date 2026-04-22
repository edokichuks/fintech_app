import 'package:fintech_app/src/core/utils/app_utils_exports.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';

class DeviceInfoService {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  static Future<Map<String, dynamic>> getDeviceInfo() async {
    try {
      final deviceInfo = await _deviceInfoPlugin.deviceInfo;
      _logAllDeviceInfo(deviceInfo);
      return deviceInfo.data;
    } catch (e) {
      debugLog('Error getting device info: $e');
      return {};
    }
  }

  static void _logAllDeviceInfo(dynamic deviceInfo) {
    if (deviceInfo is AndroidDeviceInfo) {
      _logAndroidInfo(deviceInfo);
    } else if (deviceInfo is IosDeviceInfo) {
      _logIosInfo(deviceInfo);
    } else {
      debugLog('Unknown device type: ${deviceInfo.runtimeType}');
    }
  }

  static void _logAndroidInfo(AndroidDeviceInfo androidInfo) {
    debugLog('=== ANDROID DEVICE INFO ===');
    debugLog('Model: ${androidInfo.model}');
    debugLog('Manufacturer: ${androidInfo.manufacturer}');
    debugLog('Brand: ${androidInfo.brand}');
    debugLog('Device: ${androidInfo.device}');
    debugLog('Product: ${androidInfo.product}');
    debugLog('Hardware: ${androidInfo.hardware}');
    debugLog('ID: ${androidInfo.id}');
    debugLog('Display: ${androidInfo.display}');
    debugLog('Board: ${androidInfo.board}');
    debugLog('Bootloader: ${androidInfo.bootloader}');
    debugLog('Fingerprint: ${androidInfo.fingerprint}');
    debugLog('Host: ${androidInfo.host}');
    debugLog('Tags: ${androidInfo.tags}');
    debugLog('Type: ${androidInfo.type}');
    debugLog('Is Physical Device: ${androidInfo.isPhysicalDevice}');

    // Version info
    debugLog('--- VERSION INFO ---');
    debugLog('SDK Int: ${androidInfo.version.sdkInt}');
    debugLog('Release: ${androidInfo.version.release}');
    debugLog('Preview SDK Int: ${androidInfo.version.previewSdkInt}');
    debugLog('Incremental: ${androidInfo.version.incremental}');
    debugLog('Codename: ${androidInfo.version.codename}');
    debugLog('Base OS: ${androidInfo.version.baseOS}');
    debugLog('Security Patch: ${androidInfo.version.securityPatch}');

    // System features
    debugLog('--- SYSTEM FEATURES ---');
    debugLog('System Features: ${androidInfo.systemFeatures}');
    debugLog('================================');
  }

  static void _logIosInfo(IosDeviceInfo iosInfo) {
    debugLog('=== iOS DEVICE INFO ===');
    debugLog('Name: ${iosInfo.name}');
    debugLog('System Name: ${iosInfo.systemName}');
    debugLog('System Version: ${iosInfo.systemVersion}');
    debugLog('Model: ${iosInfo.model}');
    debugLog('Localized Model: ${iosInfo.localizedModel}');
    debugLog('Identifier For Vendor: ${iosInfo.identifierForVendor}');
    debugLog('Is Physical Device: ${iosInfo.isPhysicalDevice}');

    // UTSName info
    debugLog('--- UTSNAME INFO ---');
    debugLog('Machine: ${iosInfo.utsname.machine}');
    debugLog('Nodename: ${iosInfo.utsname.nodename}');
    debugLog('Release: ${iosInfo.utsname.release}');
    debugLog('Sysname: ${iosInfo.utsname.sysname}');
    debugLog('Version: ${iosInfo.utsname.version}');

    debugLog('================================');
  }

  static Future<String> getDeviceModel() async {
    try {
      final deviceInfo = await _deviceInfoPlugin.deviceInfo;

      if (deviceInfo is AndroidDeviceInfo) {
        return '${deviceInfo.manufacturer} ${deviceInfo.model}';
      } else if (deviceInfo is IosDeviceInfo) {
        return deviceInfo.utsname.machine;
      }

      return 'Unknown Device';
    } catch (e) {
      debugLog('Error getting device model: $e');
      return 'Unknown Device';
    }
  }

  static Future<String> getDeviceIdentifier() async {
    try {
      final deviceInfo = await _deviceInfoPlugin.deviceInfo;

      if (deviceInfo is AndroidDeviceInfo) {
        return '${deviceInfo.manufacturer}_${deviceInfo.model}_${deviceInfo.id}';
      } else if (deviceInfo is IosDeviceInfo) {
        return deviceInfo.identifierForVendor ??
            'ios_${deviceInfo.utsname.machine}';
      }

      return 'unknown_device';
    } catch (e) {
      debugLog('Error getting device identifier: $e');
      return 'error_device';
    }
  }

  static Future<Map<String, String>> getFormattedDeviceInfo() async {
    try {
      final deviceInfo = await _deviceInfoPlugin.deviceInfo;

      if (deviceInfo is AndroidDeviceInfo) {
        return {
          "device_id": deviceInfo.id, // Using Android ID as device_id
          "device_type": "android",
          "device_platform": "mobile",
          "device_OS": "Android ${deviceInfo.version.release}",
          "device_model": "${deviceInfo.manufacturer} ${deviceInfo.model}",
        };
      } else if (deviceInfo is IosDeviceInfo) {
        return {
          "device_id": deviceInfo.identifierForVendor ?? 'ios_unknown',
          "device_type": "ios",
          "device_platform": "mobile",
          "device_OS": "${deviceInfo.systemName} ${deviceInfo.systemVersion}",
          "device_model": deviceInfo.utsname.machine,
        };
      }

      return {
        "device_id": "unknown",
        "device_type": "unknown",
        "device_platform": "unknown",
        "device_OS": "unknown",
        "device_model": "unknown",
      };
    } catch (e) {
      debugLog('Error getting formatted device info: $e');
      return {
        "device_id": "error",
        "device_type": "error",
        "device_platform": "error",
        "device_OS": "error",
        "device_model": "error",
      };
    }
  }

  static Future<DeviceAuthModel> getDeviceAuthModel() async {
    try {
      final formattedInfo = await getFormattedDeviceInfo();

      return DeviceAuthModel(
        deviceId: formattedInfo['device_id'],
        deviceType: formattedInfo['device_type'],
        devicePlatform: formattedInfo['device_platform'],
        deviceOs: formattedInfo['device_OS'],
        deviceModel: formattedInfo['device_model'],
      );
    } catch (e) {
      debugLog('Error getting device auth model: $e');
      return const DeviceAuthModel();
    }
  }
}

class DeviceAuthModel extends Equatable {
  final String? deviceId;
  final String? deviceType;
  final String? devicePlatform;
  final String? deviceOs;
  final String? deviceModel;

  const DeviceAuthModel({
    this.deviceId,
    this.deviceType,
    this.devicePlatform,
    this.deviceOs,
    this.deviceModel,
  });

  factory DeviceAuthModel.fromJson(Map<String, dynamic> json) {
    return DeviceAuthModel(
      deviceId: json['device_id'] as String?,
      deviceType: json['device_type'] as String?,
      devicePlatform: json['device_platform'] as String?,
      deviceOs: json['device_OS'] as String?,
      deviceModel: json['device_model'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'device_id': deviceId,
    'device_type': deviceType,
    'device_platform': devicePlatform,
    'device_OS': deviceOs,
    'device_model': deviceModel,
  };

  @override
  List<Object?> get props {
    return [deviceId, deviceType, devicePlatform, deviceOs, deviceModel];
  }
}
