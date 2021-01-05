import 'package:chat_app/data/models/member_model.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/domain/entities/member_entity.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/domain/entities/room_entity.dart';

class RoomModel extends RoomEntity {
  RoomModel({
    int id,
    String name,
    int adminId,
    int totalMember,
    List<MemberEntity> members,
    MessageEntity lastMessage,
    bool isRead,
  }) : super(
          id: id,
          name: name,
          adminId: adminId,
          totalMember: totalMember,
          members: members,
          lastMessage: lastMessage,
          isRead: isRead,
        );

  RoomModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    adminId = json['admin_id'];
    totalMember = json['total_member'];
    if (json['members'] != null) {
      members = <MemberEntity>[];
      json['members'].forEach((v) {
        members.add(MemberModel.fromJson(v));
      });
    }
    lastMessage = json['last_message'] != null ? MessageModel.fromJson(json['last_message']) : null;
    isRead = json['is_read'];
  }
}
