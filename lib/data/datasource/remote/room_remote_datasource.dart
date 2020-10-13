import 'package:chat_app/common/network/client.dart';
import 'package:chat_app/data/models/response/join_code_response_model.dart';
import 'package:chat_app/data/models/response/join_room_response_model.dart';
import 'package:chat_app/data/models/response/rooms_response_model.dart';

class RoomRemoteDataSource {
  final Client client;
  RoomRemoteDataSource({this.client});

  Future<RoomResponseModel> loadRoom(int page) async {
    final resp = await client.get('rooms', queryParams: {
      'pageNo': page,
      'pageSize': 15,
    });
    return RoomResponseModel.fromJson(resp.data['data']);
  }

  Future<JoinCodeResponseModel> getJoinCode(int roomId) async {
    final resp = await client.post('room_code', body: {'room_id': roomId});
    return JoinCodeResponseModel.fromJson(resp.data['data']);
  }

  Future<JoinRoomResponseModel> joinRoom(String joinCode) async {
    final resp = await client.post('room/join', body: {'room_code': joinCode});
    return JoinRoomResponseModel.fromJson(resp.data['data']);
  }

  Future<JoinRoomResponseModel> createRoom(String roomName, List<String> memberIDs) async {
    final resp = await client.post('room', body: {
      'name': roomName,
      'members': memberIDs,
    });
    return JoinRoomResponseModel.fromJson(resp.data['data']);
  }
}
