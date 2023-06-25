import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../core/core.dart';

class DioClient {
  static Dio dioInit() {
    return Dio()
      ..options = BaseOptions(
        headers: {
          'Accept': 'application/json',
        },
        connectTimeout: const Duration(
            milliseconds: DurationConstant.networkConnectTimeout),
        sendTimeout:
            const Duration(milliseconds: DurationConstant.networkSendTimeout),
        receiveTimeout: const Duration(
            milliseconds: DurationConstant.networkReceiveTimeout),
      )
      ..interceptors.addAll([
        /// Show log network request in debug console [only in debug mode]
        if (kDebugMode)
          LogInterceptor(
            requestBody: true,
            responseBody: true,
            logPrint: (Object message) => log(message.toString()),
          ),
      ]);
  }
}
