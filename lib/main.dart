import 'package:flutter/material.dart';
import 'package:conta/app.dart';
import 'package:conta/config/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjection();
  runApp(const MyApp());
}
