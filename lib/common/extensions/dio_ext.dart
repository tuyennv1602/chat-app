import 'package:dio/dio.dart';

extension DioExt on DioError {
  String get errorMessage {
    if (type == DioErrorType.RESPONSE) {
      return response.statusMessage;
    }
    return message;
  }
}
