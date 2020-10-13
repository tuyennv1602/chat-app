import 'package:chat_app/common/network/client.dart';
import 'package:chat_app/data/models/response/search_user_response_model.dart';
import 'package:chat_app/data/models/user_model.dart';

class UserRemoteDataSource {
  final Client client;
  UserRemoteDataSource({this.client});

  Future<SearchUserResponseModel> searchUser(String key) async {
    final resp = await client.post('user/search/nickname', body: {
      'keyword': key,
    });
    return SearchUserResponseModel.fromJson(resp.data);
  }

  Future<UserModel> getUser() async {
    final resp = await client.get('user/info');
    return UserModel.fromJson(resp.data['data']);
  }
}
