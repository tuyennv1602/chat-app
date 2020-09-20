part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignedUpState extends SignUpState {}

class ErroredSignUpState extends SignUpState {
  final String error;

  ErroredSignUpState(this.error);
}
