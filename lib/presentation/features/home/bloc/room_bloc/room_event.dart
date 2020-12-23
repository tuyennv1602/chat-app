abstract class RoomEvent {}

class LoadRoomEvent extends RoomEvent {
  LoadRoomEvent();
}

class RefreshRoomEvent extends RoomEvent {}

class LoadMoreRoomEvent extends RoomEvent {}

class RequestJoinRoomEvent extends RoomEvent {
  final String joinCode;

  RequestJoinRoomEvent(this.joinCode);
}
