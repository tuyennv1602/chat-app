import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemStatusWidget extends StatelessWidget {
  final TaskStatus status;
  const ItemStatusWidget({
    Key key,
    this.size = 20,
    this.status,
  }) : super(key: key);

  final int size;

  @override
  Widget build(BuildContext context) {
    debugPrint('$status');
    if (status == TaskStatus.none) {
      return Container(
        width: size.w,
        height: size.w,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.line, width: 1),
        ),
      );
    } else if (status == TaskStatus.done) {
      return SvgPicture.asset(
        IconConst.done,
        width: size.w,
        height: size.w,
        color: AppColors.primaryColor,
      );
    }
    return SvgPicture.asset(
      IconConst.cancel,
      width: size.w,
      height: size.w,
      color: AppColors.red,
    );
  }
}
