import 'package:flutter/material.dart';

import '../../core/strings/app_strings.dart';

class AppTheme {
  // static ThemeData get lightTheme => ThemeData(
  //       primaryColor: AppColors.primary,
  //       useMaterial3: true,
  //       scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
  //       fontFamily: AppStrings.fontFamily,
  //       brightness: Brightness.light,
  //       bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //         backgroundColor: Colors.white,
  //         elevation: 2.h,
  //       ),
  //       elevatedButtonTheme: ElevatedButtonThemeData(
  //         style: ElevatedButton.styleFrom(
  //           backgroundColor: AppColors.primary,
  //           foregroundColor: AppColors.lightWightColor,
  //         ),
  //       ),
  //     );

  // static ThemeData get darkTheme => ThemeData(
  //       primaryColor: AppColors.primary,
  //       useMaterial3: true,
  //       scaffoldBackgroundColor: Colors.black,
  //       fontFamily: AppStrings.fontFamily,
  //       brightness: Brightness.dark,
  //       bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //         backgroundColor: Colors.black,
  //         elevation: 2.h,
  //       ),
  //     );

  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF051DA0), // cor de foco e ícones
        scaffoldBackgroundColor: Colors.white,
        fontFamily: AppStrings.fontFamily,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Color(0xFF051DA0), width: 1.8),
          ),
          labelStyle: const TextStyle(color: Color(0xFF051DA0)),
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIconColor: const Color(0xFF051DA0),
        ),

        // Botão padrão (substituiremos a cor por gradiente manualmente)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: AppStrings.fontFamily,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),

            foregroundColor: Colors.white,
            backgroundColor: Colors.transparent, // gradiente manualmente
            shadowColor: Colors.transparent,
          ),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF051DA0), // cor de foco e ícones
        scaffoldBackgroundColor: Colors.white,

        // Estilo dos campos de texto (TextField / FormBuilderTextField)
        fontFamily: AppStrings.fontFamily,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Color(0xFF051DA0), width: 1.8),
          ),
          labelStyle: const TextStyle(color: Color(0xFF051DA0)),
          hintStyle: const TextStyle(
              color: Colors.grey, fontFamily: AppStrings.fontFamily),
          prefixIconColor: const Color(0xFF051DA0),
        ),

        // Botão padrão (substituiremos a cor por gradiente manualmente)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),

            foregroundColor: Colors.white,
            backgroundColor: Colors.transparent, // gradiente manualmente
            shadowColor: Colors.transparent,
          ),
        ),
      );
}
