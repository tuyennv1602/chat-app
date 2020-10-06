import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/widgets/circle_avatar.dart';
import 'package:chat_app/domain/entities/member_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class MemberInformation extends StatelessWidget {
  final MemberEntity memberEntity;
  final Function onShare;

  const MemberInformation({
    Key key,
    this.memberEntity,
    this.onShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Wrap(
        children: <Widget>[
          Row(
            children: [
              CircleAvatarWidget(source: null),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Text(
                    memberEntity.fullname,
                    style: textStyleMedium,
                  ),
                ),
              ),
              IconButton(
                icon: SvgPicture.asset(IconConst.share, width: 25.w, height: 25.w),
                onPressed: onShare,
              )
            ],
          ),
        ],
      ),
    );
  }
}
