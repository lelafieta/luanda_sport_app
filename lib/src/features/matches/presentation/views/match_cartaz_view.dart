import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart'; // Para salvar no Android
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/resources/app_images.dart';
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
    // Verifica se já tem permissão
    final status = await Permission.storage.status;

    if (!status.isGranted) {
      final newStatus = await Permission.storage.request();

      if (!newStatus.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Permissão de armazenamento negada.")),
        );
        return;
      }
    }

    final Uint8List? image = await _screenshotController.capture();
    if (image != null) {
      final result = await ImageGallerySaver.saveImage(
        image,
        quality: 100,
        name: "cartaz_futurist",
      );

      print('Salvo: $result');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Cartaz salvo na galeria.")),
      );
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
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.cartaz2), // sua moldura
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 170,
            left: 70,
            child: Container(
              width: 80,
              height: 80,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: cartaz.imagemEquipeCasa,
                  fit: BoxFit.contain,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 170,
            right: 70,
            child: Container(
              width: 80,
              height: 80,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: cartaz.imagemEquipeVisitante,
                  fit: BoxFit.contain,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 130,
            right: 50,
            child: Container(
              width: 120,
              height: 30,
              // color: Colors.black12,
              child: FittedBox(
                child: Center(
                  child: Text(
                    cartaz.equipeVisitante.toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 130,
            left: 50,
            child: Container(
              width: 120,
              height: 30,
              // color: Colors.black12,
              child: FittedBox(
                child: Center(
                  child: Text(
                    cartaz.equipeCasa.toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 90,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Text(
                    "20 de Julho de 2025",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Text(
                    "08:00",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Text(
                    "${cartaz.local}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
