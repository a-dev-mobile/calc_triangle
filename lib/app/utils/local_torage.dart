import 'package:calc_triangle/app/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _info = 'local storage';

  Future<void> setItemString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);

    log.w('SET $_info > $key = $value');
  }

  Future<String> getItemString(String key, [String defaultValue = '']) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var val = prefs.getString(key);
    val ??= defaultValue;

    log.w('GET $_info > $key = $val');
    return val;
  }

  Future<void> setItemBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);

    log.w('SET $_info > $key = $value');
  }

  Future<double> getItemDouble(String key, [double defaultValue = 0.0]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var val = prefs.getDouble(key);
    val ??= defaultValue;

    log.w('GET $_info > $key = $val');
    return val;
  }

  Future<void> setItemDouble(String key, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);

    log.w('SET $_info > $key = $value');
  }

  Future<bool> getItemBool(String key, [bool defaultValue = false]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var val = prefs.getBool(key);
    val ??= defaultValue;

    log.w('GET $_info > $key = $val');
    return val;
  }

  Future<void> setItemInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);

    log.w('SET $_info > $key = $value');
  }

  Future<int> getItemInt(String key, [int defaultValue = 0]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var val = prefs.getInt(key);
    val ??= defaultValue;

    log.w('GET $_info > $key = $val');
    return val;
  }

  Future<bool> isNull(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var val = prefs.get(key);
    bool result;

    if (val == null) {
      result = true;
    } else {
      result = false;
    }
    log.w('GET  $_info | isNull $result | > $key = $val');
    return result;
  }

  Future<void> clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
