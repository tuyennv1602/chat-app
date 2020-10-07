import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/utils/screen_utils.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';

class TextBox extends StatelessWidget {
  final MessageEntity message;
  final bool isMine;
  final bool isNextBySender;

  TextBox({
    Key key,
    this.message,
    this.isMine,
    this.isNextBySender,
  }) : super(key: key);

  BoxDecoration _getBoxDecoration() {
    if (isMine) {
      return BoxDecoration(
        color: const Color(0xff2E9F60),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(15),
          topRight: const Radius.circular(15),
          bottomLeft: const Radius.circular(15),
          bottomRight: Radius.circular(isNextBySender ? 15 : 6),
        ),
      );
    } else {
      return BoxDecoration(
        color: AppColors.messageBox,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(15),
          topRight: const Radius.circular(15),
          bottomRight: const Radius.circular(15),
          bottomLeft: Radius.circular(isNextBySender ? 15 : 6),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: ScreenUtil.screenWidthDp * 2 / 3),
      padding: EdgeInsets.all(10.w),
      decoration: _getBoxDecoration(),
      child: Text(
        message.content,
        style: textStyleMessage.copyWith(
          color: isMine ? Colors.white : AppColors.black,
        ),
      ),
    );
  }
}
