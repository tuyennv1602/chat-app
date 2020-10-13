import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:chat_app/common/widgets/circle_avatar.dart';
import 'package:chat_app/domain/entities/member_entity.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class GroupAvatartWidget extends StatelessWidget {
  final List<MemberEntity> members;

  const GroupAvatartWidget({
    Key key,
    this.members,
  }) : super(key: key);

  Widget _renderImage(String source) => SizedBox.expand(
        child: source != null
            ? Image.network(
                source,
                fit: BoxFit.cover,
              )
            : SvgPicture.asset(
                IconConst.user,
              ),
      );

  @override
  Widget build(BuildContext context) {
    final _ownerSize = 26.w;
    final _memberSize = 20.w;
    return members.length == 1
        ? CircleAvatarWidget(
            source: members[0].avatar,
            isActive: members[0].isOnline,
          )
        : Container(
            height: 40.w,
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  Positioned(
                    top: 3.w,
                    child: Container(
                      width: _ownerSize,
                      height: _ownerSize,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(_ownerSize / 2),
                        child: _renderImage(members[0].avatar),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: members.length == 2,
                    child: Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: _ownerSize - 2,
                        height: _ownerSize - 2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1.5, color: Colors.white),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular((_ownerSize - 2) / 2),
                          child: _renderImage(members[1].avatar),
                        ),
                      ),
                    ),
                  ),
                  members.length > 2
                      ? Positioned(
                          right: 0,
                          child: Container(
                            width: _memberSize,
                            height: _memberSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 1.5, color: Colors.white),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(_memberSize / 2),
                              child: _renderImage(members[1].avatar),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  members.length > 2
                      ? Positioned(
                          right: 3.w,
                          bottom: 5.w,
                          child: Container(
                            width: _memberSize,
                            height: _memberSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 1.5, color: Colors.white),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(_memberSize / 2),
                              child: _renderImage(members[2].avatar),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Visibility(
                    visible: members.length > 3,
                    child: Positioned(
                      bottom: 0,
                      child: Text(
                        '+${members.length - 3}',
                        style: TextStyle(
                          fontSize: 9.sp,
                          color: AppColors.greyText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
