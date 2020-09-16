import 'package:chat_app/common/constants/strings.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String toFormat(String format) {
    final dateFormat = DateFormat(format);
    return dateFormat.format(this) ?? '';
  }

  String timeAgo() {
    final now = DateTime.now();
    if (difference(now).inDays < 1) {
      if (difference(now).inMinutes <= 1) {
        return translate(StringConst.justNow);
      } else {
        return DateFormat('HH:mm').format(this);
      }
    }
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String fullTimeAgo() {
    final now = DateTime.now();
    final _diffMin = difference(now).inMinutes;
    final _diffHour = difference(now).inHours;
    if (_diffHour <= 12) {
      if (_diffMin <= 1) {
        return translate(StringConst.justNow);
      } else if (_diffMin < 60) {
        return '$_diffMin ${translate(StringConst.minAgo)}';
      } else {
        return '$_diffHour ${translate(StringConst.hourAgo)}';
      }
    }
    return DateFormat('HH:mm dd/MM/yyyy').format(this);
  }
}
