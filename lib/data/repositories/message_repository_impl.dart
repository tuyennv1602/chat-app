import 'package:chat_app/common/exception/network_exception.dart';
import 'package:chat_app/common/platform/network_info.dart';
import 'package:chat_app/data/datasource/remote/message_remote_datasource.dart';
import 'package:chat_app/data/models/response/messages_response_model.dart';
import 'package:chat_app/domain/repositories/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDataSource messageRemoteDataSource;
  final NetworkInfoImpl networkInfo;

  MessageRepositoryImpl({this.messageRemoteDataSource, this.networkInfo});

  @override
  Future<MessagesResponseModel> getMessages(int roomId, int page, int pageSize) async {
    if (await networkInfo.isConnected) {
      return messageRemoteDataSource.loadMessages(roomId, page, pageSize);
    } else {
      throw NetworkException();
    }
  }

  @override
  Future<String> uploadFile(String filePath, String fileName, String type) async {
    if (await networkInfo.isConnected) {
      return messageRemoteDataSource.uploadFile(filePath, fileName, type);
    } else {
      throw NetworkException();
    }
  }
}
