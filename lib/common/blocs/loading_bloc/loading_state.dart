abstract class LoadingState {}

class EmptyState extends LoadingState {}

class Loading extends LoadingState {
  Loading();
}

class Loaded extends LoadingState {
  Loaded();
}
