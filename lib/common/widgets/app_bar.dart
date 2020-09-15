import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_svg/svg.dart';

class AppBarWidget extends StatelessWidget {
  final Widget leading;
  final Widget trailing;
  final Widget center;
  final Function onTapLeading;
  final Function onTapTrailing;
  final EdgeInsets leadingPadding;
  final EdgeInsets trailingPadding;

  const AppBarWidget({
    Key key,
    this.leading,
    this.trailing,
    this.onTapLeading,
    this.onTapTrailing,
    this.leadingPadding,
    this.trailingPadding,
    @required this.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.statusBarHeight + 70.w,
      padding: EdgeInsets.only(top: ScreenUtil.statusBarHeight),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFD1D1D1),
            blurRadius: 15,
            offset: Offset(0, 2),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.w),
          bottomRight: Radius.circular(20.w),
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: onTapLeading,
            child: Container(
              width: 60.w,
              height: 60.w,
              padding: leadingPadding ?? EdgeInsets.all(20.w),
              child: leading ?? SvgPicture.asset(IconConst.back),
            ),
          ),
          Expanded(child: center),
          if (trailing != null)
            InkWell(
              onTap: onTapTrailing,
              child: Container(
                width: 60.w,
                height: 60.w,
                padding: trailingPadding ?? EdgeInsets.all(20.w),
                child: trailing,
              ),
            ),
        ],
      ),
    );
  }
}
