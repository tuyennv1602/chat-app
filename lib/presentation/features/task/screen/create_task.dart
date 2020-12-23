import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/widgets/app_bar.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/button_widget.dart';
import 'package:chat_app/common/widgets/circle_button.dart';
import 'package:chat_app/common/widgets/input_widget.dart';
import 'package:chat_app/common/widgets/item_member.dart';
import 'package:chat_app/domain/entities/member_entity.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';

class CreateTaskScreen extends StatefulWidget {
  static const String router = '/create_task';
  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  DateTime _createDate = DateTime.now();
  DateTime _finishDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Column(
        children: [
          AppBarWidget(
            onTapLeading: () => Routes.instance.pop(),
            center: Text(
              translate(StringConst.createTask),
              style: textStyleAppbar,
            ),
          ),
          Form(
            child: Padding(
              padding: EdgeInsets.only(top: 15.w, right: 15.w, left: 15.w),
              child: Column(
                children: [
                  InputWidget(
                    placeHolder: translate(StringConst.task),
                  ),
                  SizedBox(height: 15.w),
                  InputWidget(
                    placeHolder: translate(StringConst.contentTask),
                    textAlignVertical: TextAlignVertical.top,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translate(StringConst.time),
                  style: textStyleInput.copyWith(
                    color: AppColors.warmGrey,
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 10.w),
                Row(
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
                          }
                        },
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
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              children: [
                Text(
                  translate(StringConst.member),
                  style: textStyleMedium.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                InkWell(
                  onTap: null,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 5.h,
                    ),
                    child: CircleButtonWidget(
                      size: 16.h,
                      isEnable: true,
                      padding: EdgeInsets.all(3.w),
                      urlIcon: IconConst.add,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 5.w),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              itemBuilder: (_, index) => ItemMember(
                member: MemberEntity(
                  code: index.toString(),
                  fullname: 'Lê Văn Luyện',
                  nickname: 'luyen_nguyen',
                ),
                memberAction: MemberAction.delete,
              ),
              separatorBuilder: (_, index) => SizedBox(
                height: 10.h,
              ),
              itemCount: 10,
            ),
          ),
          ButtonWidget(
            label: translate(StringConst.createTask),
            margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            onTap: () {},
          )
        ],
      ),
    );
  }
}

class TimeWidget extends StatelessWidget {
  final Function(DateTime, TimeOfDay) onTap;
  final DateTime time;

  TimeWidget({Key key, this.onTap, this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final selectedDate = showDatePicker(
          context: context,
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
          initialDate: DateTime.now(),
          helpText: '',
        );

        await selectedDate.then(
          (date) {
            if (date == null) {
              return;
            }
            showTimePicker(
              initialTime: TimeOfDay(
                  hour: DateTime.now().hour, minute: DateTime.now().minute),
              context: context,
              helpText: '',
            )..then(
                (time) {
                  onTap(date, time);
                },
              );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.line, width: 1.w),
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
