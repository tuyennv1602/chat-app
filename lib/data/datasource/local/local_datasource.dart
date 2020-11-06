import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  static const String accessTokenKey = 'access-token';

  Future<bool> setToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(accessTokenKey, accessToken);
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(accessTokenKey);
  }

  Future<bool> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(accessTokenKey);
  }

  Future<bool> clearAll() async {
    return clearToken();
  }
}
