import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart'; // Para salvar no Android
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/resources/app_images.dart'; // Para permissões

class PosterExportPage extends StatefulWidget {
  const PosterExportPage({super.key});

  @override
  State<PosterExportPage> createState() => _PosterExportPageState();
}

class _PosterExportPageState extends State<PosterExportPage> {
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
      appBar: AppBar(title: Text("Criar Cartaz")),
      floatingActionButton: FloatingActionButton(
        onPressed: _savePoster,
        child: Icon(Icons.save),
      ),
      body: Center(
        child: Screenshot(
          controller: _screenshotController,
          child: PosterTemplate(
            contentImage: AssetImage(AppImages.dourada), // Exemplo
          ),
        ),
      ),
    );
  }
}

class PosterTemplate extends StatelessWidget {
  final ImageProvider contentImage;

  const PosterTemplate({
    Key? key,
    required this.contentImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 4, // Ex: 600x800 - formato de cartaz vertical
      child: Stack(
        children: [
          // Fundo do cartaz
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.cartaz1), // sua moldura
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Imagem do usuário dentro do cartaz
          Positioned(
            top: 210,
            left: 30,
            child: Container(
              height: 50,
              width: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image(
                  width: 40,
                  height: 40,
                  image: contentImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 220,
            left: 102,
            child: Container(
              // color: Colors.red,
              child: Text(
                "VS",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: 210,
            left: 150,
            child: Container(
              height: 50,
              width: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image(
                  width: 40,
                  height: 40,
                  image: contentImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Texto personalizado no final
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Feito com Futurist Platforms",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 5,
                      offset: Offset(2, 2),
                      color: Colors.black45,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
