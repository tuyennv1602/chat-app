import 'package:chat_app/common/utils/error_utils.dart';
import 'package:dio/dio.dart';

extension DioExt on DioError {
  String get errorMessage {
    if (type == DioErrorType.RESPONSE) {
      return ErrorUtils.getErrorMessage(
        response.data['code'],
        response.data['message'],
      );
    }
    return message;
  }
}
