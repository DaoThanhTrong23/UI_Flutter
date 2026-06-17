import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String _tokenKey = 'auth_token';
  static const String _mssvKey = 'mssv';

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }
  
  static Future<void> saveMssv(String mssv) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_mssvKey, mssv);
  }

  static Future<String?> getMssv() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_mssvKey);
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
