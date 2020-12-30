import 'package:chat_app/data/models/member_model.dart';
import 'package:chat_app/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    int status,
    int id,
    String name,
    String content,
    String timeStart,
    String deadline,
    int roomId,
    String priority,
    MemberModel leader,
    List<MemberModel> members,
  }) : super(
          id: id,
          status: status,
          name: name,
          content: content,
          timeStart: timeStart,
          deadline: deadline,
          roomId: roomId,
          priority: priority,
          leader: leader,
          members: members,
        );

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    name = json['name'];
    content = json['content'];
    timeStart = json['time_start'];
    deadline = json['deadline'];
    roomId = json['room_id'];
    priority = json['priority'];
    leader = json['created_by'] != null ? MemberModel.fromJson(json['created_by']) : null;
    if (json['members'] != null) {
      members = <MemberModel>[];
      json['members'].forEach((v) {
        members.add(MemberModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['name'] = name;
    data['content'] = content;
    data['time_start'] = timeStart;
    data['deadline'] = deadline;
    data['room_id'] = roomId;
    data['priority'] = priority;
    if (leader != null) {
      data['created_by'] = leader.toJson();
    }
    if (members != null) {
      data['members'] = members.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
