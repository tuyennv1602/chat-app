import 'dart:io';

import 'package:chat_app/common/constants/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ErrorUtils {
  static const int wrongLoginData = 1000;
  static const int accountInActive = 1003;
  static const int accountExisted = 1001;
  static const int errorVerifyCode = 1004;
  static const int loginFail = 1002;

  static String parseError(Object e) {
    if (e is DioError) {
      if (e.type == DioErrorType.RESPONSE) {
        return ErrorUtils.getErrorMessage(
          e.response.data['code'],
          e.response.data['message'],
        );
      } else if (e.type == DioErrorType.DEFAULT && e.error is SocketException) {
        return translate(StringConst.connectLost);
      } else {
        return e.message;
      }
    }
    return translate(StringConst.unknowError);
  }

  static String getErrorMessage(int code, String message) {
    if (code == accountInActive) {
      return translate(StringConst.accountInActive);
    }
    if (code == accountExisted) {
      return translate(StringConst.accountExisted);
    }
    if (code == errorVerifyCode) {
      return translate(StringConst.errorVerifyCode);
    }
    if (code == loginFail) {
      return translate(StringConst.loginFail);
    }
    return message;
  }
}
