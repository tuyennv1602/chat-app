import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String toFormat(String format) {
    final DateFormat dateFormat = DateFormat(format);
    return dateFormat.format(this) ?? '';
  }
}
