import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/presentation/features/task/bloc/create_task_bloc/create_task_bloc.dart';
import 'package:chat_app/presentation/features/task/widgets/time_wiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class TaskTimeWidget extends StatefulWidget {
  final DateTime startTime;
  final DateTime finishTime;
  final CreateTaskBloc createTaskBloc;
  TaskTimeWidget({Key key, this.startTime, this.finishTime, this.createTaskBloc}) : super(key: key);

  @override
  _TaskTimeWidgetState createState() => _TaskTimeWidgetState();
}

class _TaskTimeWidgetState extends State<TaskTimeWidget> {
  DateTime _createDate;
  DateTime _finishDate;

  @override
  void initState() {
    _createDate = widget.startTime;
    _finishDate = widget.finishTime;
    super.initState();
  }

  bool _isPassTime() {
    if (_createDate.isBefore(_finishDate)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TimeWidget(
            time: _createDate,
            onTap: (date, time) {
              if (date != null && time != null) {
                setState(() {
                  _createDate = DateTime(
                    date.year,
                    date.month,
                    date.day,
                    time.hour,
                    time.minute,
                  );
                });
                widget.createTaskBloc.add(OnValidateCreateTaskEvent(createDate: _createDate, finishDate: _finishDate));
              }
            },
            isPassTime: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.w),
          child: Text(
            translate(StringConst.to),
            style: textStyleInput.copyWith(
              fontSize: 13.sp,
            ),
          ),
        ),
        Expanded(
          child: TimeWidget(
            time: _finishDate,
            onTap: (date, time) {
              if (date != null && time != null) {
                setState(() {
                  _finishDate = DateTime(
                    date.year,
                    date.month,
                    date.day,
                    time.hour,
                    time.minute,
                  );
                });
                widget.createTaskBloc.add(OnValidateCreateTaskEvent(createDate: _createDate, finishDate: _finishDate));
              }
            },
            isPassTime: _isPassTime(),
          ),
        ),
      ],
    );
  }
}
