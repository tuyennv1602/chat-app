import 'package:chat_app/common/exception/network_exception.dart';
import 'package:chat_app/common/platform/network_info.dart';
import 'package:chat_app/data/datasource/remote/task_remote_datasource.dart';
import 'package:chat_app/data/models/request/create_task_request_model.dart';
import 'package:chat_app/data/models/response/tasks_response_model.dart';
import 'package:chat_app/domain/entities/task_entity.dart';
import 'package:chat_app/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource taskRemoteDataSource;
  final NetworkInfoImpl networkInfo;

  TaskRepositoryImpl(this.taskRemoteDataSource, this.networkInfo);

  @override
  Future<TaskResponseModel> loadTasks(int roomId) async {
    if (await networkInfo.isConnected) {
      return taskRemoteDataSource.loadTask(roomId);
    } else {
      throw NetworkException();
    }
  }

  @override
  Future<TaskEntity> getTaskDetail(int taskId) async {
    if (await networkInfo.isConnected) {
      return taskRemoteDataSource.getTaskDetail(taskId);

    } else {
      throw NetworkException();
    }
  }

  @override
  Future<void> createTask(CreateTaskRequestModel createTaskRequestModel) async {
    if (await networkInfo.isConnected) {
      return taskRemoteDataSource.createTask(createTaskRequestModel);
    } else {
      throw NetworkException();
    }
  }
}