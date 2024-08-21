import 'package:conta/domain/models/entities/login_entity.dart';
import 'package:conta/domain/repositories/auth/auth_local_repository.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalRepositoryImpl implements AuthLocalRepository {
  static const _tokenKey = "token";
  static const _emailKey = "email";
  static const _passwordKey = "password";

  SharedPreferences? _sharedPreferences;

  AuthLocalRepositoryImpl() {
    _initSharedPreferences();
  }

  Future<void> _validateSharedInstance() async {
    if (_sharedPreferences == null) {
      await _initSharedPreferences();
    }
  }

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> deleteToken() async {
    await _validateSharedInstance();
    await _sharedPreferences!.remove(_tokenKey);
  }

  @override
  Future<String> getToken() async {
    await _validateSharedInstance();
    return _sharedPreferences!.getString(_tokenKey) ?? "";
  }

  @override
  Future<void> saveToken(String token) async {
    await _validateSharedInstance();
    await _sharedPreferences!.setString(_tokenKey, token);
  }

  @override
  Future<void> logout() async {
    await _validateSharedInstance();
    await _sharedPreferences!.clear();
  }

  @override
  Future<void> deleteUser() async {
    await _validateSharedInstance();
    await _sharedPreferences!.remove(_emailKey);
    await _sharedPreferences!.remove(_passwordKey);
  }

  @override
  Future<LoginEntity> getUser() async {
    await _validateSharedInstance();
    final email = _sharedPreferences!.getString(_emailKey) ?? "";
    final password = _sharedPreferences!.getString(_passwordKey) ?? "";
    return LoginEntity(email: email, password: password);
  }

  @override
  Future<void> saveUser({required LoginEntity user}) async {
    await _validateSharedInstance();
    await _sharedPreferences!.setString(_emailKey, user.email);
    await _sharedPreferences!.setString(_passwordKey, user.password);
  }
}
