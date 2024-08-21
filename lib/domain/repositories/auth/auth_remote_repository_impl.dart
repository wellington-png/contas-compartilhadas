import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:conta/config/exceptions.dart';
import 'package:conta/config/services/http_service.dart';
import 'package:conta/config/settings.dart';

import 'package:conta/domain/repositories/auth/auth_remote_repository.dart';

class AuthRemoteRepositoryImpl implements AuthRemoteRepository {
  final HttpService _httpService;

  AuthRemoteRepositoryImpl({required HttpService httpService})
      : _httpService = httpService;

  @override
  Future<Either<ProjetoException, Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) async {
    try {
      final data = {
        "email": email,
        "password": password,
      };

      Response response = await _httpService.post(
        path: API.token,
        data: data,
        hasFile: false,
        isAuth: false,
      );
      return response.statusCode == 200
          ? Right(response.data)
          : Left(ProjetoException(message: "Erro no Login"));
    } catch (e) {
      return Left(
        ProjetoException(message: "Erro no login"),
      );
    }
  }
}
