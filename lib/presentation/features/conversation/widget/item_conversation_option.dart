import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_svg/svg.dart';

class ItemConversationOption extends StatelessWidget {
  final String icon;
  final String title;
  final Function onTap;

  const ItemConversationOption({
    Key key,
    this.icon,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50.w,
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
              height: 50.w,
              margin: EdgeInsets.only(right: 15.w),
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.5, color: AppColors.line),
                ),
              ),
              child: Text(
                title,
                style: textStyleRegular,
              ),
            ),
          )
        ],
      ),
    );
  }
}
