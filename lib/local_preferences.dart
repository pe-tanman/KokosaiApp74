import 'package:shared_preferences/shared_preferences.dart';

class LocalPreferences {
  static void saveSetting<T>(String name, T value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch(T) {
      case int:
        await prefs.setInt(name, value as int);
        break;
      case String:
        await prefs.setString(name, value as String);
        break;
      case bool:
        await prefs.setBool(name, value as bool);
        break;
      case List<String>:
        await prefs.setStringList(name, value as List<String>);
        break;
      default:
        break;
    }
  }

  static Future<dynamic> readSetting<T>(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Object? result;
    switch(T) {
      case int:
        result = prefs.getInt(name);
        break;
      case String:
        result = prefs.getString(name);
        break;
      case bool:
        result = prefs.getBool(name);
        break;
      case List<String>:
        result = prefs.getStringList(name);
        break;
      default:
        break;
    }
    return result;
  }

  static void deleteSetting(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(name);
  }
}
