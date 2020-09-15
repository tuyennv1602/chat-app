import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_svg/svg.dart';

class CircleButtonWidget extends StatelessWidget {
  final Function onTap;
  final bool isEnable;
  final double size;
  final String urlIcon;
  CircleButtonWidget({
    Key key,
    this.onTap,
    this.isEnable = false,
    this.size = 60,
    this.urlIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(60.w / 2),
      child: Container(
        width: size.w,
        height: size.w,
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isEnable
                ? AppColors.gradientButton
                : [
                    AppColors.grey,
                    AppColors.grey,
                  ],
          ),
        ),
        child: SvgPicture.asset(urlIcon),
      ),
    );
  }
}
