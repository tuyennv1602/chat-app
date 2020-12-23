import 'package:chat_app/common/constants/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';

class ItemInfoWidget extends StatelessWidget {
  final String icon;
  final String title;
  final Function onTap;
  final Color textColor;

  ItemInfoWidget({
    Key key,
    this.icon,
    this.title,
    this.onTap,
    this.textColor = AppColors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 45.w,
            width: 50.w,
            child: Center(
              child: SvgPicture.asset(
                icon,
                width: 20.w,
                height: 20.w,
                color: AppColors.warmGrey,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 45.w,
              margin: EdgeInsets.only(right: 15.w),
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: textStyleMedium.copyWith(color: textColor, fontSize: 14.sp),
              ),
            ),
          ),
          if (onTap != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: SvgPicture.asset(
                IconConst.arrowRight,
                width: 12,
                height: 12,
                color: AppColors.warmGrey,
              ),
            )
        ],
      ),
    );
  }
}
