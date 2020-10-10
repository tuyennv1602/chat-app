import 'package:chat_app/common/constants/strings.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ErrorUtils {
  static const int wrongLoginData = 1000;
  static const int accountInActive = 1003;
  static const int accountExisted = 1001;
  static const int errorVerifyCode = 1004;
  static const int loginFail = 1002;

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
