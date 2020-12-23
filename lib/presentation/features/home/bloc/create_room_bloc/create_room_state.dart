abstract class CreateRoomState {}

class InitialCreateRoomState extends CreateRoomState {}

class CreatedRoomSuccessState extends CreateRoomState {}

class ErroredCreateRoomState extends CreateRoomState {
  final String error;

  ErroredCreateRoomState(this.error);
}
