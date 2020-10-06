import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/widgets/app_bar.dart';
import 'package:chat_app/common/widgets/base_scaffold.dart';
import 'package:chat_app/common/widgets/item_member.dart';
import 'package:chat_app/common/widgets/search_box.dart';
import 'package:chat_app/domain/entities/member_entity.dart';
import 'package:chat_app/presentation/features/select_member/widget/item_selected_member.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class SelectMemberScreen extends StatefulWidget {
  static const String route = '/select-member';

  @override
  _SelectMemberScreenState createState() => _SelectMemberScreenState();
}

class _SelectMemberScreenState extends State<SelectMemberScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarWidget(
              center: Container(
                margin: EdgeInsets.only(right: 10.w),
                child: SearchBoxWidget(
                  hintText: translate(StringConst.inputMemberName),
                  onKeyChanged: (value) {},
                ),
              ),
              onTapLeading: () => Navigator.of(context).pop(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: Text(
                '${translate(StringConst.selected)} 10',
                style: textStyleMedium.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(
              height: 75.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) => ItemSelectedMember(
                  member: MemberEntity(
                    code: index.toString(),
                    fullname: 'Nguyen Khac Tu',
                    nickname: 'nguyen_tu',
                  ),
                ),
                separatorBuilder: (_, index) => SizedBox(width: 5.w),
                itemCount: 10,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.w),
              child: Text(
                translate(StringConst.addMember),
                style: textStyleMedium.copyWith(
                  color: AppColors.greyText,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                itemBuilder: (_, index) => ItemMember(
                  member: MemberEntity(
                    code: index.toString(),
                    fullname: 'Nguyen Khac Tu',
                    nickname: 'nguyen_tu',
                  ),
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
    );
  }
}
