import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/widgets/circle_avatar.dart';
import 'package:chat_app/domain/entities/member_entity.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_svg/svg.dart';

class ItemSelectedMember extends StatelessWidget {
  final MemberEntity member;
  final Function onDelete;

  ItemSelectedMember({
    Key key,
    this.member,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 55.w,
          padding: EdgeInsets.only(top: 5.h),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              CircleAvatarWidget(source: null),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Text(
                  member.getShortName,
                  style: textStyleMedium.copyWith(fontSize: 12.sp),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
        Positioned(
          right: -3,
          child: InkWell(
            onTap: onDelete,
            child: Padding(
              padding: EdgeInsets.all(5.w),
              child: SvgPicture.asset(IconConst.close),
            ),
          ),
        )
      ],
    );
  }
}
