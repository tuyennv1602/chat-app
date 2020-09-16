import 'package:chat_app/common/constants/strings.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:chat_app/common/extensions/string_ext.dart';

class Validator {
  static String validEmail(String email) {
    if (email.isEmptyOrNull) {
      return translate(StringConst.enterEmail);
    }
    if (!email.isValidEmailString) {
      return translate(StringConst.errorEmail);
    }
    return null;
  }

  static String validPhone(String phone) {
    if (phone.isEmptyOrNull) {
      return translate(StringConst.enterPhone);
    }
    if (phone.length != 10) {
      return translate(StringConst.errorPhone);
    }
    return null;
  }

  static String validFullName(String fullName) {
    if (fullName.isEmptyOrNull) {
      return translate(StringConst.enterFullName);
    }
    return null;
  }

  static String validNickName(String nickName) {
    if (nickName.isEmptyOrNull) {
      return translate(StringConst.enterNickName);
    }
    return null;
  }

  static String validPassword(String password) {
    if (password.isEmptyOrNull) {
      return translate(StringConst.enterPassword);
    }
    if (password.length < 6) {
      return translate(StringConst.errorPassword);
    }
    return null;
  }
}
