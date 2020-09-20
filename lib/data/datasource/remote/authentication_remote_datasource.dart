import 'package:chat_app/common/network/client.dart';
import 'package:chat_app/data/models/login_response_model.dart';
import 'package:chat_app/data/models/register_request_model.dart';

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

  Future<bool> register(RegisterRequestModel reg) async {
    final resp = await client.post('account/register', body: {
      'code': reg.code,
      'nickname': reg.nickname,
      'fullname': reg.fullname,
      'phone_number': reg.phoneNumber,
      'email': reg.email,
      'password': reg.password
    });
    return resp.data['success'];
  }
}
