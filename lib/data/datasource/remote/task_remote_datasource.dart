import 'package:chat_app/common/network/client.dart';
import 'package:chat_app/data/models/response/tasks_response_model.dart';

class TaskRemoteDataSource {
  final Client client;

  TaskRemoteDataSource({this.client});

  Future<TaskResponseModel> loadTask(int roomId) async {
    final resp = await client.get('room/mission/$roomId');
    return  TaskResponseModel.fromJson(resp.data);
  }
}
