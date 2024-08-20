import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import 'package:conta/domain/models/entities/user_entity.dart';
import 'package:conta/domain/services/user_service.dart';

part "register_events.dart";
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserService userService;

  RegisterBloc({required this.userService}) : super(const RegisterState()) {
    on<PerformRegisterEvent>(_onPerformRegisterEvent);
  }

  Future<void> _onPerformRegisterEvent(
      PerformRegisterEvent event, Emitter<RegisterState> emit) async {
    emit(const RegisterState(status: RegisterStatus.loading));

    final result = await userService.register(
      username: event.username,
      password: event.password,
      email: event.email,
      name: event.name,
    );
    result.fold((l) {
      emit(
        RegisterState(
          status: RegisterStatus.failure,
          errorMessage: l.message,
        ),
      );
    }, (r) {
      emit(RegisterState(status: RegisterStatus.success, user: r));
    });
  }
}
