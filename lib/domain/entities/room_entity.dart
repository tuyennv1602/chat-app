import 'package:chat_app/domain/entities/message_entity.dart';

import 'member_entity.dart';

class RoomEntity {
  int id;
  String name;
  int adminId;
  int totalMember;
  List<MemberEntity> members;
  MessageEntity lastMessage;
  bool isRead;

  RoomEntity({
    this.id,
    this.name,
    this.adminId,
    this.totalMember,
    this.members,
    this.lastMessage,
    this.isRead,
  });
}
