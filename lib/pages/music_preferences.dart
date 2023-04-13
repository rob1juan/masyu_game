import 'package:shared_preferences/shared_preferences.dart';

class MusicPreferences {
  static const String _musicValueKey = 'musicValue';
  static const String _musicIsActivatedKey = 'musicIsActivated';
  static const String _soundValueKey = 'soundValue';
  static const String _soundIsActivatedKey = 'soundIsActivated';

  static Future<double> getMusicValue() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_musicValueKey) ?? 75.0;
  }

  static Future<void> setMusicValue(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_musicValueKey, value);
  }

  static Future<bool> getMusicIsActivated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_musicIsActivatedKey) ?? true;
  }

  static Future<void> setMusicIsActivated(bool isActivated) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_musicIsActivatedKey, isActivated);
  }

  static Future<double> getSoundValue() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_soundValueKey) ?? 75.0;
  }

  static Future<void> setSoundValue(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_soundValueKey, value);
  }

  static Future<bool> getSoundIsActivated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_soundIsActivatedKey) ?? true;
  }

  static Future<void> setSoundIsActivated(bool isActivated) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_soundIsActivatedKey, isActivated);
  }
}
