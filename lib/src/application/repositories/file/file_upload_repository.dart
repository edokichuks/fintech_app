import 'dart:io';
import 'package:fintech_app/src/application/model/file_upload_response.dart';
import 'package:fintech_app/src/core/config/exceptions/app_exceptions.dart';
import 'package:fintech_app/src/core/config/response/base_response.dart';
import 'package:fintech_app/src/core/services/client/rest_client.dart';
import 'package:fintech_app/src/core/services/file_upload_service.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FileUploadRepository {
  FileUploadRepository(this._restClient);

  final RestClient _restClient;
  final _fileUploadService = FileUploadService();

  Future<BaseResponse<FileUploadResponse>> uploadFile({
    required String data,
  }) async {
    final file = File(data);
    final fileName = file.path.split('/').last;
    final multipartFile = await MultipartFile.fromFile(
      data,
      contentType: _fileUploadService.getMediaType(fileName),
    );

    try {
      final r = await _restClient.uploadFile([multipartFile]);
      return r;
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final fileUploadRepositoryProvider = Provider<FileUploadRepository>(
  (ref) => FileUploadRepository(ref.read(restClient)),
);
