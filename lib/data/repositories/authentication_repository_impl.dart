import 'package:chat_app/common/exception/network_exception.dart';
import 'package:chat_app/common/platform/network_info.dart';
import 'package:chat_app/data/datasource/local/local_datasource.dart';
import 'package:chat_app/data/datasource/remote/authentication_remote_datasource.dart';
import 'package:chat_app/data/models/login_response_model.dart';
import 'package:chat_app/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource remoteDataSource;
  final NetworkInfoImpl networkInfo;
  final LocalDataSource localDataSource;

  AuthenticationRepositoryImpl({
    this.remoteDataSource,
    this.networkInfo,
    this.localDataSource,
  });

  @override
  Future<LoginResponseModel> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      final resp = await remoteDataSource.login(email, password);
      await localDataSource.setToken(resp.token);
      await localDataSource.setUser(resp.userModel);
      return resp;
    } else {
      throw NetworkException();
    }
  }

  @override
  Future<bool> activeAccount(String email, String verifyCode) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.activeAccount(email, verifyCode);
    } else {
      throw NetworkException();
    }
  }
}
