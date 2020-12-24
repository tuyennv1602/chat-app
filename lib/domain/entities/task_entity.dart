import 'package:chat_app/data/models/member_model.dart';
import 'package:intl/intl.dart';

enum TaskStatus {
  none,
  done,
  cancel,
}

class TaskEntity {
  int status;
  int id;
  String name;
  String content;
  String timeStart;
  String deadline;
  int roomId;
  String priority;
  MemberModel leader;

  TaskEntity({
    this.status,
    this.id,
    this.name,
    this.content,
    this.timeStart,
    this.deadline,
    this.roomId,
    this.priority,
    this.leader,
  });

  TaskStatus get checkTaskStatus {
    switch (status) {
      case 0:
        return TaskStatus.cancel;
      case 1:
        return TaskStatus.done;
      default:
        return TaskStatus.none;
    }
  }

  DateTime get startTime{
    try {
      return DateFormat('yyyy-MM-dd HH:mm:ss').parse(timeStart);
    } catch (e) {
      return DateTime.now();
    }
  }

  DateTime get endTime{
    try {
      return DateFormat('yyyy-MM-dd HH:mm:ss').parse(deadline);
    } catch (e) {
      return DateTime.now();
    }
  }
}
