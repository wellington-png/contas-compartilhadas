import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:projeto_final_mobile/config/injection.dart';
import 'package:projeto_final_mobile/config/theme.dart';
import 'package:projeto_final_mobile/config/routes/router.dart';

import 'package:projeto_final_mobile/screens/login/bloc/login_bloc.dart';

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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme,
        routes: Routes.routes,
        initialRoute: Routes.initialRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
