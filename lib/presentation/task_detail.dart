import 'dart:async';

import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/widgets/app_bar.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/item_member.dart';
import 'package:chat_app/domain/entities/member_entity.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_translate/flutter_translate.dart';

class TaskDetailScreen extends StatefulWidget {
  static const String router = '/task_detail';
  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Column(
        children: [
          AppBarWidget(
            onTapLeading: () => Routes.instance.pop(),
            center: Text(
              'Nội dung nhiệm vụ',
              style: textStyleAppbar,
            ),
            trailing: SvgPicture.asset(
              IconConst.menu,
              width: 20.w,
              height: 20.w,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.w)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFFD1D1D1),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(top: 10.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          translate(StringConst.finishIn),
                          style: textStyleInput.copyWith(
                            color: AppColors.greyText,
                          ),
                        ),
                        CountDownTimer(
                          createDate: DateTime(2020, 10, 6, 12, 00),
                          finishDate: DateTime(2020, 10, 7, 12, 00),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.w),
                    child: Text(
                      // ignore: lines_longer_than_80_chars
                      'Nội dung: Tuần tra, kiểm soát các trường hợp nhập cảnh trái phép',
                      style: textStyleInput,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Thành viên thực hiện',
                      style: textStyleInput.copyWith(
                          color: AppColors.greyText, fontSize: 13.sp),
                    ),
                  ),
                  SizedBox(height: 10.w),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      itemBuilder: (_, index) => ItemMember(
                        member: MemberEntity(
                          code: index.toString(),
                          name: 'Lê Văn Luyện',
                          nickName: 'luyen_nguyen',
                        ),
                        memberAction: MemberAction.completed,
                      ),
                      separatorBuilder: (_, index) => SizedBox(
                        height: 10.h,
                      ),
                      itemCount: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
