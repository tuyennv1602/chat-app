part of 'active_account_bloc.dart';

@immutable
abstract class ActiveAccountEvent {}

class SubmitActiveAccountEvent extends ActiveAccountEvent {
  final String email;
  final String verifyCode;

  SubmitActiveAccountEvent({this.email, this.verifyCode});
}
