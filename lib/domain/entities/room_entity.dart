import 'package:chat_app/data/models/member_model.dart';

class RoomEntity {
  int id;
  String name;
  int adminId;
  int totalMember;
  List<MemberModel> members;
  dynamic lastMessage;
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
