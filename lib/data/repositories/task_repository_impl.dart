import 'package:chat_app/data/datasource/remote/task_remote_datasource.dart';
import 'package:chat_app/domain/entities/task_entity.dart';
import 'package:chat_app/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource taskRemoteDataSource;

  TaskRepositoryImpl(this.taskRemoteDataSource);

  @override
  Future<List<TaskEntity>> loadTasks(int roomId) {
    return taskRemoteDataSource.loadTask(roomId);
  }

  @override
  Future<TaskEntity> getTaskDetail(int taskId) {
    return taskRemoteDataSource.getTaskDetail(taskId);
  }
}