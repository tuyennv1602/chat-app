import 'package:chat_app/data/models/response/search_user_response_model.dart';
import 'package:chat_app/data/models/user_model.dart';

abstract class UserRepository {
  Future<SearchUserResponseModel> searchUser(String key);

  Future<UserModel> getUser();
}
