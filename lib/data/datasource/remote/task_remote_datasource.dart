import 'package:chat_app/common/network/client.dart';
import 'package:chat_app/data/models/task_model.dart';
import 'package:chat_app/domain/entities/task_entity.dart';

class TaskRemoteDataSource {
  final Client client;

  TaskRemoteDataSource({this.client});

  Future<List<TaskEntity>> loadTask(int roomId) async {
    final resp = await client.get('room/mission/$roomId');
    final tasks = <TaskEntity>[];
    resp.data['data'].forEach((v) {
      tasks.add(TaskModel.fromJson(v));
    });
    return tasks;
  }
}
