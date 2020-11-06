import 'package:chat_app/common/constants/strings.dart';
import 'package:chat_app/common/themes/app_colors.dart';
import 'package:chat_app/common/themes/app_text_theme.dart';
import 'package:chat_app/common/widgets/group_avatar.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/domain/entities/room_entity.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/common/extensions/screen_ext.dart';
import 'package:chat_app/common/extensions/date_time_ext.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ItemConversationWidget extends StatelessWidget {
  final RoomEntity room;
  final Function(RoomEntity room) onTap;

  const ItemConversationWidget({
    Key key,
    this.room,
    this.onTap,
  }) : super(key: key);

  String get getLastMessage {
    if (room.lastMessage == null) {
      return '[${translate(StringConst.emptyMessage)}]';
    }
    switch (room.lastMessage.contentType) {
      case MessageType.text:
        return room.lastMessage.content;
      case MessageType.audio:
        return '[${translate(StringConst.audio)}]';
      case MessageType.video:
        return '[${translate(StringConst.video)}]';
      case MessageType.image:
        return '[${translate(StringConst.image)}]';
      default:
        return '[${translate(StringConst.emptyMessage)}]';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(room),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: GroupAvatartWidget(
              members: room.members,
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
                            room.name,
                            style: textStyleLabel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        room.lastMessage != null
                            ? Text(
                                room.lastMessage.getCreatedAt.timeAgo(),
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 12.sp,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  Text(
                    getLastMessage,
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
