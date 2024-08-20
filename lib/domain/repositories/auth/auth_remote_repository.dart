import 'package:dartz/dartz.dart';
import 'package:conta/config/exceptions.dart';

abstract class AuthRemoteRepository {
  Future<Either<ProjetoException, Map<String, dynamic>>> login(
      {required String username, required String password});
}
