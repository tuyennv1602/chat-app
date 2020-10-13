abstract class OptionState {}

class InitialOptionState extends OptionState {}

class LoadingOptionState extends OptionState {}

class LoadedJoinCodeOptionState extends OptionState {
  final String joinCode;

  LoadedJoinCodeOptionState(this.joinCode);
}

class ErroredOptionState extends OptionState {
  final String error;

  ErroredOptionState(this.error);
}
