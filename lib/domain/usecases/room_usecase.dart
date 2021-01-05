import 'package:chat_app/data/models/position_model.dart';
import 'package:chat_app/data/models/response/join_code_response_model.dart';
import 'package:chat_app/data/models/response/join_room_response_model.dart';
import 'package:chat_app/data/models/response/member_position_response_model.dart';
import 'package:chat_app/data/models/response/rooms_response_model.dart';
import 'package:chat_app/domain/repositories/room_repository.dart';

class RoomUseCase {
  final RoomRepository roomRepository;

  RoomUseCase({this.roomRepository});

  Future<RoomResponseModel> loadRooms(int page) => roomRepository.loadRooms(page);

  Future<JoinCodeResponseModel> getJoinCode(int roomId) => roomRepository.getJoinCode(roomId);

  Future<JoinRoomResponseModel> joinRoom(String joinCode) => roomRepository.joinRoom(joinCode);

  Future<JoinRoomResponseModel> createRoom(String roomName, List<String> memberIDs) =>
      roomRepository.createRoom(roomName, memberIDs);

  Future<dynamic> updateLocation(PositionModel positionModel, int userId, int roomId) =>
      roomRepository.updateLocation(positionModel, userId, roomId);

  Future<MemberPositionResponseModel> getMemberPositions(int roomId) =>
      roomRepository.getMemberPositions(roomId);
}
