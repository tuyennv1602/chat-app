import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/utils/screen_utils.dart';
import 'package:flutter/material.dart';

final TextStyle textStyleAppbar = TextStyle(
  fontSize: ScreenUtil().setSp(17),
  color: AppColors.black,
  fontWeight: FontWeight.w500,
);

final TextStyle textStyleLabel = TextStyle(
  fontSize: ScreenUtil().setSp(15),
  color: AppColors.black,
  fontWeight: FontWeight.w600,
);

final TextStyle textStyleInput = TextStyle(
  fontSize: ScreenUtil().setSp(15),
  color: AppColors.black,
  fontWeight: FontWeight.w500,
  height: 1.5,
);

final TextStyle textStyleInputError = TextStyle(
  fontSize: ScreenUtil().setSp(10),
  color: AppColors.red,
  height: 0.5,
);

final TextStyle textStyleButton = TextStyle(
  fontSize: ScreenUtil().setSp(16),
  color: Colors.white,
  fontWeight: FontWeight.w500,
);

final TextStyle textStyleRegular = TextStyle(
  fontSize: ScreenUtil().setSp(14),
  color: AppColors.black,
  fontWeight: FontWeight.w400,
);

final TextStyle textStyleMedium = TextStyle(
  fontSize: ScreenUtil().setSp(15),
  color: AppColors.black,
  fontWeight: FontWeight.w500,
);
