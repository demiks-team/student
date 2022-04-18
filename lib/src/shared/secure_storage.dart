import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../authentication/models/user_model.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _currentUsername = 'currentUser';

  static Future setCurrentUser(String userModelString) async {
    await _storage.write(key: _currentUsername, value: userModelString);
  }

  static Future<UserModel?> getCurrentUser() async {
    var getCurrentUser = await _storage.read(key: _currentUsername);
    if (getCurrentUser != null) {
      return UserModel.fromJson(json.decode(getCurrentUser));
    } else {
      return null;
    }
  }

  static void removeCurrentUser() async {
    await _storage.delete(key: _currentUsername);
  }
}
