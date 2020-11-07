import 'package:chat_app/data/models/member_model.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/domain/entities/room_entity.dart';

class RoomModel extends RoomEntity {
  RoomModel({
    int id,
    String name,
    int adminId,
    int totalMember,
    List<MemberModel> members,
    MessageModel lastMessage,
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
      members = <MemberModel>[];
      json['members'].forEach((v) {
        members.add(MemberModel.fromJson(v));
      });
    }
    lastMessage = json['last_message'] != null ? MessageModel.fromJson(json['last_message']) : null;
    isRead = json['is_read'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['admin_id'] = adminId;
    data['total_member'] = totalMember;
    if (members != null) {
      data['members'] = members.map((v) => v.toJson()).toList();
    }
    if (lastMessage != null) {
      data['last_message'] = lastMessage.toJson();
    }
    data['is_read'] = isRead;
    return data;
  }
}
