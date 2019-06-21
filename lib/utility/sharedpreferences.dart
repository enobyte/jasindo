import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String _token = 'token';
  static final String _member = 'member';
  static final String _plans = 'plans';
  static final String _phone = 'phone';
  static final String _email = 'email';
  static final String _cardNumber = 'cardNumb';
  static final String _year = 'year';
  static final String _month = 'month';
  static final String _day = 'day';
  static final String _login = 'login';
  static final String dependent = 'dependent';

  static Future<bool> clearPreference(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString(key);
    return preferences.remove(key);
  }

  static Future<bool> clearAllPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString(_token);
    preferences.getString(_member);
    preferences.getString(_phone);
    preferences.getString(_email);
    preferences.getString(_cardNumber);
    preferences.getString(_year);
    preferences.getString(_month);
    preferences.getString(_day);
    preferences.getString(_login);
    preferences.getString(_plans);
    preferences.getString(dependent);
    return preferences.clear();
  }

  /// ------------------------------------------------------------
  /// Set Get Token Preference
  /// ------------------------------------------------------------

  static Future<bool> setToken(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(_token, "Bearer " + value);
  }

  static Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_token) ?? '';
  }

  /// ------------------------------------------------------------
  /// Set Get Member ADCPS Json Data Preference
  /// ------------------------------------------------------------
  static Future<bool> setDoRegistration(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(_member, value);
  }

  static Future<String> getDoRegistration() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_member) ?? '';
  }

  /// ------------------------------------------------------------
  /// Set Get Plan ADCPS Json Data Preference
  /// ------------------------------------------------------------
  static Future<bool> setPlans(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(_plans, value);
  }

  static Future<String> getPlans() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_plans) ?? '';
  }

  /// ------------------------------------------------------------
  /// Set Get Dependent Preference
  /// ------------------------------------------------------------
  static Future<bool> setDependent(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(dependent, value);
  }

  static Future<String> getDependent() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(dependent) ?? '';
  }

  /// ------------------------------------------------------------
  /// Set Get Login Json Data Preference
  /// ------------------------------------------------------------

  static Future<bool> setDoLogin(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(_login, value);
  }

  static Future<String> getDoLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_login) ?? '';
  }

  /// ------------------------------------------------------------
  /// Set Get Phone Preference
  /// ------------------------------------------------------------
  static Future<bool> setPhone(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(_phone, value);
  }

  static Future<String> getPhone() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_phone) ?? '';
  }

  /// ------------------------------------------------------------
  /// Set Get Email Preference
  /// ------------------------------------------------------------
  static Future<bool> setEmail(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(_email, value);
  }

  static Future<String> getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_email) ?? '';
  }

  /// ------------------------------------------------------------
  /// Set Get Card Number Preference
  /// ------------------------------------------------------------
  static Future<bool> setCardNumb(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(_cardNumber, value);
  }

  static Future<String> getCardNumb() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_cardNumber) ?? '';
  }

  /// ------------------------------------------------------------
  /// Set Get Birth Date Preference
  /// ------------------------------------------------------------
  static Future<bool> setYear(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(_year, value);
  }

  static Future<String> getYear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_year) ?? '999';
  }

  static Future<bool> setMonth(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(_month, value);
  }

  static Future<String> getMonth() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_month) ?? '999';
  }

  static Future<bool> setDay(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(_day, value);
  }

  static Future<String> getDay() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_day) ?? '999';
  }
}
