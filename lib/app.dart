import 'package:conta/screens/home/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:conta/config/injection.dart';
import 'package:conta/config/theme.dart';
import 'package:conta/config/routes/router.dart';

import 'package:flutter_localizations/flutter_localizations.dart';


import 'package:conta/screens/login/bloc/login_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              LoginBloc(authService: getIt())..add(const GetLoginDataEvent()),
        ),
        BlocProvider(
          create: (context) =>
              UserBloc(userService: getIt())..add(const GetUserMeEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme,
        routes: Routes.routes,
        initialRoute: Routes.initialRoute,
        supportedLocales: const <Locale>[
          Locale('en', 'US'),
          Locale('pt', 'BR'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: const Locale('pt', 'BR'),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
