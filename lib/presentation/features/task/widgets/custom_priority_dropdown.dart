import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/presentation/features/task/bloc/create_task_bloc/create_task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_translate/flutter_translate.dart';

final _listPriority = <String>['Cao','Trung bình','Thấp'];
class CustomPriorityDropDownList extends StatefulWidget {
  final String priority;
  final CreateTaskBloc createTaskBloc;

  CustomPriorityDropDownList({Key key, this.priority, this.createTaskBloc}) : super(key: key);

  @override
  _CustomPriorityDropDownListState createState() => _CustomPriorityDropDownListState();
}

class _CustomPriorityDropDownListState extends State<CustomPriorityDropDownList> {
  String _priority;

  @override
  void initState() {
    super.initState();
    _priority = widget.priority ?? _listPriority[2];
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(right: 15.w, left: 15.w),
      color: Colors.white,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: translate(StringConst.priority),
          labelStyle: textStyleInput.copyWith(
            color: AppColors.warmGrey,
          ),
          contentPadding: EdgeInsets.only(top: 5.h, bottom: 6.h),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: AppColors.warmGrey,
            ),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: AppColors.red,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: AppColors.primaryColor,
            ),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: AppColors.red,
            ),
          ),
        ),
        dropdownColor: Colors.white,
        value: _priority,
        onChanged: (String value) {
          setState(() {
           _priority = value;
          });
          final index = _listPriority.indexOf(_priority);
          widget.createTaskBloc.add(OnValidateCreateTaskEvent(priorityId: index + 1));
        },
        items: _listPriority.map((String priority) {
          return  DropdownMenuItem<String>(
            value: priority,
            child: Text(
              priority,
              style: const TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
      ),
    );
  }
}
