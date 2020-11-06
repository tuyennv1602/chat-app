class RegexConst {
  static const String hasSpaceCharacter = r' ';
  static const String hasOnlyDigitRegex = r'^[0-9]*$';
  static const String hasOnlyAlphabetsRegex = r'^[a-zA-Z]*$';
  static const String notDigitRegex = r'[^0-9]+';
  static const String validEmailRegex =
      r'[a-zA-Z0-9\+\.\_\%\-\+]{1,256}\@[a-zA-Z0-9][a-zA-Z0-9\-]{0,64}(\.[a-zA-Z0-9][a-zA-Z0-9\-]{0,25})+';
  static const String validPhoneRegex =
      r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{3})\s*$';
  static const String validPassword = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,50}$';
}
