import 'package:equatable/equatable.dart';

class DeviceAuthResponse extends Equatable {
  final String deviceToken;

  const DeviceAuthResponse({required this.deviceToken});

  factory DeviceAuthResponse.fromJson(Map<String, dynamic> json) {
    return DeviceAuthResponse(
      deviceToken: json['device_token'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'device_token': deviceToken,
      };

  @override
  List<Object?> get props => [deviceToken];
}
