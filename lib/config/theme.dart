import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBlue = Color(0xFF8FDAF7);
  static const Color primaryYellow = Color(0xFFFBE790);
  static const Color secondaryGreen = Color(0xFF50C878);
  static const Color compBrown = Color(0xFFCE735F);
  static const Color bgPeach = Color(0xFFFFF0DA);
  static const Color textDescription = Color(0xB8B8B8FF);
  static const Color textBigTitle = Color(0xFF5E5E5E);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF0000FF);
  static const Color primaryBleuDark = Color(0xFF25A2D3);
  static const Color textSecondary = Color(0xFF8F8F8F);
  static const Color bgLightGrey = Color.fromARGB(255, 238, 238, 238);
  static const Color compPink = Color(0xFFFDD2CD);
  static const Color blueTurquoise = Color(0xFF59ECDB);
}

ThemeData theme = ThemeData(
  colorScheme: const ColorScheme.light().copyWith(
    primary: AppColors.bgPeach,
  ),
  // elevatedButtonTheme: ElevatedButtonThemeData(
  //   style: ElevatedButton.styleFrom(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(30),
  //     ),
  //   ),
  // ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.bgLightGrey,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 16.0,
      horizontal: 16.0,
    ),
  ),
);
