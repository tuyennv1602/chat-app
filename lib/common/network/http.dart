import 'package:chat_app/common/network/configs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

Dio dio = Dio(
  BaseOptions(
    connectTimeout: Configurations.connectTimeout,
    receiveTimeout: Configurations.responseTimeout,
    contentType: 'application/json; charset=utf-8',
    baseUrl: Configurations.host,
  ),
);

LogInterceptor logInterceptor = LogInterceptor(
  requestHeader: kDebugMode,
  requestBody: kDebugMode,
  responseBody: kDebugMode,
  responseHeader: false,
);
