import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:projeto_final_mobile/config/exceptions.dart';
import 'package:projeto_final_mobile/config/services/http_service.dart';
import 'package:projeto_final_mobile/config/settings.dart';
import 'package:projeto_final_mobile/domain/repositories/auth/auth_remote_repository.dart';

class AuthRemoteRepositoryImpl implements AuthRemoteRepository {
  final HttpService _httpService;

  AuthRemoteRepositoryImpl({required HttpService httpService})
      : _httpService = httpService;

  @override
  Future<Either<ProjetoException, Map<String, dynamic>>> login({
    required String username,
    required String password,
  }) async {
    try {
      final data = {
        "username": username,
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
