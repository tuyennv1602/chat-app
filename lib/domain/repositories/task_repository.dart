import 'package:chat_app/domain/entities/task_entity.dart';

abstract class TaskRepository {
  Future<List<TaskEntity>> loadTasks(int roomId);

  Future<TaskEntity> getTaskDetail(int taskId);
}
