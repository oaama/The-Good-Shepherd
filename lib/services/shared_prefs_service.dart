import 'package:shared_preferences/shared_preferences.dart';

/// SharedPrefsService manages secure token storage.
class SharedPrefsService {
  static const String _tokenKey = 'jwt_token';

  /// Store JWT token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  /// Get JWT token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// Clear JWT token
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}
