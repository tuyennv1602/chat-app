import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class TimeWidget extends StatelessWidget {
  final Function(DateTime, TimeOfDay) onTap;
  final DateTime time;
  final bool isPassTime;

  TimeWidget({Key key, this.onTap, this.time, this.isPassTime = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final selectedDate = showDatePicker(
          context: context,
          firstDate: DateTime(2020),
          lastDate: DateTime(2070),
          initialDate: DateTime.now(),
          helpText: '',
        );

        await selectedDate.then(
          (date) {
            if (date == null) {
              return;
            }
            showTimePicker(
              initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
              context: context,
              helpText: '',
            ).then(
              (time) {
                onTap(date, time);
              },
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: isPassTime ? AppColors.line : AppColors.red, width: 1.w),
          borderRadius: BorderRadius.all(Radius.circular(5.w)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.w),
        child: Text(
          '${DateFormat('HH:mm dd/MM/yyyy').format(time)}',
          style: textStyleInput.copyWith(
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}
