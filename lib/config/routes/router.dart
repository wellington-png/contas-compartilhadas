import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:projeto_final_mobile/config/injection.dart';

import 'package:projeto_final_mobile/screens/group_success.dart';
import 'package:projeto_final_mobile/screens/login/login.dart';
import 'package:projeto_final_mobile/screens/register.dart';
import 'package:projeto_final_mobile/screens/home/home.dart';
import 'package:projeto_final_mobile/screens/initial/initial_screen.dart';

import 'package:projeto_final_mobile/screens/login/bloc/login_bloc.dart';

class Routes {
  static const String initial = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String groupSuccess = '/group-success';

  static bool falsePredicate(Route<dynamic> route) => false;

  static String get initialRoute => initial;

  static Map<String, Widget Function(BuildContext)> get routes => {
        initial: (context) => const InitialScreen(),
        login: (context) => const LoginScreen(),
        register: (context) => const RegisterScreen(),
        groupSuccess: (context) => const GroupSuccessScreen(),
        home: (context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (context) => LoginBloc(authService: getIt())),
              ],
              child: const HomeScreen(),
            ),
      };
}
