import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String _token = "token";
  static final String _member = "member";


  static Future<bool> clearPreference(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString(key);
    return preferences.clear();
  }

  /// ------------------------------------------------------------
  /// Set Get Token Preference
  /// ------------------------------------------------------------

  static Future<bool> setToken(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(_token, value);
  }

  static Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_token) ?? '';
  }



  static Future<bool> setMember(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(_member, value);
  }

  static Future<String> getMember() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_member) ?? '';
  }
}
