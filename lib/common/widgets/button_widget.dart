import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final bool isEnable;
  final EdgeInsets margin;
  final Function onTap;
  final double height;

  ButtonWidget({
    Key key,
    @required this.label,
    this.isEnable = true,
    this.margin = EdgeInsets.zero,
    @required this.onTap,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: (height ?? 42).w,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.w / 2),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isEnable
              ? AppColors.gradientButton
              : [
                  AppColors.buttonDisable,
                  AppColors.buttonDisable,
                ],
        ),
      ),
      child: InkWell(
        onTap: isEnable ? onTap : null,
        child: Center(
          child: Text(
            label,
            style: textStyleButton.copyWith(color: isEnable ? Colors.white : Colors.grey[600]),
          ),
        ),
      ),
    );
  }
}
