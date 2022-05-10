import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  save(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String?> load(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString(key);
    return result;
  }
}

final shared_pref = Pref();
