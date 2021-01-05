import 'package:chat_app/data/datasource/remote/message_remote_datasource.dart';
import 'package:chat_app/data/models/response/messages_response_model.dart';
import 'package:chat_app/domain/repositories/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDataSource messageRemoteDataSource;

  MessageRepositoryImpl({this.messageRemoteDataSource});

  @override
  Future<MessagesResponseModel> getMessages(int roomId, int page, int pageSize) async {
    return messageRemoteDataSource.loadMessages(roomId, page, pageSize);
  }

  @override
  Future<String> uploadFile(String filePath, String fileName, String type) async {
    return messageRemoteDataSource.uploadFile(filePath, fileName, type);
  }
}
