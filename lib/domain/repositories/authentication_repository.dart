import 'package:chat_app/data/models/login_response_model.dart';

abstract class AuthenticationRepository {
  Future<LoginResponseModel> login(String email, String password);
  Future<void> activeAccount(String email, String verifyCode);
}
