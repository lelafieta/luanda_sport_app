// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:luanda_sport_app/src/core/strings/app_strings.dart';

// import 'app_colors.dart';

// class AppTheme {
//   AppTheme._();

//   static ThemeData get lightTheme => ThemeData(
//         useMaterial3: true,
//         scaffoldBackgroundColor: Colors.transparent,
//         primaryColor: AppColors.primary,
//         fontFamily: AppStrings.fontFamily,
//         cardColor: AppColors.white,
//         colorScheme: const ColorScheme(
//           brightness: Brightness.light,
//           primary: AppColors.primary,
//           onPrimary: AppColors.onPrimary,
//           secondary: AppColors.white,
//           onSecondary: AppColors.onSecondary,
//           error: AppColors.error,
//           onError: AppColors.onError,
//           surface: AppColors.surface,
//           onSurface: AppColors.onSurface,
//           background: AppColors.background,
//           onBackground: AppColors.onBackground,
//         ),
//         appBarTheme: const AppBarTheme(
//           backgroundColor: AppColors.background,
//           toolbarHeight: 50,
//           scrolledUnderElevation: 5,
//           centerTitle: true,
//           systemOverlayStyle: SystemUiOverlayStyle(),
//           iconTheme: IconThemeData(
//             color: AppColors.white,
//           ),
//           titleTextStyle: TextStyle(
//             fontFamily: AppStrings.fontFamily,
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//             color: AppColors.white,
//           ),
//         ),
//         floatingActionButtonTheme: const FloatingActionButtonThemeData(
//           backgroundColor: AppColors.primary,
//         ),
//         bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//           backgroundColor: AppColors.primary,
//           selectedItemColor: Colors.white,
//         ),
//         inputDecorationTheme: InputDecorationTheme(
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           hintStyle: const TextStyle(
//               fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey),
//           border: const OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: const BorderRadius.all(Radius.circular(10)),
//             borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
//           ),
//           focusedBorder: const OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//             borderSide: BorderSide(color: Colors.grey),
//           ),
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ButtonStyle(
//             backgroundColor: const MaterialStatePropertyAll(AppColors.primary),
//             foregroundColor: const MaterialStatePropertyAll(AppColors.white),
//             textStyle: const MaterialStatePropertyAll(
//               TextStyle(
//                 fontFamily: AppStrings.fontFamily,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//               RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(100),
//               ),
//             ),
//             padding: const MaterialStatePropertyAll(
//               EdgeInsets.symmetric(vertical: 15),
//             ),
//             minimumSize: const MaterialStatePropertyAll(
//               Size.fromHeight(50), // altura fixa
//             ),
//           ),
//         ),
//         outlinedButtonTheme: OutlinedButtonThemeData(
//           style: ButtonStyle(
//             side: const MaterialStatePropertyAll(
//               BorderSide(
//                 color: AppColors.primary,
//                 width: 2,
//               ),
//             ),
//             backgroundColor:
//                 MaterialStatePropertyAll(AppColors.primary.withOpacity(.2)),
//             foregroundColor: const MaterialStatePropertyAll(AppColors.primary),
//             textStyle: const MaterialStatePropertyAll(
//               TextStyle(
//                 fontFamily: AppStrings.fontFamily,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//               RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(100),
//               ),
//             ),
//             padding: const MaterialStatePropertyAll(
//               EdgeInsets.symmetric(vertical: 15),
//             ),
//           ),
//         ),
//         iconButtonTheme: const IconButtonThemeData(
//           style: ButtonStyle(
//             padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
//           ),
//         ),
//         textTheme: const TextTheme(
//           bodyLarge: TextStyle(
//             // color: Color(0xFF777777),
//             color: Colors.black,
//             fontFamily: AppStrings.fontFamily,
//           ),
//           bodyMedium: TextStyle(
//             color: Color(0xFF777777),
//             fontFamily: AppStrings.fontFamily,
//           ),
//           bodySmall: TextStyle(
//             color: Color(0xFF777777),
//             fontFamily: AppStrings.fontFamily,
//           ),
//           headlineMedium: TextStyle(
//             color: Color(0xFF777777),
//             fontFamily: AppStrings.fontFamily,
//           ),
//           headlineSmall: TextStyle(
//             color: Color(0xFF777777),
//             fontFamily: AppStrings.fontFamily,
//           ),
//           // titleMedium: TextStyle(
//           //   color: Colors.black,
//           //   fontFamily: AppStrings.fontFamily,
//           //   fontSize: 14,
//           //   fontWeight: FontWeight.w500,
//           // ),
//           titleLarge: TextStyle(
//             color: AppColors.primary,
//             fontFamily: AppStrings.fontFamily,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       );
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luanda_sport_app/src/config/themes/app_colors.dart';
import 'package:luanda_sport_app/src/core/strings/app_strings.dart';

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
          prefixIconColor: Color(0xFF051DA0),
        ),

        // Botão padrão (substituiremos a cor por gradiente manualmente)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
          prefixIconColor: Color(0xFF051DA0),
        ),

        // Botão padrão (substituiremos a cor por gradiente manualmente)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            foregroundColor: Colors.white,
            backgroundColor: Colors.transparent, // gradiente manualmente
            shadowColor: Colors.transparent,
          ),
        ),
      );
}
