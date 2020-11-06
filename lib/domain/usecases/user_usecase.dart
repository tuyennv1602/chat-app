import 'package:chat_app/data/models/response/search_user_response_model.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/domain/repositories/user_repository.dart';

class UserUseCase {
  final UserRepository userRepository;

  UserUseCase({this.userRepository});

  Future<SearchUserResponseModel> searchUser(String key) => userRepository.searchUser(key);

  Future<UserModel> getUser() => userRepository.getUser();

  Future<String> updateAvatar(String filePath, String fileName) =>
      userRepository.uploadAvatar(filePath, fileName);
}
