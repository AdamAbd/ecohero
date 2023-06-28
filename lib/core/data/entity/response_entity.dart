import 'package:equatable/equatable.dart';

import '../../../core/core.dart';

class ResponseEntity<T> extends Equatable {
  final String? status;
  final T? data;
  final ErrorEntity? error;

  const ResponseEntity({
    this.status,
    this.data,
    this.error,
  });

  factory ResponseEntity.fromResponseModel(
    ResponseModel response, {
    T? data,
  }) =>
      ResponseEntity(
        status: response.status,
        data: data,
        error: response.error?.toErrorEntity(),
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        data,
        error,
      ];

  ResponseEntity<T> copyWith({
    String? status,
    T? data,
    ErrorEntity? error,
  }) {
    return ResponseEntity<T>(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}

class ErrorEntity extends Equatable {
  String? message;
  String? type;

  ErrorEntity({this.message, this.type});

  @override
  List<Object?> get props => <Object?>[message, type];
}
