import 'package:conta/screens/expenses/bloc/expense/expense_bloc.dart';
import 'package:conta/screens/group/bloc/group_details/group_details_bloc.dart';
import 'package:conta/screens/group/bloc/invite/invite_bloc.dart';
import 'package:conta/screens/navigation/navigation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:conta/config/injection.dart';

import 'package:conta/screens/group_success.dart';
import 'package:conta/screens/group/group.dart';
import 'package:conta/screens/new_expense/new_expense.dart';
import 'package:conta/screens/forgot_password/forgot_password.dart';

import 'package:conta/screens/home/bloc/groups/groups_bloc.dart';

import 'package:conta/screens/login/login.dart';
import 'package:conta/screens/login/bloc/login_bloc.dart';

import 'package:conta/screens/register/register.dart';
import 'package:conta/screens/register/bloc/register_bloc.dart';

class Routes {
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String groupSuccess = '/group-success';
  static const String groupSettings = '/group-settings';
  static const String newExpense = '/new-expense';
  static const String group = '/group';
  static const String forgotPassword = '/forgot-password';
  static const String groupStatistics = '/group-statistics';
  static const String expenses = '/expenses';
  static const String navigation = '/navigation';

  static bool falsePredicate(Route<dynamic> route) => false;

  static String get initialRoute => navigation;

  static Map<String, Widget Function(BuildContext)> get routes => {
        login: (context) => const LoginScreen(),
        register: (context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (context) => RegisterBloc(userService: getIt())),
              ],
              child: const RegisterScreen(),
            ),
        groupSuccess: (context) => const GroupSuccessScreen(),
        newExpense: (context) => const NewExpenseScreen(),
        forgotPassword: (context) => const ForgotPasswordScreen(),
        group: (context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => GroupDetailsBloc(groupService: getIt()),
                ),
                BlocProvider(
                    create: (context) => InviteBloc(inviteService: getIt())),
                BlocProvider(
                  create: (context) => ExpenseBloc(expenseService: getIt()),
                ),
              ],
              child: const GroupScreen(),
            ),
        navigation: (context) => MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) => LoginBloc(authService: getIt()),
              ),
              BlocProvider(
                create: (context) => GroupsBloc(groupService: getIt())
                  ..add(const GetGroupsEvent()),
              ),
              BlocProvider(
                create: (context) => GroupDetailsBloc(groupService: getIt()),
              ),
              BlocProvider(
                create: (context) => ExpenseBloc(expenseService: getIt()),
              ),
            ], child: const NavigationScreen())
      };
}
