import 'package:chat_app/data/models/request/create_task_request_model.dart';
import 'package:chat_app/data/models/response/tasks_response_model.dart';
import 'package:chat_app/domain/entities/task_entity.dart';
import 'package:chat_app/domain/repositories/task_repository.dart';

class TaskUseCase {
  final TaskRepository taskRepository;

  TaskUseCase({this.taskRepository});

  Future<TaskResponseModel> loadTasks(int roomId) => taskRepository.loadTasks(roomId);

  Future<TaskEntity> getTaskDetail(int taskId) => taskRepository.getTaskDetail(taskId);

  Future<void> createTask(CreateTaskRequestModel createTaskRequestModel) => taskRepository.createTask(createTaskRequestModel);

}
