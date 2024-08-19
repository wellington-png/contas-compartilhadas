import 'package:flutter/material.dart';
import 'package:projeto_final_mobile/screens/group_success.dart';
import 'package:projeto_final_mobile/screens/login.dart';
import 'package:projeto_final_mobile/screens/register.dart';
import 'package:projeto_final_mobile/screens/home/home.dart';

class Routes {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String groupSuccess = '/group-success';
  static String get initialRoute => home;

  static Map<String, Widget Function(BuildContext)> get routes => {
    home: (context) => const HomeScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    groupSuccess: (context) => const GroupSuccessScreen(),
  };
}
