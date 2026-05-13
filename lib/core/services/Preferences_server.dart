import 'package:shared_preferences/shared_preferences.dart';

class PreferencesServer {
  static final PreferencesServer _instance = PreferencesServer._internal();

  //! FACTORY CONSTATRCTOR
  factory PreferencesServer() => _instance;
  PreferencesServer._internal();

  late final SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

 Future<void> setString(String key, String value) async {
    await _sharedPreferences.setString(key, value);
  }
 
  String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  Future<void> remove(String key) async {
    await _sharedPreferences.remove(key);
  }

  Future<void> setBool(String key, bool value) async {
    await _sharedPreferences.setBool(key, value);
  }

  bool? getBool(String key) {
    return _sharedPreferences.getBool(key);
  }
}
