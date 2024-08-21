import 'package:conta/domain/models/entities/user/user_entity.dart';
import 'package:conta/domain/models/entities/user/user_register_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:conta/config/exceptions.dart';

abstract class UserRepository {
  Future<Either<ProjetoException, UserRegisterEntity>> register({
    required String email,
    required String password,
    required String name,
  });
  Future<Either<ProjetoException, UserEntity>> me();
}
