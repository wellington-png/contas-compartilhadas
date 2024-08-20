import 'package:conta/domain/models/entities/login_entity.dart';
import 'package:conta/domain/repositories/auth/auth_local_repository.dart';
import 'package:conta/domain/repositories/auth/auth_remote_repository.dart';

class AuthService {
  final AuthLocalRepository _authLocalRepository;
  final AuthRemoteRepository _authRepository;

  AuthService(this._authLocalRepository, this._authRepository);

  Future<void> login({required String username, required String password}) async {
    final data = await _authRepository.login(
      username: username,
      password: password,
    );
    data.fold(
      (l) => throw l,
      (r) {
        _authLocalRepository.saveToken(r["access"]);
        _authLocalRepository.saveUser(
          user: LoginEntity(username: username, password: password),
        );
      },
    );
  }

  Future<void> logout() async {
    await _authLocalRepository.deleteToken();
  }

  Future<String> get token async => await _authLocalRepository.getToken();

  Future<LoginEntity> get user async => await _authLocalRepository.getUser();
}
