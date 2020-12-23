abstract class UpdateAvatarState {}

class InitialUpdateAvatarState extends UpdateAvatarState {}

class UpdatingAvatarState extends UpdateAvatarState {
  final String filePath;

  UpdatingAvatarState(this.filePath);
}

class UpdateAvatarSuccessfulState extends UpdateAvatarState {}

class ErrorUpdateAvatarState extends UpdateAvatarState {
  final String message;

  ErrorUpdateAvatarState(this.message);
}
