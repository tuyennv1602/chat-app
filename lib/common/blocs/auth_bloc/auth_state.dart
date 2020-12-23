import 'package:chat_app/domain/entities/user_entity.dart';

abstract class AuthState {
  String token;
  UserEntity user;

  AuthState({this.token, this.user});
}

class InitialAuthState extends AuthState {
  InitialAuthState() : super(token: null, user: null);
}

class CheckingAuthenticatedState extends AuthState {
  CheckingAuthenticatedState() : super(token: null, user: null);
}

class AuthenticatedState extends AuthState {
  AuthenticatedState(UserEntity user, String token) : super(token: token, user: user);
}

class UnAuthenticatedState extends AuthState {
  UnAuthenticatedState({UserEntity user}) : super(token: null, user: user);
}

class ErroredAuthState extends AuthState {
  final String message;

  ErroredAuthState(this.message) : super(token: null, user: null);
}
