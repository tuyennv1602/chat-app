import 'package:chat_app/data/datasource/remote/user_remote_datasource.dart';
import 'package:chat_app/data/models/response/search_user_response_model.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl({this.userRemoteDataSource});

  @override
  Future<SearchUserResponseModel> searchUser(String key) async {
    return userRemoteDataSource.searchUser(key);
  }

  @override
  Future<UserModel> getUser() async {
    return userRemoteDataSource.getUser();
  }

  @override
  Future<String> uploadAvatar(String filePath, String fileName) async {
    return userRemoteDataSource.updateAvatar(filePath, fileName);
  }
}
