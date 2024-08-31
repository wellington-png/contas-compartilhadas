import 'package:conta/domain/repositories/invite/invite_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:conta/config/exceptions.dart';
import 'package:conta/config/services/http_service.dart';
import 'package:conta/config/settings.dart';

class InviteRepositoryImpl implements InviteRepository {
  final HttpService _httpService;

  InviteRepositoryImpl({required HttpService httpService})
      : _httpService = httpService;

  @override
  Future<Either<ProjetoException, Map<String, dynamic>>> invite(
      {required String email, required int id}) async {
    try {
      final data = {
        "email": email,
      };

      Response response = await _httpService.post(
        path: API.groupInviteEmail(id),
        data: data,
        hasFile: false,
        isAuth: true,
      );
      return response.statusCode == 200
          ? Right(response.data)
          : Left(ProjetoException(message: "Erro ao convidar usuario"));
    } on DioException catch (e) {
      return Left(
        ProjetoException(message: e.response?.data['message'] ?? e.message),
      );
    }
  }
}
