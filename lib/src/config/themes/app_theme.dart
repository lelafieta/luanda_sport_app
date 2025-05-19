import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luanda_sport_app/src/core/strings/app_strings.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.transparent,
        primaryColor: AppColors.primary,
        fontFamily: AppStrings.fontFamily,
        cardColor: AppColors.white,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primary,
          onPrimary: AppColors.onPrimary,
          secondary: AppColors.white,
          onSecondary: AppColors.onSecondary,
          error: AppColors.error,
          onError: AppColors.onError,
          surface: AppColors.surface,
          onSurface: AppColors.onSurface,
          background: AppColors.background,
          onBackground: AppColors.onBackground,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          toolbarHeight: 50,
          scrolledUnderElevation: 5,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle(),
          iconTheme: IconThemeData(
            color: AppColors.white,
          ),
          titleTextStyle: TextStyle(
            fontFamily: AppStrings.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.primary,
          selectedItemColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(AppColors.primary),
            foregroundColor: const MaterialStatePropertyAll(AppColors.white),
            textStyle: const MaterialStatePropertyAll(
              TextStyle(
                fontFamily: AppStrings.fontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(vertical: 15),
            ),
            minimumSize: const MaterialStatePropertyAll(
              Size.fromHeight(50), // altura fixa
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            side: const MaterialStatePropertyAll(
              BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
            backgroundColor:
                MaterialStatePropertyAll(AppColors.primary.withOpacity(.2)),
            foregroundColor: const MaterialStatePropertyAll(AppColors.primary),
            textStyle: const MaterialStatePropertyAll(
              TextStyle(
                fontFamily: AppStrings.fontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        ),
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            // color: Color(0xFF777777),
            color: Colors.black,
            fontFamily: AppStrings.fontFamily,
          ),
          bodyMedium: TextStyle(
            color: Color(0xFF777777),
            fontFamily: AppStrings.fontFamily,
          ),
          bodySmall: TextStyle(
            color: Color(0xFF777777),
            fontFamily: AppStrings.fontFamily,
          ),
          headlineMedium: TextStyle(
            color: Color(0xFF777777),
            fontFamily: AppStrings.fontFamily,
          ),
          headlineSmall: TextStyle(
            color: Color(0xFF777777),
            fontFamily: AppStrings.fontFamily,
          ),
          // titleMedium: TextStyle(
          //   color: Colors.black,
          //   fontFamily: AppStrings.fontFamily,
          //   fontSize: 14,
          //   fontWeight: FontWeight.w500,
          // ),
          titleLarge: TextStyle(
            color: AppColors.primary,
            fontFamily: AppStrings.fontFamily,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
