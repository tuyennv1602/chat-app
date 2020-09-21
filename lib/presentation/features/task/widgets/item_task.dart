import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/widgets/circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class ItemTask extends StatelessWidget {
  final int status;
  int size = 20;
  ItemTask({Key key, this.status = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFD1D1D1),
            blurRadius: 15,
            offset: Offset(0, 2),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.w),
        ),
      ),
      child: Row(
        children: [
          Column(
            children: [
              SvgPicture.asset(
                IconConst.pending,
                width: size.w,
                height: size.w,
                color: AppColors.yellow,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.w),
                width: 1.w,
                height: 28.h,
                color: status == 0
                    ? AppColors.yellow
                    : status == 1 ? AppColors.primaryColor : AppColors.red,
              ),
              status == 0
                  ? Container(
                      width: size.w,
                      height: size.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.line, width: 1),
                      ),
                    )
                  : status == 1
                      ? SvgPicture.asset(
                          IconConst.done,
                          width: size.w,
                          height: size.w,
                          color: AppColors.primaryColor,
                        )
                      : SvgPicture.asset(
                          IconConst.cancel,
                          width: size.w,
                          height: size.w,
                          color: AppColors.red,
                        ),
            ],
          ),
          Container(
            width: 1.w,
            height: 90.w,
            color: AppColors.line,
            margin: EdgeInsets.symmetric(horizontal: 12.w),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Đi tuần vùng biên giới',
                  style: textStyleLabel,
                ),
                SizedBox(height: 5.h),
                Text(
                  'Thời gian: 09:00 10/08 - 13:00 10/08',
                  style: textStyleRegular,
                ),
                Text(
                  'Chỉ huy: Nguyễn Khắc Tư',
                  style: textStyleRegular,
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 26.w,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(width: 5.w),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        child: CircleAvatarWidget(
                          size: index == 0 ? 26.w : 20.w,
                          source: null,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
