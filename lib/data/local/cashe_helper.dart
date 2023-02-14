import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static late SharedPreferences _sharedPreferences;
  static const String token = 'token';

  static init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    try {
      if (value is String)
        return await _sharedPreferences.setString(key, value);
      else if (value is int)
        return await _sharedPreferences.setInt(key, value);
      else if (value is bool)
        return await _sharedPreferences.setBool(key, value);
      else
        return _sharedPreferences.setDouble(key, value);
    } catch (error) {
      return false;
    }
  }

  static dynamic? getData({required String key}) {
    try {
      return _sharedPreferences.get(key);
    } catch (error) {
      if (_sharedPreferences.get(key) == null) return null;
    }
  }

  static Future<bool> removeData({required String key}) async {
    try {
      return await _sharedPreferences.remove(key);
    } catch (error) {
      return false;
    }
  }
}
