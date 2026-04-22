// Flutter imports:
import 'package:clean_flutter/src/core/config/response/base_response.dart';
import 'package:clean_flutter/src/core/utils/app_utils_exports.dart';

// Package imports:
import 'package:dio/dio.dart';

// Project imports:

class AppException {
  static BaseResponse<T> handleError<T>(
    DioException e, {
    T? data,
  }) {
    final statusCode = e.response?.statusCode ?? 0;
    final responseData = e.response?.data;

    debugLog('APP EXCEPTION ERROR RESPONSE ==> $responseData');

    final String message = _extractBackendMessage(responseData) ??
        _mapStatusCodeToMessage(e.response?.statusCode) ??
        _mapException(e.type);

    return BaseResponse<T>(
      data: data,
      statusCode: statusCode,
      message: message,
    );
  }

  static String? _extractBackendMessage(dynamic data) {
    if (data == null) return null;

    if (data is Map<String, dynamic>) {
      if (data['message'] is String) return data['message'];
    } else if (data is String) {
      return data;
    }
    return null;
  }

  static String? _mapStatusCodeToMessage(int? code) {
    switch (code) {
      case 400:
        return 'Bad Request. Please check your input and try again.';
      case 401:
        return 'Unauthorized. Please log in.';
      case 403:
        return 'Forbidden. You are not allowed to perform this action.';
      case 404:
        return 'Resource not found. Please check the entered information.';
      case 500:
        return 'Internal server error. Please try again later.';
      case 502:
        return 'Bad Gateway. There was a problem with the server.';
      case 503:
        return 'Service unavailable. Please try again later.';
      case 504:
        return 'Gateway timeout. The server took too long to respond.';
      case 440:
        return 'Session expired.';
      case 498:
        return 'Invalid OTP.';
      case 429:
        return 'Too many requests. Please slow down.';
      case 409:
        return 'Conflict. The request could not be completed due to a conflict.';
      default:
        return null;
    }
  }

  static String _mapException(DioExceptionType? error) {
    if (error == DioExceptionType.connectionTimeout ||
        error == DioExceptionType.receiveTimeout ||
        error == DioExceptionType.sendTimeout) {
      return Strings.timeout;
    } else if (error == DioExceptionType.connectionError) {
      return Strings.connectionError;
    }
    return Strings.genericErrorMessage;
  }

  static String mapException(DioExceptionType? error) {
    return _mapException(error);
  }
}
