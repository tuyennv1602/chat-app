import 'package:chat_app/data/models/response/messages_response_model.dart';

abstract class MessageRepository {
  Future<MessagesResponseModel> getMessages(int roomId, int page, int pageSize);

  Future<String> uploadFile(String filePath, String fileName, String type);
}
