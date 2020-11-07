import 'package:chat_app/data/models/member_model.dart';
import 'package:chat_app/data/models/message_model.dart';

class RoomEntity {
  int id;
  String name;
  int adminId;
  int totalMember;
  List<MemberModel> members;
  MessageModel lastMessage;
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
