// Package imports:
import 'package:json_annotation/json_annotation.dart';

enum LoadState { loading, idle, success, error, loadmore, done }

enum LoginLoadState { loading, idle, success, error, unverified }

enum CurrentState { loggedIn, onboarded, initial }

enum OverLayType { loader, message, none }

enum MessageType { error, success }

// ignore: constant_identifier_names
enum AppLanguages { English, French, Spanish, Yoruba, Igbo, Hausa }

enum PermissionStatus {
  denied,
  deniedForever,
  whileInUse,
  always,
  unableToDetermine,
  initial
}

enum HomeSessionState { logout, initial }

// ignore: constant_identifier_names
enum Currency { NGN, USD }

@JsonEnum()
enum Status {
  pending,
  processing,
  dispatching,
  enroute,
  rejected,
  cancelled,
  unfulfilled,
  delivered,
  completed,
}

extension LoadExtension on LoadState {
  bool get isLoading => this == LoadState.loading;
  bool get isLoaded => this == LoadState.success;
  bool get isError => this == LoadState.error;
  bool get isInitial => this == LoadState.idle;
  bool get isLoadMore => this == LoadState.loadmore;
  bool get isCompleted => this == LoadState.done;
}

enum PaymentOption {
  bank('bank'),
  card('card');

  final String rawValue;
  const PaymentOption(this.rawValue);
  // Factory constructor to create a PaymentOption from a string
  factory PaymentOption.fromString(String str) {
    return PaymentOption.values.firstWhere(
      (paymentOption) =>
          paymentOption.rawValue.toLowerCase() == str.toLowerCase(),
      orElse: () => throw ArgumentError('Invalid PaymentOption: $str'),
    );
  }

  // Helper method to convert enum to JSON
  String toJson() => rawValue;

  // Helper method to create enum from JSON
  static PaymentOption fromJson(String json) => PaymentOption.fromString(json);
}

enum HttpMethod {
  get('GET'),
  post('POST'),
  put('PUT'),
  patch('PATCH'),
  delete('DELETE');

  final String rawValue;
  const HttpMethod(this.rawValue);
}

enum PinType {
  pin('pin'),
  passcode('passcode');

  final String rawValue;
  const PinType(this.rawValue);
  // Factory constructor to create a PinType from a string
  factory PinType.fromString(String str) {
    return PinType.values.firstWhere(
      (pinType) => pinType.rawValue.toLowerCase() == str.toLowerCase(),
      orElse: () => throw ArgumentError('Invalid PinType: $str'),
    );
  }

  // Helper method to convert enum to JSON
  String toJson() => rawValue;

  // Helper method to create enum from JSON
  static PinType fromJson(String json) => PinType.fromString(json);
}
