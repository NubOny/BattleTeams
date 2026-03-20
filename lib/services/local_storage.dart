import 'package:shared_preferences/shared_preferences.dart';

class User {
  static const _keyIsNew = 'no';

  static Future<bool> isNew() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsNew) ?? false;
  }

  static Future<void> isNotNew() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsNew, true);
  }
}
