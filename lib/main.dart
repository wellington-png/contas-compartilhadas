import 'package:flutter/material.dart';
import 'package:projeto_final_mobile/app.dart';
import 'package:projeto_final_mobile/config/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjection();
  runApp(const MyApp());
}

