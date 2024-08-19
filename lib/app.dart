import 'package:flutter/material.dart';
import 'package:projeto_final_mobile/config/theme.dart';
import 'package:projeto_final_mobile/routes/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      routes: Routes.routes,
      initialRoute: Routes.initialRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}