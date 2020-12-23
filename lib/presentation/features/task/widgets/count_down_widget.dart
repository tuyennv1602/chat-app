import 'dart:async';

import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class CountDownTimer extends StatefulWidget {
  final DateTime finishDate;
  final DateTime createDate;

  CountDownTimer({Key key, this.finishDate, this.createDate}) : super(key: key);
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  int _minutes;
  int _hours;
  int _days;
  Timer _timer;
  DateTime createDate;
  DateTime finishDate;
  DateTime now = DateTime.now();

  void _startTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 60), (timer) {
      setState(() {
        if (now == finishDate || finishDate.isBefore(now)) {
          _timer.cancel();
        }
      });
    });
  }

  String _getTime() {
    final now = DateTime.now();
    if (finishDate.isBefore(now)) {
      return 'Đã kết thúc';
    } else if (createDate.isAfter(now)) {
      return 'Sắp diễn ra';
    }
    _days = finishDate.difference(now).inDays;
    _hours = (finishDate.difference(now).inHours) % 24;
    _minutes = (finishDate.difference(now).inMinutes) % 60;
    if (_days == 0) {
      return '$_hours ${translate(StringConst.hour)} '
          '$_minutes ${translate(StringConst.minute)}';
    } else if (_hours == 0 && _minutes == 0) {
      return '$_days ${translate(StringConst.day)}';
    } else if (_hours == 0 && _days == 0) {
      return '$_minutes ${translate(StringConst.hour)}';
    }
    return '$_days ${translate(StringConst.day)}'
        ' $_hours ${translate(StringConst.hour)} '
        '$_minutes ${translate(StringConst.minute)}';
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    createDate = widget.createDate;
    finishDate = widget.finishDate;
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _getTime(),
      style: textStyleInput.copyWith(
        color: AppColors.primaryColor,
      ),
    );
  }
}
