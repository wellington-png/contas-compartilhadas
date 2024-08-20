import 'package:conta/domain/models/entities/login_entity.dart';

abstract class AuthLocalRepository {
  Future<void> saveToken(String token);
  Future<void> deleteToken();
  Future<String> getToken();
  Future<void> saveUser({required LoginEntity user});
  Future<void> deleteUser();
  Future<LoginEntity> getUser();
  Future<void> logout();
}
