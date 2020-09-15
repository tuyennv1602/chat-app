import 'package:chat_app/common/constants/strings.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:chat_app/common/extensions/string_ext.dart';

class Validator {
  static String validEmail(String email) {
    if (email.isEmptyOrNull) {
      // return translate(StringConst.enterEmail);
    }
    if (!email.isValidEmailString) {
      // return translate(StringConst.emailInvalid);
    }
    return null;
  }

  static String validPrice(String name) {
    if (name.isEmptyOrNull) {
      // return translate(StringConst.enterPrice);
    }
    return null;
  }
}
