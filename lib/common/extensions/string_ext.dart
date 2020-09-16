import 'package:chat_app/common/constants/regex.dart';

extension StringExt on String {
  bool get isEmptyOrNull {
    if (this == null) {
      return true;
    }
    return isEmpty;
  }

  bool get isNotEmptyAndNull => this != null && isNotEmpty;

  bool get isValidEmailString =>
      this != null && RegExp(RegexConst.validEmailRegex).hasMatch(trim());

  bool get isValidPhoneString =>
      this != null && RegExp(RegexConst.validPhoneRegex).hasMatch(trim());

  bool get isValidPassword => isEmptyOrNull && length > 6;

<<<<<<< HEAD
  // ignore: lines_longer_than_80_chars
  double toPrice() =>
      double.parse(replaceAll(RegExp(RegexConst.notDigitRegex), ''));
=======
  double toPrice() => double.parse(replaceAll(
        RegExp(RegexConst.notDigitRegex),
        '',
      ));
>>>>>>> 6d93a869b741fb6f5f86ca47084f28db17db2fd7
}
