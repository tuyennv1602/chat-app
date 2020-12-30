import 'package:chat_app/data/models/response/tasks_response_model.dart';
import 'package:chat_app/domain/entities/task_entity.dart';

abstract class TaskRepository {
  Future<TaskResponseModel> loadTasks(int roomId);

  Future<TaskEntity> getTaskDetail(int taskId);
}
