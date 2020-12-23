import 'package:chat_app/domain/entities/room_entity.dart';

abstract class RoomState {
  final List<RoomEntity> rooms;
  final bool canLoadMore;
  final int page;

  RoomState({
    this.rooms,
    this.canLoadMore = false,
    this.page = 1,
  });
}

class InitialRoomState extends RoomState {
  InitialRoomState() : super(rooms: []);
}

class LoadingRoomState extends RoomState {
  LoadingRoomState() : super(rooms: []);
}

class LoadingMoreRoomState extends RoomState {
  LoadingMoreRoomState({List<RoomEntity> rooms}) : super(rooms: rooms);
}

class RefreshingRoomState extends RoomState {
  RefreshingRoomState({List<RoomEntity> rooms}) : super(rooms: rooms);
}

class LoadedRoomState extends RoomState {
  LoadedRoomState({
    List<RoomEntity> rooms,
    bool canLoadMore,
    int page,
  }) : super(
          rooms: rooms,
          canLoadMore: canLoadMore,
          page: page,
        );
}

class ErrorLoadRoomState extends RoomState {
  final String error;
  ErrorLoadRoomState(
    this.error, {
    List<RoomEntity> rooms,
    bool canLoadMore,
    int page,
  }) : super(rooms: rooms, canLoadMore: canLoadMore, page: page);
}
