import 'package:projeto_final_mobile/domain/models/entities/user_entity.dart';
import 'package:projeto_final_mobile/domain/repositories/auth/auth_local_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalRepositoryImpl implements AuthLocalRepository {
  static const _tokenKey = "token";
  static const _usernameKey = "username";
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
    await _sharedPreferences!.remove(_usernameKey);
    await _sharedPreferences!.remove(_passwordKey);
  }

  @override
  Future<UserEntity> getUser() async {
    await _validateSharedInstance();
    final username = _sharedPreferences!.getString(_usernameKey) ?? "";
    final password = _sharedPreferences!.getString(_passwordKey) ?? "";
    return UserEntity(username: username, password: password);
  }

  @override
  Future<void> saveUser({required UserEntity user}) async {
    await _validateSharedInstance();
    await _sharedPreferences!.setString(_usernameKey, user.username);
    await _sharedPreferences!.setString(_passwordKey, user.password);
  }
}
