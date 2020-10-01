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
import 'package:chat_app/domain/entities/member.dart';
import 'package:chat_app/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_translate/flutter_translate.dart';

class CreateTaskScreen extends StatefulWidget {
  static const String router = '/create_task';
  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Column(
        children: [
          AppBarWidget(
            onTapLeading: () => Routes.instance.pop(),
            center: Text(
              'Tạo nhiệm vụ',
              style: textStyleAppbar,
            ),
          ),
          Form(
            child: Padding(
              padding: EdgeInsets.only(top: 15.w, right: 15.w, left: 15.w),
              child: Column(
                children: [
                  InputWidget(
                    placeHolder: 'Nhiệm vụ',
                  ),
                  SizedBox(height: 15.w),
                  InputWidget(
                    placeHolder: 'Nội dung nhiệm vụ',
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
                  'Thời gian',
                  style: textStyleInput.copyWith(
                    color: AppColors.warmGrey,
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 10.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: TimeWidget(time: '09:00 01/08/2020')),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 13.w),
                      child: Text(
                        'đến',
                        style: textStyleInput.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                    Expanded(child: TimeWidget(time: '09:00 01/08/2020')),
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
                member: Member(
                  code: index.toString(),
                  name: 'Lê Văn Luyện',
                  nickName: 'luyen_nguyen',
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
            label: 'Tạo nhiệm vụ',
            margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            onTap: () {},
          )
        ],
      ),
    );
  }
}

class TimeWidget extends StatelessWidget {
  final String time;
  TimeWidget({
    Key key,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.line, width: 1.w),
        borderRadius: BorderRadius.all(Radius.circular(5.w)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.w),
      child: Text(
        time,
        style: textStyleInput.copyWith(
          fontSize: 13.sp,
        ),
      ),
    );
  }
}
