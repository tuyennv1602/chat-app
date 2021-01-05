import 'package:chat_app/data/datasource/remote/room_remote_datasource.dart';
import 'package:chat_app/data/models/position_model.dart';
import 'package:chat_app/data/models/response/join_code_response_model.dart';
import 'package:chat_app/data/models/response/join_room_response_model.dart';
import 'package:chat_app/data/models/response/member_position_response_model.dart';
import 'package:chat_app/data/models/response/rooms_response_model.dart';
import 'package:chat_app/domain/repositories/room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  final RoomRemoteDataSource roomRemoteDataSource;

  RoomRepositoryImpl({
    this.roomRemoteDataSource,
  });
  @override
  Future<RoomResponseModel> loadRooms(int page) async {
    return roomRemoteDataSource.loadRoom(page);
  }

  @override
  Future<JoinCodeResponseModel> getJoinCode(int roomId) async {
    return roomRemoteDataSource.getJoinCode(roomId);
  }

  @override
  Future<JoinRoomResponseModel> joinRoom(String joinCode) async {
    return roomRemoteDataSource.joinRoom(joinCode);
  }

  @override
  Future<JoinRoomResponseModel> createRoom(String roomName, List<String> memberIDs) async {
    return roomRemoteDataSource.createRoom(roomName, memberIDs);
  }

  @override
  Future updateLocation(PositionModel positionModel, int userId, int roomId) async {
    return roomRemoteDataSource.updateLocation(positionModel, userId, roomId);
  }

  @override
  Future<MemberPositionResponseModel> getMemberPositions(int roomId) async {
    return roomRemoteDataSource.getMemberPositions(roomId);
  }
}
