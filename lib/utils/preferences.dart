import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Future<bool> saveBool(PrefKey prefKey, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(prefKey.key, value);
  }

  static Future<bool> getBool(PrefKey prefKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool(prefKey.key);
    if (status != null) {
      return status;
    } else {
      return false;
    }
  }

  static Future<bool> save(PrefKey prefKey, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(prefKey.key, value);
  }

  static Future<String> get(PrefKey prefKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(prefKey.key);
  }

  static Future<bool> clearPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(PrefKey.loginStatus.key, false);
    prefs.remove(PrefKey.token.key);
    prefs.remove(PrefKey.firstName.key);
    prefs.remove(PrefKey.lastName.key);
    prefs.remove(PrefKey.email.key);
    prefs.remove(PrefKey.mobileNumber.key);
    prefs.remove(PrefKey.avatar.key);
    prefs.remove(PrefKey.password.key);
    return true;
  }
}

enum PrefKey {
  loginStatus,
  firstLaunch,
  token,
  id,
  email,
  userId,
  password,
  firstName,
  lastName,
  mobileNumber,
  avatar
}

extension PrefKeysToString on PrefKey {
  String get key {
    return this.toString().split('.').last;
  }
}
