import 'package:chat_app/data/datasource/local/local_datasource.dart';
import 'package:chat_app/data/datasource/remote/authentication_remote_datasource.dart';
import 'package:chat_app/data/models/response/login_response_model.dart';
import 'package:chat_app/data/models/request/register_request_model.dart';
import 'package:chat_app/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  AuthenticationRepositoryImpl({
    this.remoteDataSource,
    this.localDataSource,
  });

  @override
  Future<LoginResponseModel> login(String email, String password) async {
    final resp = await remoteDataSource.login(email, password);
    await localDataSource.setToken(resp.token);
    return resp;
  }

  @override
  Future<bool> register(RegisterRequestModel registerRequestModel) async {
    return remoteDataSource.register(registerRequestModel);
  }

  @override
  Future<bool> activeAccount(String email, String verifyCode) async {
    return remoteDataSource.activeAccount(email, verifyCode);
  }
}
