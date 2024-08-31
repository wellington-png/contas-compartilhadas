import 'package:conta/domain/models/dto/user/user_dto.dart';
import 'package:conta/domain/models/dto/user/user_register_dto.dart';
import 'package:conta/domain/models/entities/user/user_entity.dart';
import 'package:conta/domain/models/entities/user/user_register_entity.dart';
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
  Future<Either<ProjetoException, UserRegisterEntity>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final data = {
        "email": email,
        "password": password,
        "name": name,
      };

      Response response = await _httpService.post(
        path: API.userCreate,
        data: data,
        hasFile: false,
        isAuth: false,
      );
      return response.statusCode == 201
          ? Right(UserRegisterDto.fromJson(response.data))
          : Left(ProjetoException(message: "Erro ao criar usuarios"));
    } on DioException catch (e) {
      return Left(
        ProjetoException(message: e.response?.data['message'] ?? e.message),
      );
    }
  }

  @override
  Future<Either<ProjetoException, UserEntity>> me() async {
    try {
      Response response = await _httpService.get(
        path: API.userMe,
        isAuth: true,
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

  @override
  Future<Either<ProjetoException, UserEntity>> update(UserEntity user) async {
    try {
      Response response = await _httpService.put(
        path: API.userUpdate(user.id),
        data: user.toJson(),
        isAuth: true,
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
