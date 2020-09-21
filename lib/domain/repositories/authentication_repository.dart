import 'package:chat_app/data/models/login_response_model.dart';

abstract class AuthenticationRepository {
  Future<LoginResponseModel> login(String email, String password);
  Future<bool> activeAccount(String email, String verifyCode);
}
