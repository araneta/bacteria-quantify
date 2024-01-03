import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:bacteriaquantify/models/User.dart';

class UserPreferences {
  static SharedPreferences? _preferences;
  static const keyAPIURL = 'APIURL';
  static User user = User(fullName: "", username: "", token: "");
  static const _keyToken = 'token';
  static const _keyUser = 'user';
  static const _keyAvatarID = 'avatarFile';

  static List<int> noOfFruitsPerTree = []; //array of no of fruits
  static List<String> imgOfFruitsPerTree = []; //array of image id

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
    print("retrive userdd");
    await retrieveUser();
  }

  static Future<void> storeUser(User userx) async {
    String storeUser = jsonEncode(userx.toJson());
    await _preferences?.setString(_keyUser, storeUser);
    await retrieveUser();
  }

  static Future<void> retrieveUser() async {
    print("retrive user");
    String result = _preferences?.getString(_keyUser) ?? "";
    print(result);
    if (result != "") {
      Map<String, dynamic> decoded = jsonDecode(result);
      user = User.fromJson(decoded);
      user.isEmpty = false;
    }
    print("retrive user suck");
  }

  static User getUser() {
    return user;
  }

  static Future setAPIURL(String url) async =>
      await _preferences?.setString(keyAPIURL, url);

  static Future<String> getAPIURL() async {
    return _preferences?.getString(keyAPIURL) ?? "";
  }

  static Future setToken(String token) async =>
      await _preferences?.setString(_keyToken, token);

  static Future<String> getToken() async {
    return _preferences?.getString(_keyToken) ?? "";
  }

  static Future setAvatar(String id) async =>
      await _preferences?.setString(_keyAvatarID, id);

  static Future<String> getAvatar() async {
    return _preferences?.getString(_keyAvatarID) ?? "";
  }
}
