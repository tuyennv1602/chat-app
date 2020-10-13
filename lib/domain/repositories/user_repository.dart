import 'package:chat_app/data/models/response/search_user_response_model.dart';

abstract class UserRepository {
  Future<SearchUserResponseModel> searchUser(String key);
}
