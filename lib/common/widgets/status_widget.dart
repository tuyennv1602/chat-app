import 'package:chat_app/common/constants/icons.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class StatusWidget extends StatelessWidget {
  int status;
  final String message;

  StatusWidget.empty({this.message}) {
    status = 0;
  }

  StatusWidget.error({this.message}) {
    status = 1;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            status == 0 ? IconConst.empty : IconConst.error2,
            width: 80,
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              message,
              style: textStyleMessage.copyWith(color: AppColors.greyText),
            ),
          )
        ],
      ),
    );
  }
}
