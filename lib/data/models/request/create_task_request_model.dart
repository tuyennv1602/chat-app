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
    data['listSelectedMemberId'] = listSelectedMemberId;
    data['createDate'] = createDate;
    data['finishDate'] = finishDate;
    data['priorityId'] = priorityId;
    data['taskTitle'] = taskTitle;
    data['taskContent'] = taskContent;
    data['roomId'] = roomId;
    data['createBy'] = createBy;
    return data;
  }
}
