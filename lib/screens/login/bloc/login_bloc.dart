import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import 'package:projeto_final_mobile/domain/models/entities/user_entity.dart';
import 'package:projeto_final_mobile/domain/services/auth_service.dart';

part 'login_events.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService authService;

  LoginBloc({required this.authService}) : super(const LoginState()) {
    on<PerformLoginEvent>(_onPerformLoginEvent);
    on<PerformLogoutEvent>(_onPerformLogoutEvent);
    on<GetLoginDataEvent>(_onGetLoginDataEvent);
  }

  Future<void> _onPerformLoginEvent(
      PerformLoginEvent event, Emitter<LoginState> emit) async {
    emit(const LoginState(status: LoginStatus.loading));
    try {
      await authService.login(username: event.username, password: event.password);
      emit(const LoginState(status: LoginStatus.success));
    } catch (e) {
      emit(const LoginState(status: LoginStatus.failure));
    }
  }

  Future<void> _onPerformLogoutEvent(
      PerformLogoutEvent event, Emitter<LoginState> emit) async {
    emit(const LoginState(status: LoginStatus.loading));
    try {
      await authService.logout();
      emit(const LoginState(status: LoginStatus.success, user: null));
    } catch (e) {
      emit(const LoginState(status: LoginStatus.failure, user: null));
    }
  }

  Future<void> _onGetLoginDataEvent(
    GetLoginDataEvent event,
    Emitter<LoginState> emit,
  ) async {
    final user = await authService.user;
    emit(LoginState(status: LoginStatus.initial, user: user));
  }
}
