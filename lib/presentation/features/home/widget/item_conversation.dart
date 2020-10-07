import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/widgets/circle_avatar.dart';
import 'package:chat_app/common/widgets/group_avatar.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:chat_app/common/extensions/date_time_ext.dart';

class ItemConversationWidget extends StatelessWidget {
  final int conversationId;
  final String conversationName;
  final String lastMessage;
  final Function(int conversationId) onTap;

  const ItemConversationWidget({
    Key key,
    this.conversationId,
    this.conversationName,
    this.lastMessage,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(conversationId),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: conversationId % 2 == 0
                ? const GroupAvatartWidget()
                : CircleAvatarWidget(
                    source: null,
                    isActive: true,
                  ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.line, width: 0.5),
                ),
              ),
              padding: EdgeInsets.only(bottom: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            conversationName,
                            style: textStyleLabel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          DateTime.now()
                              .add(
                                const Duration(minutes: 1),
                              )
                              .timeAgo(),
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 12.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    lastMessage,
                    style: textStyleRegular.copyWith(
                      fontSize: 13.sp,
                      color: AppColors.greyText,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
