import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/widgets/app_bar.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/item_member.dart';
import 'package:chat_app/domain/entities/member_entity.dart';
import 'package:chat_app/presentation/features/task/widgets/count_down_widget.dart';
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
                          fullname: 'Lê Văn Luyện',
                          nickname: 'luyen_nguyen',
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
