import 'package:chat_app/data/models/user_model.dart';

abstract class AuthEvent {}

class CheckAuthEvent extends AuthEvent {}

class SignedInEvent extends AuthEvent {
  final String token;
  final UserModel user;

  SignedInEvent({
    this.token,
    this.user,
  });
}

class SignedOutEvent extends AuthEvent {}
