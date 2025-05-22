import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart'; // Para salvar no Android
import 'package:permission_handler/permission_handler.dart';

import '../../domain/entities/cartaz_entity.dart';

class MatchCartazView extends StatefulWidget {
  final CartazEntity cartaz;

  const MatchCartazView({super.key, required this.cartaz});

  @override
  State<MatchCartazView> createState() => _MatchCartazViewState();
}

class _MatchCartazViewState extends State<MatchCartazView> {
  final ScreenshotController _screenshotController = ScreenshotController();

  Future<void> _savePoster() async {
    final status = await Permission.storage.request();
    if (!status.isGranted) return;

    final Uint8List? image = await _screenshotController.capture();
    if (image != null) {
      final result = await ImageGallerySaver.saveImage(image,
          quality: 100, name: "cartaz_futurist");
      print('Salvo: $result');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Cartaz salvo na galeria.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Criar Cartaz")),
      floatingActionButton: FloatingActionButton(
        onPressed: _savePoster,
        child: const Icon(Icons.save),
      ),
      body: Center(
        child: Screenshot(
          controller: _screenshotController,
          child: PosterTemplate(
            cartaz: widget.cartaz,
          ),
        ),
      ),
    );
  }
}

class PosterTemplate extends StatelessWidget {
  final CartazEntity cartaz;

  const PosterTemplate({
    super.key,
    required this.cartaz,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: Stack(
        children: [],
      ),
    );
  }
}
