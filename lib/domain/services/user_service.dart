// import 'package:conta/domain/models/entities/user_entity.dart';
import 'package:conta/config/exceptions.dart';
import 'package:conta/domain/models/entities/user_entity.dart';
import 'package:conta/domain/repositories/user/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserService {
  final UserRepository _userRepository;

  UserService(this._userRepository);

  Future<Either<ProjetoException,UserEntity>> register({
    required String username,
    required String password,
    required String email,
    required String name,
  }) async {
   return await _userRepository.register(
      username: username,
      password: password,
      email: email,
      name: name,
    );
  }
}
