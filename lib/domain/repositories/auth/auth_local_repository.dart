import 'package:projeto_final_mobile/domain/models/entities/user_entity.dart';

abstract class AuthLocalRepository {
  Future<void> saveToken(String token);
  Future<void> deleteToken();
  Future<String> getToken();
  Future<void> saveUser({required UserEntity user});
  Future<void> deleteUser();
  Future<UserEntity> getUser();
  Future<void> logout();
}
