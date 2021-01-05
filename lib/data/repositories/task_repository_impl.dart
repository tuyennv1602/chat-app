import 'package:chat_app/data/datasource/remote/task_remote_datasource.dart';
import 'package:chat_app/data/models/request/create_task_request_model.dart';
import 'package:chat_app/data/models/response/tasks_response_model.dart';
import 'package:chat_app/domain/entities/task_entity.dart';
import 'package:chat_app/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource taskRemoteDataSource;

  TaskRepositoryImpl(this.taskRemoteDataSource);

  @override
  Future<TaskResponseModel> loadTasks(int roomId) async {
    return taskRemoteDataSource.loadTask(roomId);
  }

  @override
  Future<TaskEntity> getTaskDetail(int taskId) async {
    return taskRemoteDataSource.getTaskDetail(taskId);
  }

  @override
  Future<void> createTask(CreateTaskRequestModel createTaskRequestModel) async {
    return taskRemoteDataSource.createTask(createTaskRequestModel);
  }
}
