import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final bool isEnable;
  final EdgeInsets margin;
  final Function onTap;

  ButtonWidget({
    Key key,
    @required this.label,
    this.isEnable = true,
    this.margin = EdgeInsets.zero,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 42.w,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45.w / 2),
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
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            label,
            style: textStyleButton,
          ),
        ),
      ),
    );
  }
}
