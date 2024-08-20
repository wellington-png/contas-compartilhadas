import 'package:conta/domain/models/dto/user_dto.dart';
import 'package:conta/domain/models/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:conta/config/exceptions.dart';
import 'package:conta/config/services/http_service.dart';
import 'package:conta/config/settings.dart';

import 'package:conta/domain/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final HttpService _httpService;

  UserRepositoryImpl({required HttpService httpService})
      : _httpService = httpService;

  @override
  Future<Either<ProjetoException, UserEntity>> register({
    required String username,
    required String password,
    required String email,
    required String name,
  }) async {
    try {
      final data = {
        "username": username,
        "password": password,
        "email": email,
        "name": name,
      };

      Response response = await _httpService.post(
        path: API.user['create']!,
        data: data,
        hasFile: false,
        isAuth: false,
      );
      return response.statusCode == 200
          ? Right(UserDto.fromJson(response.data))
          : Left(ProjetoException(message: "Erro ao criar usuarios"));
    } on DioException catch (e) {
      return Left(
        ProjetoException(message: e.response?.data['message'] ?? e.message),
      );
    }
  }
}
