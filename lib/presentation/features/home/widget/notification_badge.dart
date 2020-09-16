import 'package:chat_app/common/constants/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class NotificationBadgeWidget extends StatelessWidget {
  final int badge;
  final Function onTap;

  NotificationBadgeWidget({
    Key key,
    this.badge = 0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              IconConst.bell,
              width: 22.w,
              height: 22.w,
            ),
          ),
          if (badge > 0)
            Positioned(
              right: 2,
              top: 2,
              child: Container(
                height: 15.h,
                constraints: BoxConstraints(minWidth: 15.h),
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(15.h / 2),
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: Center(
                  child: Text(
                    badge > 99 ? '+99' : badge.toString(),
                    style: TextStyle(fontSize: 8.sp, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
