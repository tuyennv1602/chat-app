import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/utils/screen_utils.dart';
import 'package:flutter/material.dart';

class AppTextTheme {
  final TextStyle textStyleAppbar = TextStyle(
    fontSize: ScreenUtil().setSp(22.5),
    color: Colors.white,
    fontWeight: FontWeight.w700,
  );

  final TextStyle textStyleLabel = TextStyle(
    fontSize: ScreenUtil().setSp(17.5),
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );

  final TextStyle textStyleInput = TextStyle(
    fontSize: ScreenUtil().setSp(15),
    color: AppColors.warmGrey,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  final TextStyle textStyleInputError = TextStyle(
    fontSize: ScreenUtil().setSp(14),
    color: AppColors.red,
    height: 0.5,
  );

  final TextStyle textStyleButton = TextStyle(
    fontSize: ScreenUtil().setSp(17.5),
    color: Colors.white,
    fontWeight: FontWeight.w700,
  );

  final TextStyle textStyleCommon1 = TextStyle(
    fontSize: ScreenUtil().setSp(15),
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );

  final TextStyle textStyleCommon2 = TextStyle(
    fontSize: ScreenUtil().setSp(17.5),
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
}
