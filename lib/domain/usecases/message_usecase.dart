import 'package:chat_app/data/models/response/messages_response_model.dart';
import 'package:chat_app/domain/repositories/message_repository.dart';

class MessageUseCase {
  final MessageRepository messageRepository;

  MessageUseCase({this.messageRepository});

  Future<MessagesResponseModel> getMessages(int roomId, int page, int pageSize) =>
      messageRepository.getMessages(roomId, page, pageSize);

  Future<String> uploadFile(String filePath, String fileName, String type) =>
      messageRepository.uploadFile(filePath, fileName, type);
}
