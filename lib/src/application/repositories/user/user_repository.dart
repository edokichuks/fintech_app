// Project imports:
import 'package:clean_flutter/src/application/model/device_auth_response.dart';
import 'package:clean_flutter/src/core/config/response/base_response.dart';
import 'package:clean_flutter/src/core/services/device_info_service.dart';
import 'package:clean_flutter/src/core/utils/app_enums.dart';

abstract interface class UserRepository {
  // User getUser();
  // Future<void> updateUser(User user);
  String getToken();
  String getRefreshToken();
  void saveToken(String token);
  void saveRefreshToken(String token);
  void saveCurrentState(CurrentState val);
  CurrentState getCurrentState();
  bool? getRememberMe();
  void saveRememberMe(bool val);

  // Future<BaseResponse<User>> getUserProfile();

  // Future<BaseResponse<User>> updateUserProfile(
  //     {required UpdateUserModel data, required String userId});

  String getFCMToken();
  void saveFCMTokenLocally(String val);
  bool getBalanceVisibility();
  void setBalanceVisibility();

//! New Implimentation Methods
  bool getHasRatedApp();
  Future<void> setHasRatedApp(bool value);
  DateTime? getLastRatedDate();
  Future<void> setLastRatedDate(DateTime date);
  int getTransactionCountSinceRating();
  Future<void> setTransactionCountSinceRating(int count);
  Future<void> incrementTransactionCount();
  Future<void> resetTransactionCount();
  void saveDeviceToken(String deviceToken);
  String getDeviceToken();
  void clearDeviceToken();
  Future<BaseResponse<DeviceAuthResponse>> sendDevice(DeviceAuthModel data);
}
