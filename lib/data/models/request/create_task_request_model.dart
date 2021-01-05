import 'package:chat_app/common/extensions/date_time_ext.dart';

class CreateTaskRequestModel {
  List<int> listSelectedMemberId;
  DateTime createDate;
  DateTime finishDate;
  int priorityId = 3;
  String taskTitle;
  String taskContent;
  int roomId;
  int createBy;

  CreateTaskRequestModel({
    this.listSelectedMemberId,
    this.createDate,
    this.finishDate,
    this.priorityId,
    this.taskTitle,
    this.taskContent,
    this.roomId,
    this.createBy,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mission_members'] = listSelectedMemberId;
    data['time_start'] = createDate.toFormat('yyyy-MM-dd HH:mm');
    data['deadline'] = finishDate.toFormat('yyyy-MM-dd HH:mm');
    data['mission_priority_id'] = priorityId;
    data['name'] = taskTitle;
    data['content'] = taskContent;
    data['room_id'] = roomId;
    data['created_by'] = createBy;
    return data;
  }
}
