import 'package:chat_app/data/models/response/login_response_model.dart';
import 'package:chat_app/data/models/request/register_request_model.dart';
import 'package:chat_app/domain/repositories/authentication_repository.dart';

class AuthenticationUseCase {
  final AuthenticationRepository authenticationRepository;

  AuthenticationUseCase({this.authenticationRepository});

  Future<LoginResponseModel> login(String email, String password) =>
      authenticationRepository.login(email, password);

  Future<bool> register(RegisterRequestModel registerRequestModel) =>
      authenticationRepository.register(registerRequestModel);

  Future<bool> activeAccount(String email, String verifyCode) =>
      authenticationRepository.activeAccount(email, verifyCode);
}
