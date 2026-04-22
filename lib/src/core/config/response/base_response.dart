// Package imports:
import 'package:clean_flutter/src/core/utils/strings/strings.dart';
import 'package:json_annotation/json_annotation.dart';


part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class BaseResponse<T> {
  final T? data;
  @JsonKey(name: 'status_code')
  final int statusCode;
  // final bool status;
  final String? message;

  const BaseResponse({
    this.data,
    required this.statusCode,
    this.message,
  }) : super();

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return _$BaseResponseFromJson(json, fromJsonT);
  }

  factory BaseResponse.fromMap(Map<String, dynamic> json) {
    return BaseResponse(
      data: json["data"] as T?,
      statusCode: json['status_code'] ?? false,
      message: json['message'] is List
          ? List.from(json['message']).join(',')
          : json['message'] ?? Strings.genericErrorMessage,
    );
  }
}
