import 'package:chat_app/common/network/client.dart';
import 'package:chat_app/data/models/request/create_task_request_model.dart';
import 'package:chat_app/data/models/response/tasks_response_model.dart';
import 'package:chat_app/data/models/task_model.dart';
import 'package:chat_app/domain/entities/task_entity.dart';

class TaskRemoteDataSource {
  final Client client;

  TaskRemoteDataSource({this.client});

  Future<TaskResponseModel> loadTask(int roomId) async {
    final resp = await client.get('room/mission/$roomId');
    return  TaskResponseModel.fromJson(resp.data);
  }

  Future<TaskEntity> getTaskDetail(int taskId) async {
    final resp = await client.get('mission/$taskId');
     final task =  TaskModel.fromJson(resp.data['data']);
    return task;
  }

  Future<void> createTask(CreateTaskRequestModel createTaskRequestModel) async {
    final resp = await client.post('mission', body: createTaskRequestModel.toJson());
    return resp.data['success'];
  }
}
