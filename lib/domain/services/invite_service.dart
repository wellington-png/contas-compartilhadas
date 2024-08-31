import 'package:conta/domain/repositories/invite/invite_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:conta/config/exceptions.dart';

class InviteService {
  final InviteRepository _inviteRepository;

  InviteService(this._inviteRepository);

  Future<Either<ProjetoException, Map<String, dynamic>>> invite(
      {required String email, required int id}) async {
    return await _inviteRepository.invite(email: email, id: id);
  }
}
