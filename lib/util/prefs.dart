import 'package:shared_preferences/shared_preferences.dart';

// Prefs wraps around SharedPreferences to provide all methods as class methods.
// init() has to be called once to get instance ready.
class Prefs {
  static SharedPreferences _sp;

  static init() async {
    if (_sp == null) {
      _sp = await SharedPreferences.getInstance();
      print("prefs initialized");
    }
  }

  static bool hasKey(String key) {
    Set keys = getKeys();
    return keys.contains(key);
  }

  static Set<String> getKeys() {
    return _sp?.getKeys();
  }

  static get(String key) {
    return _sp?.get(key);
  }

  static getString(String key) {
    return _sp?.getString(key);
  }

  static Future<bool> setString(String key, String value) {
    return _sp?.setString(key, value);
  }

  static bool getBool(String key) {
    return _sp?.getBool(key);
  }

  static Future<bool> setBool(String key, bool value) {
    return _sp?.setBool(key, value);
  }

  static int getInt(String key) {
    return _sp?.getInt(key);
  }

  static Future<bool> setInt(String key, int value) {
    return _sp?.setInt(key, value);
  }

  static double getDouble(String key) {
    return _sp?.getDouble(key);
  }

  static Future<bool> setDouble(String key, double value) {
    return _sp?.setDouble(key, value);
  }

  static List<String> getStringList(String key) {
    return _sp?.getStringList(key);
  }

  static Future<bool> setStringList(String key, List<String> value) {
    return _sp?.setStringList(key, value);
  }

  static dynamic getDynamic(String key) {
    return _sp?.get(key);
  }

  static Future<bool> remove(String key) {
    return _sp?.remove(key);
  }

  static Future<bool> clear() {
    return _sp?.clear();
  }
}
