import 'dart:convert';

import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/domain/entities/user_entity.dart';

import 'app_shared_preference.dart';

class LocalDataSource {
  static const String accessTokenKey = 'access-token';
  static const String userKey = 'user';

  final AppSharedPreference sharedPreferences;
  LocalDataSource({this.sharedPreferences});

  Future<bool> setToken(String accessToken) async {
    return sharedPreferences.instance.setString(accessTokenKey, accessToken);
  }

  Future<String> getToken() async {
    return sharedPreferences.instance.getString(accessTokenKey);
  }

  Future<bool> clearToken() async {
    return sharedPreferences.instance.remove(accessTokenKey);
  }

  Future<bool> setUser(UserModel user) async {
    return sharedPreferences.instance.setString(userKey, jsonEncode(user));
  }

  Future<UserEntity> getUser() async {
    final data = sharedPreferences.instance.getString(userKey);
    return data == null ? null : UserModel.fromJson(jsonDecode(data));
  }

  Future<bool> clearUser() async {
    return sharedPreferences.instance.remove(userKey);
  }

  Future<void> clearAll() async {
    await clearToken();
    await clearUser();
  }
}
