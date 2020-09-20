abstract class SignInEvent {}

class SubmitLoginEvent extends SignInEvent {
  final String email;
  final String password;

  SubmitLoginEvent({this.email, this.password});
}
