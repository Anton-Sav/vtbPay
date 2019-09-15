import 'package:shared_preferences/shared_preferences.dart';

class WalletAddress {
  static const _key = 'wallet_address';

  static Future<bool> exists() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_key);
  }

  static Future<String> load() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }

  static Future<void> save(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(_key, value);
  }

  static Future<void> delete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(_key, null);
  }
}
