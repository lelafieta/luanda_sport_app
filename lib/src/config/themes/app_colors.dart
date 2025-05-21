import 'package:flutter/material.dart';

// class AppColors {
//   static const Color primary = Color(0xFF238C98); //7e39ec
//   static const Color primaryVariant = Color(0xFF3700B3);
//   static const Color scaffoldBackgroundColor = Colors.white;
//   static const Color secondary = Color(0xFF03DAC6);
//   static const Color lightWightColor = Color(0xFFF5F5F5);
//   static const Color secondaryVariant = Color(0xFF018786);
//   static const Color background = Color(0xFFFFFFFF);
//   static const Color surface = Color(0xFFFFFFFF);
//   static const Color error = Color(0xFFB00020);
//   static const Color onPrimary = Color(0xFFFFFFFF);
//   static const Color onSecondary = Color(0xFFFFFFFF);
//   static const Color onBackground = Color(0xFF1C1B1F);
//   static const Color onSurface = Color(0xFF1C1B1F);
//   static const Color onError = Color(0xFFFFFFFF);
//   static const Color shadow = Color(0x33000000);
//   static const Color divider = Color(0xFFE0E0E0);
//   static const Color transparent = Color(0x00000000);
//   static const Color white = Color(0xFFFFFFFF);
//   static const Color black = Color(0xFF000000);
//   static const Color color = Color.fromARGB(255, 70, 70, 70);
// }

class AppColors {
  // Azul primário (Pantone Blue)
  static const Color white = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF051DA0);
  static const Color black = Color(0xFF000000);
  static const Color lightWightColor = Color(0xFFF5F5F5);
  static const Color shadow = Color(0x33000000);

  static const blue100 = Color(0xFF051DA0);
  static const blue80 = Color(0xFF374AB3);
  static const blue60 = Color(0xFF6977C6);
  static const blue40 = Color(0xFF9BA5D9);
  static const blue20 = Color(0xFFCDD2EC);
  static const blue10 = Color(0xFFE6E9F6);
  static const blue5 = Color(0xFFF2F3FA);

  // Neutros
  static const neutral900 = Color(0xFF0F1928);
  static const neutral800 = Color(0xFF27303E);
  static const neutral700 = Color(0xFF3F4753);
  static const neutral600 = Color(0xFF6F757E);
  static const neutral500 = Color(0xFF9FA3A9);
  static const neutral300 = Color(0xFFCFD1D4);
  static const neutral200 = Color(0xFFE7E8E9);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF051DA0), Color(0xFF1530e7)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
