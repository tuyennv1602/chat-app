import 'dart:math';

import 'package:chat_app/common/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:flutter_svg/svg.dart';

class CircleButtonWidget extends StatelessWidget {
  final Function onTap;
  final bool isEnable;
  final double size;
  final String urlIcon;
  final EdgeInsets padding;

  CircleButtonWidget({
    Key key,
    this.onTap,
    this.isEnable = false,
    this.size = 55,
    this.urlIcon,
    this.padding,
  }) : super(key: key);

  double get _iconSize => max(size.w / 3, 12);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnable ? onTap : null,
      borderRadius: BorderRadius.circular(size.w / 2),
      child: Container(
        width: size.w,
        height: size.w,
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
        child: Center(
          child: SvgPicture.asset(
            urlIcon,
            width: _iconSize,
            height: _iconSize,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
