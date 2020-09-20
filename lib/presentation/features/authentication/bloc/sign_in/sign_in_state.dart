abstract class SignInState {}

class InitialSignInState extends SignInState {}

class SignedInState extends SignInState {}

class AccountInActiveState extends SignInState {
  final String message;
  AccountInActiveState(this.message);
}

class ErroredSignInState extends SignInState {
  final String error;

  ErroredSignInState(this.error);
}
