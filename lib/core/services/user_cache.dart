import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:journal_cubit/domain/models/user.dart';

class UserCache {
  static const String _userKey = 'cached_user';
  final FlutterSecureStorage _storage;

  UserCache(this._storage);

  Future<void> saveUser(UserModel user) async {
    final userJson = json.encode(user.toJson());
    await _storage.write(key: _userKey, value: userJson);
  }

  Future<UserModel?> getUser() async {
    final userJson = await _storage.read(key: _userKey);
    if (userJson != null) {
      final userMap = json.decode(userJson);
      return UserModel.fromJson(userMap);
    }
    return null;
  }

  Future<void> clearUser() async {
    await _storage.delete(key: _userKey);
  }
}