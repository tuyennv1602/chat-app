import 'package:chat_app/common/exception/network_exception.dart';
import 'package:chat_app/common/platform/network_info.dart';
import 'package:chat_app/data/datasource/remote/user_remote_datasource.dart';
import 'package:chat_app/data/models/response/search_user_response_model.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  final NetworkInfoImpl networkInfo;

  UserRepositoryImpl({this.userRemoteDataSource, this.networkInfo});

  @override
  Future<SearchUserResponseModel> searchUser(String key) async {
    if (await networkInfo.isConnected) {
      return userRemoteDataSource.searchUser(key);
    } else {
      throw NetworkException();
    }
  }

  @override
  Future<UserModel> getUser() async {
    if (await networkInfo.isConnected) {
      return userRemoteDataSource.getUser();
    } else {
      throw NetworkException();
    }
  }

  @override
  Future<String> uploadAvatar(String filePath, String fileName) async {
    if (await networkInfo.isConnected) {
      return userRemoteDataSource.updateAvatar(filePath, fileName);
    } else {
      throw NetworkException();
    }
  }
}
