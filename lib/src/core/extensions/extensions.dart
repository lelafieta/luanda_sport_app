import 'package:flutter/material.dart';

extension TransparentRouteExtension on BuildContext {
  Future<T?> pushTransparentRoute<T>(Widget page) {
    return Navigator.of(this).push<T>(
      PageRouteBuilder(
        opaque: false, // torna a rota transparente
        barrierColor: Colors.black.withOpacity(0.7), // fundo semi-transparente
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }
}
