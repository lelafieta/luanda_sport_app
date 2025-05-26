import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:luanda_sport_app/src/features/matches/domain/entities/cartaz_entity.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import '../../../../core/resources/app_images.dart';
import '../../../matches/presentation/views/match_cartaz_view.dart';
import 'print_image.dart';

class Jogador {
  final String nome;
  final String posicao;

  Jogador(this.nome, this.posicao);
}

class MyApp extends StatelessWidget {
  final List<Jogador> convocados = [
    Jogador('João Silva', 'Goleiro'),
    Jogador('Pedro Santos', 'Defensor'),
    Jogador('Lucas Alves', 'Defensor'),
    Jogador('Ricardo Pereira', 'Meio-Campo'),
    Jogador('Marcos Vinícius', 'Atacante'),
    Jogador('Carlos Eduardo', 'Atacante'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Convocatória Futebol',
      home: ConvocatoryScreen(convocados: convocados),
    );
  }
}

class ConvocatoryScreen extends StatefulWidget {
  final List<Jogador> convocados;
  ConvocatoryScreen({required this.convocados});

  @override
  State<ConvocatoryScreen> createState() => _ConvocatoryScreenState();
}

class _ConvocatoryScreenState extends State<ConvocatoryScreen> {
  final GlobalKey _globalKey = GlobalKey();

  Map<String, List<Jogador>> groupByPosition(List<Jogador> list) {
    Map<String, List<Jogador>> map = {};
    for (var j in list) {
      map.putIfAbsent(j.posicao, () => []);
      map[j.posicao]!.add(j);
    }
    return map;
  }

  Future<void> _previewImage() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) return;

      Uint8List pngBytes = byteData.buffer.asUint8List();

      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PreviewScreen(imageBytes: pngBytes),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erro: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final grouped = groupByPosition(widget.convocados);

    return Scaffold(
      appBar: AppBar(
        title: Text('Convocatória'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            RepaintBoundary(
              key: _globalKey,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        AppImages.cartaz2), // sua imagem de background
                    fit: BoxFit.contain, // para cobrir todo o container
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                          child: Text(
                        'LOGO',
                        style: TextStyle(
                            color: Colors.green[900],
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Convocados para o jogo\nVS Time Rival\n23 de Maio, 2025',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    ...grouped.entries.map((entry) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key,
                            style: TextStyle(
                                color: Colors.yellowAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          ...entry.value.map(
                            (j) => Text(
                              j.nome,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      );
                    }).toList()
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              icon: Icon(Icons.image),
              label: Text('Gerar e ver preview'),
              onPressed: _previewImage,
            ),
          ],
        ),
      ),
    );
  }
}

class PreviewScreen extends StatelessWidget {
  final Uint8List imageBytes;
  const PreviewScreen({Key? key, required this.imageBytes}) : super(key: key);

  Future<void> _saveImage(BuildContext context) async {
    if (!(await Permission.storage.status.isGranted)) {
      await Permission.storage.request();
    }

    final result = await ImageGallerySaver.saveImage(imageBytes,
        quality: 100,
        name: "convocatoria_preview_${DateTime.now().millisecondsSinceEpoch}");

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            result['isSuccess'] ? 'Imagem salva!' : 'Erro ao salvar imagem.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview da imagem'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Expanded(child: Image.memory(imageBytes)),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton.icon(
                icon: Icon(Icons.download),
                label: Text('Salvar na galeria'),
                onPressed: () => _saveImage(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Fechar preview'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
