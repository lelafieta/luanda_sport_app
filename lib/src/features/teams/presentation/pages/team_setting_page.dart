import 'dart:io';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import '../../../../core/resources/app_images.dart';
import 'build_equipament_page.dart';

class TeamSettingPage extends StatefulWidget {
  const TeamSettingPage({super.key});

  @override
  State<TeamSettingPage> createState() => _TeamSettingPageState();
}

class _TeamSettingPageState extends State<TeamSettingPage> {
  final ValueNotifier<String?> selectedType = ValueNotifier<String?>("main");
  final ValueNotifier<Color> selectedMainShirtColor =
      ValueNotifier<Color>(Colors.red);
  final ValueNotifier<Color> selectedStyleShirtColor =
      ValueNotifier<Color>(Colors.blue);

  final ValueNotifier<Color> selectedNumberColor =
      ValueNotifier<Color>(Colors.blue);

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

  final List<Color> colors = [
    Colors.white,
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.grey,
    Colors.amber, // para representar dourado
    Colors.blueGrey, // um tom mais prateado/cinza
  ];

  late TabController _tabController;
  final int totalPartidas = 6;
  final ValueNotifier<int> partidaAtual = ValueNotifier<int>(3);

  final String backgroundUrl =
      'https://scontent.flad5-1.fna.fbcdn.net/v/t39.30808-6/481972096_1207928134015658_4427683262273356979_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=cc71e4&_nc_ohc=zV_8X74IuyoQ7kNvwFNQ4ob&_nc_oc=AdkuSLXzaRPCkaG4Rk49w94sTBmd8Fhxnz2QazxYg2iIpuENHNFuCjDX0VJn-DIsKu_tpPTIOY-QLCN9VE_o77Vv&_nc_zt=23&_nc_ht=scontent.flad5-1.fna&_nc_gid=6g5SEc_mHR1ryf38jcOikw&oh=00_AfHwiN08xuDHuwgUxbjxBUvvfo7y6kwFlL6d0wj-XXV6kA&oe=68047308';
  final String profileUrl =
      'https://scontent.flad5-1.fna.fbcdn.net/v/t39.30808-6/468946321_1143394810468991_6731165110528390324_n.jpg?_nc_cat=1&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=wSrOeJxvDDEQ7kNvwEbvT6L&_nc_oc=AdlTqHYlCPFGfrAGQlDwBDoWGWHzOtYBQvPLz5DFEahZRV2c0WoBBuSIrcQrBKYO_91fpJuk6Y9c1v6oU_Uldije&_nc_zt=23&_nc_ht=scontent.flad5-1.fna&_nc_gid=bu1cwd0CKmhmqZJFsKvxIg&oh=00_AfHS3wRkCA00310Cb6BF1t2f-b46KjsWZzhIrcgxTejGig&oe=68048141';
  final String team1Logo =
      'https://scontent.flad5-1.fna.fbcdn.net/v/t39.30808-1/449761244_1062646795218211_4139834764378388664_n.jpg?stp=c196.196.1199.1199a_dst-jpg_s200x200_tt6&_nc_cat=1&ccb=1-7&_nc_sid=2d3e12&_nc_ohc=2PIv9d0zbT4Q7kNvwFrDdyl&_nc_oc=Adnbea-uBG6-Yjz-swaIok52lxeGLlxbFYlST90cK4dm1KdQveMu-MleJfCBBy4zbgL6PbCyY77uA-Jx-87CXmsf&_nc_zt=24&_nc_ht=scontent.flad5-1.fna&_nc_gid=b_6-6aTZFayQsgqhCcyxhQ&oh=00_AfE78XoqOuYLsaL3vLfGnPlltyuw8ZA_dK-vkLTcnXYkEA&oe=68047744';
  final String team2Logo =
      'https://scontent.flad5-1.fna.fbcdn.net/v/t39.30808-1/273144602_10152602977424953_1955203260619408476_n.jpg?stp=dst-jpg_s200x200_tt6&_nc_cat=1&ccb=1-7&_nc_sid=2d3e12&_nc_ohc=q-W_7Ofx0GIQ7kNvwGEJVrU&_nc_oc=Adnh-RBMtZE6Kr9ubdATmRiKH6NAEiVO92HwxQXcJXb10vyt6hqv1nhkO14Pimi4X05KqocWeD2Q83HP7vsW3Xw6&_nc_zt=24&_nc_ht=scontent.flad5-1.fna&_nc_gid=tINtmFSQ5O2qx6UrzJ1Xjg&oh=00_AfFWaHkb26Gz6qnHdeiku917wrHIZY8eRqAgYFACd31o-Q&oe=68047B4B';
  Future<void> pickImage() async {
    print("object");
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OutlinedButton(
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.link),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Se conectar à um torneio"),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Configurações da Equipe",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: "Dourada FC",
                decoration: const InputDecoration(
                  label: Text("Nome da Equipe"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: "Gerente",
                decoration: const InputDecoration(
                  label: Text("Helder Supremo"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "EQUIPAMENTO / LOGOTIPO",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.to(BuildEquipamentPage(
                                teamData: {},
                              ));
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: Image.asset(
                                            AppImages.mainTShirt,
                                            width: 20,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Image.asset(
                                              AppImages.backPartTShirt),
                                        ),
                                      ),

                                      // const Text("Equipamento")
                                    ],
                                  ),
                                  const Text("Equipamentos")
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                width: 1,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: SvgPicture.asset(
                                          width: 55,
                                          AppIcons.security,
                                        ),
                                      ),
                                    ),

                                    // const Text("Equipamento")
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("Logotipo")
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: "11 de abr. de 2013",
                decoration: const InputDecoration(
                  label: Text("Data de Criação"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
