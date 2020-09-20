import 'package:chat_app/common/network/client.dart';
import 'package:chat_app/data/models/login_response_model.dart';

class AuthenticationRemoteDataSource {
  final Client client;
  AuthenticationRemoteDataSource({this.client});

  Future<LoginResponseModel> login(String email, String password) async {
    final resp = await client.post('login', body: {
      'email': email,
      'password': password,
    });
    return LoginResponseModel.fromJson(resp.data['data']);
  }

  Future<void> activeAccount(
    String email,
    String verifyCode,
  ) async {
    await client.post('account/activate', body: {
      'email': email,
      'activation_code': verifyCode,
    });
  }
}
