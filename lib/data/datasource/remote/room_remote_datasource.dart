import 'package:chat_app/common/network/client.dart';
import 'package:chat_app/data/models/position_model.dart';
import 'package:chat_app/data/models/response/join_code_response_model.dart';
import 'package:chat_app/data/models/response/join_room_response_model.dart';
import 'package:chat_app/data/models/response/member_position_response_model.dart';
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

  Future<dynamic> updateLocation(PositionModel position, int userId, int roomId) async {
    final body = <String, dynamic>{
      'room_id': roomId,
      'user_id': userId,
    };
    final resp = await client.put('position', body: body..addAll(position.toJson()));
    return resp.data;
  }

  Future<MemberPositionResponseModel> getMemberPositions(int roomId) async {
    final resp = await client.get('positions/room', queryParams: {'room_id': roomId});
    return MemberPositionResponseModel.fromJson(resp.data);
  }
}
