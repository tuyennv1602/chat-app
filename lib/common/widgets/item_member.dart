import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/widgets/circle_avatar.dart';
import 'package:chat_app/domain/entities/member_entity.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_svg/svg.dart';

enum MemberAction { delete, select }

class ItemMember extends StatefulWidget {
  final MemberEntity member;
  final MemberAction memberAction;
  final bool isSelected;
  final Function onDelete;
  final Function(MemberEntity member) onTap;

  const ItemMember({
    Key key,
    this.member,
    this.memberAction,
    this.isSelected = false,
    this.onDelete,
    this.onTap,
  }) : super(key: key);

  @override
  _ItemMemberState createState() => _ItemMemberState();
}

class _ItemMemberState extends State<ItemMember> {
  Widget _buildAction() {
    if (widget.memberAction == MemberAction.delete) {
      return InkWell(
        onTap: widget.onDelete,
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: SvgPicture.asset(
            IconConst.close,
            width: 16.w,
            height: 16.w,
          ),
        ),
      );
    }
    return widget.isSelected
        ? Padding(
            padding: EdgeInsets.all(10.w),
            child: SvgPicture.asset(
              IconConst.checked,
              width: 16.w,
              height: 16.w,
            ),
          )
        : const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap?.call(widget.member),
      child: Row(
        children: [
          CircleAvatarWidget(source: null),
          SizedBox(
            width: 15.w,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.line, width: 0.5),
                ),
              ),
              padding: EdgeInsets.only(bottom: 10.h),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: Text(
                            widget.member.fullname,
                            style: textStyleMedium,
                          ),
                        ),
                        Text(
                          // ignore: lines_longer_than_80_chars
                          '${widget.member.nickname} (MQN: ${widget.member.code})',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.greyText,
                          ),
                        )
                      ],
                    ),
                  ),
                  _buildAction()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
