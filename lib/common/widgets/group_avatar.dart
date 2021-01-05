import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:chat_app/common/widgets/circle_avatar.dart';
import 'package:chat_app/domain/entities/member_entity.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/string_ext.dart';

class GroupAvatartWidget extends StatelessWidget {
  final List<MemberEntity> members;
  final Function onTap;

  const GroupAvatartWidget({
    Key key,
    this.members,
    this.onTap,
  }) : super(key: key);

  Widget _defaultAvatar() => Container(
        color: AppColors.placeHolder,
      );

  Widget _renderImage(String source) => SizedBox.expand(
        child: source.isEmptyOrNull
            ? _defaultAvatar()
            : CachedNetworkImage(
                placeholder: (context, url) => _defaultAvatar(),
                errorWidget: (context, url, error) => _defaultAvatar(),
                imageUrl: source,
                fit: BoxFit.cover,
                fadeInDuration: Duration.zero,
                fadeOutDuration: Duration.zero,
              ),
      );

  @override
  Widget build(BuildContext context) {
    final _ownerSize = 30.w;
    final _memberSize = 22.w;
    return members.length == 1
        ? CircleAvatarWidget(
            source: members[0]?.fullAvatar,
            isActive: members[0].isOnline,
            onTap: onTap,
          )
        : GestureDetector(
            onTap: onTap,
            child: Container(
              height: 45.w,
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
                          child: _renderImage(members[0]?.fullAvatar),
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
                            child: _renderImage(members[1].fullAvatar),
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
                                child: _renderImage(members[1].fullAvatar),
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
                                child: _renderImage(members[2].fullAvatar),
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
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
