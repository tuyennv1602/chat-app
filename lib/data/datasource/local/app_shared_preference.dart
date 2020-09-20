import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreference {
  SharedPreferences sharedPreferences;

  AppSharedPreference() {
    initSharedPreference();
  }

  Future<void> initSharedPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  SharedPreferences get instance => sharedPreferences;
}
