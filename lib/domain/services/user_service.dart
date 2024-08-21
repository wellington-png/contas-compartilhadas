import 'package:conta/config/exceptions.dart';
import 'package:conta/domain/models/entities/user/user_entity.dart';
import 'package:conta/domain/models/entities/user/user_register_entity.dart';
import 'package:conta/domain/repositories/user/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserService {
  final UserRepository _userRepository;

  UserService(this._userRepository);

  Future<Either<ProjetoException, UserRegisterEntity>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    return await _userRepository.register(
      email: email,
      password: password,
      name: name,
    );
  }

  Future<Either<ProjetoException, UserEntity>> me() async {
    return await _userRepository.me();
  }
}
