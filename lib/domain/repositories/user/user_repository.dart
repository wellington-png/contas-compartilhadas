import 'package:conta/domain/models/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:conta/config/exceptions.dart';

abstract class UserRepository {
  Future<Either<ProjetoException,UserEntity>> register(
      {required String username,
      required String password,
      required String email,
      required String name});
}
