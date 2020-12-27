import 'package:chat_app/data/datasource/remote/task_remote_datasource.dart';
import 'package:chat_app/data/models/response/tasks_response_model.dart';
import 'package:chat_app/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource taskRemoteDataSource;

  TaskRepositoryImpl(this.taskRemoteDataSource);

  @override
  Future<TaskResponseModel> loadTasks(int roomId) {
    return taskRemoteDataSource.loadTask(roomId);
  }
}