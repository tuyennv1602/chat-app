import 'package:chat_app/domain/entities/task_entity.dart';
import 'package:chat_app/domain/repositories/task_repository.dart';

class TaskUseCase {
  final TaskRepository taskRepository;

  TaskUseCase({this.taskRepository});

  Future<List<TaskEntity>> loadTasks(int roomId) => taskRepository.loadTasks(roomId);

}
