import 'package:chat_app/data/models/login_response_model.dart';
import 'package:chat_app/data/models/register_request_model.dart';

abstract class AuthenticationRepository {
  Future<LoginResponseModel> login(String email, String password);
  Future<bool> register(RegisterRequestModel registerRequestModel);
  Future<bool> activeAccount(String email, String verifyCode);
}
