part of 'active_account_bloc.dart';

@immutable
abstract class ActiveAccountState {}

class ActiveAccountInitialState extends ActiveAccountState {}

class ActiveAccountSuccessState extends ActiveAccountState {}

class ErroredActiveAccountState extends ActiveAccountState {
  final String error;

  ErroredActiveAccountState(this.error);
}
