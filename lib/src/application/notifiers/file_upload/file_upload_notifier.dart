import 'dart:io';
import 'package:clean_flutter/src/application/model/file_upload_response.dart';
import 'package:clean_flutter/src/application/notifiers/file_upload/file_upload_state.dart';
import 'package:clean_flutter/src/application/repositories/file/file_upload_repository.dart';
import 'package:clean_flutter/src/core/config/exceptions/app_exceptions.dart';
import 'package:clean_flutter/src/core/config/response/base_response.dart';
import 'package:clean_flutter/src/core/services/client/rest_client.dart';
import 'package:clean_flutter/src/core/services/file_upload_service.dart';
import 'package:clean_flutter/src/core/utils/app_utils_exports.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final fileUploadProgressProvider =
    StateProvider<Map<String, double>>((ref) => {});

class FileUploadNotifier extends StateNotifier<FileUploadState> {
  FileUploadNotifier(this._ref, this._repository)
      : super(FileUploadState(uploadedFiles: []));

  final Ref _ref;
  final FileUploadRepository _repository;
  final _fileUploadService = FileUploadService();

  Future<BaseResponse<FileUploadResponse>> uploadFile({
    required String data,
  }) async {
    return await _repository.uploadFile(data: data);
  }

  Future<void> uploadFileWithProgress(File file, String fileKey) async {
    final dioClient = _ref.read(dio);
    dioClient.options.connectTimeout = const Duration(seconds: 45);
    dioClient.options.sendTimeout = const Duration(minutes: 5);
    dioClient.options.receiveTimeout = const Duration(minutes: 3);

    final fileName = file.path.split('/').last;
    final multipartFile = await MultipartFile.fromFile(
      file.path,
      filename: fileName,
      contentType: _fileUploadService.getMediaType(fileName),
    );

    final formData = FormData.fromMap({
      'file': multipartFile,
    });

    try {
      final response = await dioClient.post(
        '/files',
        data: formData,
        onSendProgress: (sent, total) {
          if (total > 0) {
            final progress = (sent / total) * 100;
            debugLog('PROGRESS => $progress');
            _ref.read(fileUploadProgressProvider.notifier).update((state) {
              return {
                ...state,
                fileKey: progress,
              };
            });
          }
        },
      );

      final parsed = BaseResponse<FileUploadResponse>.fromJson(
        response.data!,
        (json) => FileUploadResponse.fromJson(json as Map<String, dynamic>),
      );

      _ref.read(fileUploadProgressProvider.notifier).update((state) {
        final newState = Map.of(state);
        newState.remove(fileKey);
        return newState;
      });

      if (parsed.statusCode == 201 || parsed.statusCode == 200) {
        state = state.copyWith(
            uploadedFiles: [...state.uploadedFiles ?? [], parsed.data??FileUploadResponse()]);
        debugLog(
            'CURRENT LENGTH OF UPLOADED FILES ${(state.uploadedFiles ?? []).length}');
      }
    } on DioException catch (e) {
      debugPrint("Upload failed: ${e.type}");
      debugPrint("Upload failed: ${e.message}");
      final error = AppException.mapException(e.type);
      debugPrint("FORMATED MESSAGE: $error");

      _ref.read(fileUploadProgressProvider.notifier).update((state) {
        final newState = Map.of(state);
        newState.remove(fileKey);
        return newState;
      });
    }
  }
}

final fileUploadNotifierProvider =
    StateNotifierProvider<FileUploadNotifier, FileUploadState>(
  (ref) => FileUploadNotifier(
    ref,
    ref.read(fileUploadRepositoryProvider),
  ),
);
