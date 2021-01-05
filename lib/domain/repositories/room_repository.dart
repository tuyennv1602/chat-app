import 'package:chat_app/data/models/position_model.dart';
import 'package:chat_app/data/models/response/join_code_response_model.dart';
import 'package:chat_app/data/models/response/join_room_response_model.dart';
import 'package:chat_app/data/models/response/member_position_response_model.dart';
import 'package:chat_app/data/models/response/rooms_response_model.dart';

abstract class RoomRepository {
  Future<RoomResponseModel> loadRooms(int page);

  Future<JoinCodeResponseModel> getJoinCode(int roomId);

  Future<JoinRoomResponseModel> joinRoom(String joinCode);

  Future<JoinRoomResponseModel> createRoom(String roomName, List<String> memberIDs);

  Future<dynamic> updateLocation(PositionModel positionModel, int userId, int roomId);

  Future<MemberPositionResponseModel> getMemberPositions(int roomId);
}
