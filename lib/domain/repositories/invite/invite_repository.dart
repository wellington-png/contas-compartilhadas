import 'package:dartz/dartz.dart';
import 'package:conta/config/exceptions.dart';

abstract class InviteRepository {
  Future<Either<ProjetoException, Map<String, dynamic>>> invite(
      {required String email, required int id});
}
