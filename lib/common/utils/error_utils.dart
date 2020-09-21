import 'package:chat_app/common/constants/strings.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ErrorUtils {
  static const int wrongLoginData = 1000;
  static const int accountInActive = 1003;
  static const int errorVerifyCode = 1004;

  static String getErrorMessage(int code, String message) {
    if (code == accountInActive) {
      return translate(StringConst.accountInActive);
    }
    if (code == errorVerifyCode) {
      return translate(StringConst.errorVerifyCode);
    }
    return message;
  }
}
