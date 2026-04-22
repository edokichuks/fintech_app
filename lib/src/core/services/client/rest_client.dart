// Package imports:
import 'package:fintech_app/src/application/model/device_auth_response.dart';
import 'package:fintech_app/src/application/model/file_upload_response.dart';
import 'package:fintech_app/src/core/config/response/base_response.dart';
import 'package:fintech_app/src/core/services/device_info_service.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';

// Project imports:
import 'package:fintech_app/src/application/repositories/user/user_repository_impl.dart';
import 'package:fintech_app/src/core/config/dio_utils/auth_strings.dart';
import 'package:fintech_app/src/core/config/dio_utils/header_interceptors.dart';
import 'package:fintech_app/src/core/services/local_storage.dart/local_storage_repo_impl.dart';
import 'package:fintech_app/src/core/services/local_storage.dart/storage_keys.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  //<====================> device info <====================>

  @POST('/auths/device')
  Future<BaseResponse<DeviceAuthResponse>> authDevice(
    @Body() DeviceAuthModel data,
  );

  @POST('/auths/logout')
  Future<BaseResponse> logOut();

  //<====================> File Upload <====================>
  @POST('/files')
  @MultiPart()
  Future<BaseResponse<FileUploadResponse>> uploadFile(
    @Part(name: "file") List<MultipartFile> file,
  );

  //<====================> Authentication <====================>
  // @POST('/auth/login')
  // Future<BaseResponse<LoginResponse>> login(@Body() LoginRequest data);

  // @GET('/users/me')
  // Future<BaseResponse> getUserProfile();
  // @GET('/users/')
  // Future<BaseResponse<List<User>>> getAllUsers(
  //   @Queries() Map<String, dynamic> queries,
  // );
  // @DELETE('/addresses/{id}')
  // Future<BaseResponse> deleteAddress({@Path() required String id});
  // @PATCH('/addresses/{id}/default')
  // Future<BaseResponse<LocationModel>> makeAddressDefault(
  //     {@Path() required String id});

  //<====================> Carts <====================>
  // @PUT('/carts/add-item')
  // Future<BaseResponse<CartResponse>> addToCart(@Body() CartRequest data);
}

////////////////////////////////////////////////////////////////

final dio = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.baseUrl = AuthStrings.baseUrl;
  dio.options.headers = {
    'Content-Type': 'application/json',
    "accept": 'application/json',
  };
  dio.interceptors.add(
    HeaderInterceptor(
      dio: dio,
      userRepository: UserRepositoryImpl(
        LocalStorageRepoImpl(Hive.box(LocalStoreKeysManger.appBox.rawValue)),
        ref,
        RestClient(dio),
      ),
      ref: ref,
    ),
  );

  return dio;
});

final restClient = Provider<RestClient>((ref) => RestClient(ref.read(dio)));
