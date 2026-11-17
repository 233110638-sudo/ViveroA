import 'package:flutter/material.dart';

class AppColors {
  static const Color primario = Color(0xFF1565C0);
  static const Color primarioClaro = Color.fromARGB(255, 22, 85, 157);
  static const Color acento = Color.fromARGB(255, 245, 245, 245);
  static const Color textoPrincipal = Color(0xFFFFFFFF);
  static const Color textoSecundario = Color(0xFFE8F0F6);
  static const Color textoSobreClaro = Color(0xFF1F2937);
  static const Color fondo = Color(0xFF4D6F8E);
}

class AppSpacing {
  static const double xs = 4;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
}

ThemeData buildViveroTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.fondo,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primario,
      primary: AppColors.primario,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primario,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.textoPrincipal,
      ),
      bodyLarge: TextStyle(fontSize: 18, color: AppColors.textoSecundario),
      bodyMedium: TextStyle(fontSize: 16, color: AppColors.textoSecundario),
      bodySmall: TextStyle(fontSize: 14, color: AppColors.textoSecundario),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primario,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
