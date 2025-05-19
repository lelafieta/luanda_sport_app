import 'dart:io';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/app_images.dart';

class BuildEquipamentPage extends StatefulWidget {
  final Map<String, String> teamData;
  const BuildEquipamentPage({super.key, required this.teamData});

  @override
  State<BuildEquipamentPage> createState() => _BuildEquipamentPageState();
}

class _BuildEquipamentPageState extends State<BuildEquipamentPage> {
  final ValueNotifier<String?> selectedType = ValueNotifier<String?>("main");
  final ValueNotifier<Color> selectedMainShirtColor =
      ValueNotifier<Color>(Colors.black);
  final ValueNotifier<Color> selectedStyleShirtColor =
      ValueNotifier<Color>(Colors.white);

  final ValueNotifier<Color> selectedNumberColor =
      ValueNotifier<Color>(Colors.white);

  final ValueNotifier<File?> imageFile = ValueNotifier<File?>(null);
  final ImagePicker picker = ImagePicker();

  final Map<String, String> typeToImage = {
    'main': AppImages.typeEmpty,
    'type1': AppImages.type1,
    'type2': AppImages.type2,
    'type3': AppImages.type3,
    'type4': AppImages.type4,
    'type5': AppImages.type5,
    'type6': AppImages.type6,
    'type7': AppImages.type7,
    'type8': AppImages.type8,
    'type9': AppImages.type9,
    'type10': AppImages.type10,
    'type11': AppImages.type11,
    'type12': AppImages.type12,
    'type13': AppImages.type13,
    'type14': AppImages.type14,
    'type15': AppImages.type15,
    'type16': AppImages.type16,
    'type17': AppImages.type17,
  };

  // final List<Color> colorPalette = [
  //   Color(0xffFF5733),
  //   Color(0xff33FF57),
  //   Color(0xff3357FF),
  //   Color(0xffFF33A1),
  //   Color(0xffA133FF),
  //   Color(0xff33FFF5),
  //   Color(0xffF5FF33),
  //   Color(0xffFF8C33),
  //   Color(0xff8C33FF),
  //   Color(0xff33FF8C),
  //   Color(0xff000000),
  //   Color(0xff000000),
  // ];

  Color parseColorFromString(String colorString) {
    // Remove a parte "Color(" e ")"
    final hexString = colorString.replaceAll(RegExp(r'[^0-9a-fA-F]'), '');

    // Converte a string hexadecimal para inteiro
    return Color(int.parse('0xff$hexString'));
  }

  final int totalPartidas = 6;
  final ValueNotifier<int> partidaAtual = ValueNotifier<int>(3);
  Map<String, String> teamData = {};

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  @override
  void dispose() {
    imageFile.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    teamData = widget.teamData;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.bg2),
          opacity: .2,
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: const Text(
            "Dourada FC",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            // IconButton(
            //   onPressed: () {
            //     pickImage();
            //   },
            //   icon: SvgPicture.asset(AppIcons.security),
            // ),
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                Navigator.of(context).pop(teamData);
                // showModalBottomSheet(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return Column(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         ListTile(
                //           leading: Icon(Icons.add),
                //           title: Text('Adicionar Logotipo'),
                //           onTap: () {
                //             pickImage();
                //             Navigator.pop(context);
                //           },
                //         ),
                //         ListTile(
                //           leading: Icon(Icons.add_business),
                //           title: Text('Adicionar Patrocinador'),
                //           onTap: () {
                //             Navigator.pop(context);
                //             // Adicionar lógica para adicionar patrocinador
                //           },
                //         ),
                //       ],
                //     );
                //   },
                // );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 250,
                      height: 300,
                      child: Stack(
                        children: [
                          ValueListenableBuilder<Color>(
                            valueListenable: selectedMainShirtColor,
                            builder: (_, color, __) {
                              return Image.asset(
                                AppImages.mainTShirt,
                                color: parseColorFromString(
                                    teamData["equipament_main_color"]
                                        .toString()),
                              );
                            },
                          ),
                          ValueListenableBuilder(
                              valueListenable: selectedStyleShirtColor,
                              builder: (___, color, ____) {
                                return ValueListenableBuilder<String?>(
                                  valueListenable: selectedType,
                                  builder: (_, type, __) {
                                    if (type == null) return SizedBox.shrink();
                                    return Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      child: Image.asset(
                                        typeToImage[
                                            teamData['equipament_type']]!,
                                        color: color,
                                      ),
                                    );
                                  },
                                );
                              }),
                          ValueListenableBuilder(
                            valueListenable: selectedMainShirtColor,
                            builder: (_, colorsMain, __) {
                              return ValueListenableBuilder(
                                valueListenable: selectedStyleShirtColor,
                                builder: (___, colorStyle, ____) {
                                  return Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 0,
                                    child: Image.asset(
                                      AppImages.body,
                                      color: (parseColorFromString(teamData[
                                                      'equipament_main_color']!) ==
                                                  Colors.black ||
                                              parseColorFromString(teamData[
                                                      'equipament_main_color']!) ==
                                                  Colors.black)
                                          ? Colors.white12
                                          : Colors.black12,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          Positioned(
                            top: 45,
                            right: 65,
                            child: ValueListenableBuilder<File?>(
                              valueListenable: imageFile,
                              builder: (context, file, _) {
                                if (file == null) {
                                  return SizedBox.shrink();
                                } else {
                                  return Image.file(
                                    file,
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.contain,
                                  );
                                }
                              },
                            ),
                          ),
                          Positioned(
                            top: 80,
                            right: 50,
                            left: 50,
                            child: Container(
                              width: 30,
                              height: 25,
                              // child: Center(
                              //   child: Text(
                              //     "Sonangols",
                              //     style: TextStyle(fontWeight: FontWeight.bold0),
                              //   ),
                              // ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 250,
                      height: 300,
                      child: Stack(
                        children: [
                          ValueListenableBuilder<Color>(
                            valueListenable: selectedMainShirtColor,
                            builder: (_, color, __) {
                              return Image.asset(
                                AppImages.backPartTShirt,
                                color: parseColorFromString(
                                    teamData["equipament_main_color"]
                                        .toString()),
                              );
                            },
                          ),
                          ValueListenableBuilder(
                              valueListenable: selectedMainShirtColor,
                              builder: (___, color, ____) {
                                return ValueListenableBuilder<String?>(
                                  valueListenable: selectedType,
                                  builder: (_, type, __) {
                                    if (type == null) return SizedBox.shrink();
                                    return Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      child: Image.asset(
                                        AppImages.backPartTShirt,
                                        color: parseColorFromString(
                                            teamData["equipament_main_color"]
                                                .toString()),
                                      ),
                                    );
                                  },
                                );
                              }),
                          ValueListenableBuilder(
                            valueListenable: selectedMainShirtColor,
                            builder: (_, colorsMain, __) {
                              return ValueListenableBuilder(
                                valueListenable: selectedStyleShirtColor,
                                builder: (___, colorStyle, ____) {
                                  return Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      child: Image.asset(
                                        AppImages.bodyBack,
                                        color: (parseColorFromString(teamData[
                                                        'equipament_main_color']!) ==
                                                    Colors.black ||
                                                parseColorFromString(teamData[
                                                        'equipament_main_color']!) ==
                                                    Colors.black)
                                            ? Colors.white12
                                            : Colors.black12,
                                      ));
                                },
                              );
                            },
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 100,
                            child: ValueListenableBuilder(
                                valueListenable: selectedNumberColor,
                                builder: (_, color, __) {
                                  return Container(
                                    child: Center(
                                      child: Text(
                                        "7",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 75,
                                          color: parseColorFromString(teamData[
                                                  "equipament_number_color"]
                                              .toString()),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Wrap(
                          spacing: 8,
                          children: typeToImage.entries.map((entry) {
                            final imagePath = entry.value;
                            return InkWell(
                              onTap: () {
                                selectedType.value = entry.key;

                                setState(() {
                                  teamData['equipament_type'] = entry.key;
                                });
                              },
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    top: 0,
                                    child: Image.asset(
                                      AppImages.mainTShirt,
                                      color: Colors.black12,
                                    ),
                                  ),
                                  ValueListenableBuilder(
                                      valueListenable: selectedType,
                                      builder: (_, selected, __) {
                                        return (selected == entry.key)
                                            ? Positioned(
                                                right: 0,
                                                bottom: 0,
                                                child: Container(
                                                  child: Icon(
                                                    Icons.check_circle,
                                                    color: Colors.blue.shade900,
                                                    size: 15,
                                                  ),
                                                ),
                                              )
                                            : const SizedBox.shrink();
                                      }),
                                  Image.asset(
                                    imagePath,
                                    width: 50,
                                    height: 50,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        child: Container(
                          child: ListView(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            children: [
                              ValueListenableBuilder(
                                valueListenable: selectedMainShirtColor,
                                builder: (_, color, __) {
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: ColorPicker(
                                          color: color,
                                          onColorChanged: (newColor) {
                                            selectedMainShirtColor.value =
                                                newColor;
                                            print(newColor.toString());
                                            setState(() {
                                              teamData[
                                                      'equipament_main_color'] =
                                                  newColor.toString();
                                            });
                                          },
                                          width: 44,
                                          height: 44,
                                          borderRadius: 22,
                                          heading: Text(
                                            'Cor Principal',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                          subheading: Text(
                                            'Escolha o tom',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(height: 16),
                              ValueListenableBuilder(
                                valueListenable: selectedStyleShirtColor,
                                builder: (_, color, __) {
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: ColorPicker(
                                          color: color,
                                          onColorChanged: (newColor) {
                                            selectedStyleShirtColor.value =
                                                newColor;
                                            setState(() {
                                              teamData[
                                                      'equipament_type_color'] =
                                                  newColor.toString();
                                            });
                                          },
                                          width: 44,
                                          height: 44,
                                          borderRadius: 22,
                                          heading: Text(
                                            'Cor do Estilo',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                          subheading: Text(
                                            'Escolha o tom',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(height: 16),
                              ValueListenableBuilder(
                                valueListenable: selectedStyleShirtColor,
                                builder: (_, color, __) {
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: ColorPicker(
                                          color: color,
                                          onColorChanged: (newColor) {
                                            selectedNumberColor.value =
                                                newColor;
                                            setState(() {
                                              teamData[
                                                      'equipament_number_color'] =
                                                  newColor.toString();
                                            });
                                          },
                                          width: 44,
                                          height: 44,
                                          borderRadius: 22,
                                          heading: Text(
                                            'Cor do Número',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                          subheading: Text(
                                            'Escolha o tom',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
