import 'package:ecohero/core/core.dart';

class ResponseModel<T> {
  final String? status;
  final T? data;
  final ErrorModel? error;

  ResponseModel({
    this.status,
    this.data,
    this.error,
  });

  factory ResponseModel.fromJson(
    Map<String, dynamic> json, {
    T? Function(Object? response)? generatedData,
    String? keyData,
  }) =>
      ResponseModel(
        status: json['status'] as String?,
        data: generatedData?.call(json[keyData ?? 'data']),
        error: json['error'] == null
            ? null
            : ErrorModel.fromJson(json['error'] as Map<String, dynamic>),
      );

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'object': object,
  //       'created': created,
  //       'model': model,
  //       'usage': usage?.toJson(),
  //       'choices': choices?.map((Choice e) => e.toJson()).toList(),
  //       'error': error?.toJson(),
  //     };
}

class ErrorModel {
  String? message;
  String? type;

  ErrorModel({this.message, this.type});

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        message: json['message'] as String?,
        type: json['type'] as String?,
      );

  ErrorEntity toErrorEntity() => ErrorEntity(message: message, type: type);

  // Map<String, dynamic> toJson() => {
  //       'message': message,
  //       'type': type,
  //     };
}
