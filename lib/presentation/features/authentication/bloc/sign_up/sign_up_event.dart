part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SubmitSignUpEvent extends SignUpEvent {
  final RegisterRequestModel registerRequestModel;

  SubmitSignUpEvent({this.registerRequestModel});
}
