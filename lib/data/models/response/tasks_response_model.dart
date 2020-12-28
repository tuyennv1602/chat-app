import 'package:chat_app/data/models/task_model.dart';

class TaskResponseModel {
  List<TaskModel> tasks;

  TaskResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      tasks = <TaskModel>[];
      json['data'].forEach((v) {
        tasks.add(TaskModel.fromJson(v));
      });
    }
  }

}