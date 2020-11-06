import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/widgets/circle_avatar.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_svg/svg.dart';

class SenderDetailWidget extends StatelessWidget {
  final UserEntity user;
  final Function onClose;

  SenderDetailWidget({
    Key key,
    this.user,
    this.onClose,
  }) : super(key: key);

  Widget _buildActionButton({String icon, Function onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30.w / 2),
      child: Container(
        width: 30.w,
        height: 30.w,
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          icon,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Wrap(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 25.w,
            ),
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatarWidget(
                  source: user.fullAvatar,
                  size: 50,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.w, right: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.fullname,
                          style: textStyleMedium,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 3.w),
                          child: Text(
                            'MQN: ${user.code}',
                            style: textStyleMedium,
                          ),
                        ),
                        SizedBox(height: 10.w),
                        Row(
                          children: [
                            _buildActionButton(icon: IconConst.mail),
                            SizedBox(width: 15.w),
                            _buildActionButton(icon: IconConst.telephone),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      onClose?.call();
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
