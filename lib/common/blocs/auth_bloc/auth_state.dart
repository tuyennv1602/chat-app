import 'package:chat_app/domain/entities/user_entity.dart';

abstract class AuthState {}

class InitialAuthState extends AuthState {}

class AuthenticatedState extends AuthState {
  final UserEntity user;

  AuthenticatedState(this.user);
}

class UnAuthenticatedState extends AuthState {}

class ErroredAuthState extends AuthState {
  final String message;

  ErroredAuthState(this.message);
}
