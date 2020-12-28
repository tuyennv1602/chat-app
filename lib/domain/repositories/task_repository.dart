import 'package:chat_app/data/models/response/tasks_response_model.dart';

abstract class TaskRepository {
  Future<TaskResponseModel> loadTasks(int roomId);
}
