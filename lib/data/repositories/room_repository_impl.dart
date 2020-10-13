import 'package:chat_app/common/exception/network_exception.dart';
import 'package:chat_app/common/platform/network_info.dart';
import 'package:chat_app/data/datasource/remote/room_remote_datasource.dart';
import 'package:chat_app/data/models/response/join_code_response_model.dart';
import 'package:chat_app/data/models/response/join_room_response_model.dart';
import 'package:chat_app/data/models/response/rooms_response_model.dart';
import 'package:chat_app/domain/repositories/room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  final RoomRemoteDataSource roomRemoteDataSource;
  final NetworkInfoImpl networkInfo;

  RoomRepositoryImpl({
    this.roomRemoteDataSource,
    this.networkInfo,
  });
  @override
  Future<RoomResponseModel> loadRooms(int page) async {
    if (await networkInfo.isConnected) {
      return roomRemoteDataSource.loadRoom(page);
    } else {
      throw NetworkException();
    }
  }

  @override
  Future<JoinCodeResponseModel> getJoinCode(int roomId) async {
    if (await networkInfo.isConnected) {
      return roomRemoteDataSource.getJoinCode(roomId);
    } else {
      throw NetworkException();
    }
  }

  @override
  Future<JoinRoomResponseModel> joinRoom(String joinCode) async {
    if (await networkInfo.isConnected) {
      return roomRemoteDataSource.joinRoom(joinCode);
    } else {
      throw NetworkException();
    }
  }

  @override
  Future<JoinRoomResponseModel> createRoom(String roomName, List<String> memberIDs) async {
    if (await networkInfo.isConnected) {
      return roomRemoteDataSource.createRoom(roomName, memberIDs);
    } else {
      throw NetworkException();
    }
  }
}
