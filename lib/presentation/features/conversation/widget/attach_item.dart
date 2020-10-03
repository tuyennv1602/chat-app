import 'package:chat_app/common/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_svg/svg.dart';

class AttachItem extends StatelessWidget {
  final String icon;
  final String title;
  final Function onTap;

  AttachItem({
    Key key,
    this.icon,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: AppColors.primaryColor,
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                icon,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 3.w),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.greyText,
              ),
            ),
          )
        ],
      ),
    );
  }
}
