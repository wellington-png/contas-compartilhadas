import 'package:conta/screens/group_statistics/group_statistics.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:conta/config/injection.dart';

import 'package:conta/screens/group_success.dart';
import 'package:conta/screens/initial/initial_screen.dart';
import 'package:conta/screens/group_settings/group_settings.dart';
import 'package:conta/screens/group/group.dart';
import 'package:conta/screens/new_expense/new_expense.dart';
import 'package:conta/screens/forgot_password/forgot_password.dart';

import 'package:conta/screens/home/home.dart';
import 'package:conta/screens/home/bloc/user_bloc.dart';
import 'package:conta/screens/home/bloc/groups_bloc.dart';

import 'package:conta/screens/login/login.dart';
import 'package:conta/screens/login/bloc/login_bloc.dart';

import 'package:conta/screens/register/register.dart';
import 'package:conta/screens/register/bloc/register_bloc.dart';

class Routes {
  static const String initial = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String groupSuccess = '/group-success';
  static const String groupSettings = '/group-settings';
  static const String newExpense = '/new-expense';
  static const String group = '/group';
  static const String forgotPassword = '/forgot-password';
  static const String groupStatistics = '/group-statistics';

  static bool falsePredicate(Route<dynamic> route) => false;

  static String get initialRoute => groupStatistics;

  static Map<String, Widget Function(BuildContext)> get routes => {
        initial: (context) => const InitialScreen(),
        login: (context) => const LoginScreen(),
        register: (context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (context) => RegisterBloc(userService: getIt())),
              ],
              child: const RegisterScreen(),
            ),
        groupSuccess: (context) => const GroupSuccessScreen(),
        home: (context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => LoginBloc(authService: getIt()),
                ),
                BlocProvider(
                  create: (context) => UserBloc(userService: getIt())
                    ..add(const GetUserMeEvent()),
                ),
                BlocProvider(
                  create: (context) => GroupsBloc(groupService: getIt())
                    ..add(const GetGroupsEvent()),
                ),
              ],
              child: const HomeScreen(),
            ),
        groupSettings: (context) => const GroupSettings(),
        newExpense: (context) => const NewExpenseScreen(),
        group: (context) => const GroupScreen(),
        forgotPassword: (context) => const ForgotPasswordScreen(),
        groupStatistics: (context) => const GroupStatisticsScreen(),
      };
}
