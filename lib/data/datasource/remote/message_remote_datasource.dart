import 'package:chat_app/common/network/client.dart';
import 'package:chat_app/data/models/response/messages_response_model.dart';
import 'package:dio/dio.dart';

class MessageRemoteDataSource {
  final Client client;

  MessageRemoteDataSource({this.client});

  Future<MessagesResponseModel> loadMessages(int roomId, int page, int pageSize) async {
    final resp = await client.post('room/message?page_no=$page&page_size=$pageSize', body: {
      'room_id': roomId,
    });
    return MessagesResponseModel.fromJson(resp.data['data']);
  }

  Future<String> uploadFile(String filePath, String fileName, String type) async {
    final data = FormData.fromMap(
      {
        'file': await MultipartFile.fromFile(
          filePath,
          filename: '$fileName.$type',
        ),
      },
    );
    final resp = await client.uploadFile('file/upload', body: data);
    return resp.data['data']['filename'];
  }
}
