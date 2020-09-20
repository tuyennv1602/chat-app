part of 'active_account_bloc.dart';

@immutable
abstract class ActiveAccountState {}

class ActiveAccountInitial extends ActiveAccountState {}

class ActiveAccountSuccess extends ActiveAccountState {}

class ErroredActiveAccountState extends ActiveAccountState {
  final String error;

  ErroredActiveAccountState(this.error);
}
