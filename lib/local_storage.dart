import 'package:flutter/foundation.dart';
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

class MyInvoices {
  static const _keyNames = 'my_invoices';
  static const _keyIds = 'my_invoices_';

  static Future<void> addName({@required String name}) async {
    final prefs = await SharedPreferences.getInstance();
    final names = prefs.getStringList(_keyNames) ?? [];
    if (!names.contains(name)) {
      names.add(name);
      await prefs.setStringList(_keyNames, names);
    }
  }

  static Future<void> addId({@required String name, @required String id}) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _keyIds + name;
    final ids = prefs.getStringList(key) ?? [];
    if (!ids.contains(id)) {
      ids.add(id);
      await prefs.setStringList(key, ids);
    }
  }

  static Future<Map<String, List<String>>> getAll() async {
    final map = <String, List<String>>{};
    final prefs = await SharedPreferences.getInstance();
    final names = prefs.getStringList(_keyNames) ?? [];
    for (final name in names) {
      map[name] = prefs.getStringList(_keyIds + name);
    }
    // map['test1'] = ['3'];
    // map['test2'] = ['3', '3'];
    return map;
  }
}
