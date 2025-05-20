import 'dart:ui';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:luanda_sport_app/src/config/themes/app_colors.dart';
import 'package:luanda_sport_app/src/core/resources/app_icons.dart';
import 'package:luanda_sport_app/src/core/resources/app_images.dart';
import '../../../home/presentantion/screens/home_page.dart';

class LuandaSportPage extends StatefulWidget {
  const LuandaSportPage({super.key});

  @override
  State<LuandaSportPage> createState() => _LuandaSportPageState();
}

class _LuandaSportPageState extends State<LuandaSportPage> {
  var _currentIndex = 0;

  Map<dynamic, String> arguments = {
    "pageParams": "player",
  };

  late List<Widget> widgets;
  final _controller = SingleValueDropDownController(
    data: DropDownValueModel(name: 'Jogador', value: "player"),
  );

  @override
  void initState() {
    super.initState();

    widgets = [
      const HomeScreen(),
      const Text("LIVE"),
      const Text("Profile"),
      const Text("Settings"),
    ];
  }

  final List<Map<String, String>> itemsMap = [
    {'name': 'Adepto', 'value': 'fan'},
    {'name': 'Jogador', 'value': 'player'},
    {'name': 'Organizador', 'value': 'organizer'},
    {'name': 'Treinador', 'value': 'coach'},
    {'name': 'Árbitro', 'value': 'referee'},
  ];

  String? selectedValue;

  List<String> iconList = [
    AppIcons.houseChimney,
    AppIcons.whistle,
    AppIcons.videoCameraAlt,
    AppIcons.settings2
  ];

  List<String> iconListBold = [
    AppIcons.houseChimneyBold,
    AppIcons.whistleBold,
    AppIcons.videoCameraAltBold,
    AppIcons.settings2
  ];

  String switchTitle() {
    switch (arguments["pageParams"]) {
      case "player":
        return "Jogador";
      case "fan":
        return "Adepto";
      case "referee":
        return "Árbitro";
      case "coach":
        return "Treinador";
      case "organizer":
        return "Organizador";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.bg2),
          opacity: .2,
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            switchTitle(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  AppIcons.bell,
                  color: AppColors.lightWightColor,
                ))
          ],
        ),
        drawer: Drawer(
          backgroundColor: const Color(0xFF1A1A1A),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  minVerticalPadding: 0,
                  titleAlignment: ListTileTitleAlignment.center,
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  title: const Text(
                    "LINGARD",
                    style: TextStyle(
                      // fontSize: 18,
                      color: AppColors.lightWightColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: SizedBox(
                    height: 30,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Selecionar função',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: itemsMap
                            .map((item) => DropdownMenuItem<String>(
                                  value: item['value'],
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item['name']!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                        selectedItemBuilder: (BuildContext context) {
                          return itemsMap.map((item) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                item['name']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors
                                      .white60, // <- Cor do item selecionado
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList();
                        },
                        value: selectedValue,
                        onChanged: (String? value) {
                          Get.back();
                          setState(() {
                            selectedValue = value;
                            arguments["pageParams"] = value!;
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          height: 40,
                          width: 200,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const DrawerItem(icon: Icons.person, label: 'Meu Perfil'),
                DrawerItem(
                    icon: Icons.article,
                    label: 'Feed',
                    onTap: () {
                      setState(() {
                        arguments["pageParams"] = "feed";
                      });
                    }),
                const DrawerItem(icon: Icons.sports_soccer, label: 'Jogos'),
                const DrawerItem(icon: Icons.people, label: 'Organizadores'),
                const DrawerItem(
                    icon: Icons.emoji_events, label: 'Campeonatos'),
                const DrawerItem(icon: Icons.groups, label: 'Equipes'),
                const DrawerItem(icon: Icons.how_to_reg, label: 'Inscrições'),
                const DrawerItem(icon: Icons.help_outline, label: 'Como usar'),
                const DrawerItem(icon: Icons.star, label: 'Ir para Premium'),
                const DrawerItem(icon: Icons.language, label: 'Alterar idioma'),
                const DrawerItem(
                    icon: Icons.feedback, label: 'Deixe um feedback'),
                const DrawerItem(icon: Icons.logout, label: 'Sair'),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0, bottom: 16.0),
                  child: Text(
                    "Versão 2.7.2",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: switch (_currentIndex) {
          0 => HomeScreen(arguments: arguments),
          1 => const Text("Live"),
          2 => const Text("Profile"),
          3 => const Text("Settings"),
          _ =>
            Container(), // Default case, you might want to handle this differently
        },
        //  widgets[_currentIndex],
        //  IndexedStack(
        //   index: _currentIndex,
        //   children: widgets),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          backgroundColor: Colors.white,
          itemCount: iconList.length,
          activeIndex: _currentIndex,
          gapLocation: GapLocation.none,
          notchSmoothness: NotchSmoothness.softEdge,
          leftCornerRadius: 0,
          rightCornerRadius: 0,
          height: 60,
          shadow: const BoxShadow(
            color: AppColors.shadow,
            blurRadius: 100,
          ),
          onTap: (index) => setState(() => _currentIndex = index),
          tabBuilder: (int index, bool isActive) {
            return IconButton(
              icon: SvgPicture.asset(
                (isActive) ? iconListBold[index] : iconList[index],
                width: 20,
                color: (isActive)
                    ? AppColors.primary
                    : Colors.black.withOpacity(.6),
              ),
              onPressed: () => setState(() => _currentIndex = index),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showBlurModal(context),
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildItem(String iconPath, String label, Function() onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: ListTile(
        leading: SvgPicture.asset(
          iconPath,
          width: 24,
          height: 24,
        ),
        title: Text(
          label,
          // style: const TextStyle(fontSize: 18),
        ),
        onTap: onTap,
      ),
    );
  }

  void _showBlurModal(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Material(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "MENU BÁSICO",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Divider(color: Colors.grey.shade300),
                    _buildItem(
                        AppIcons.competitionchampion, "Novo Campeonato", () {}),
                    _buildItem(AppIcons.footballJersey, "Nova Equipe", () {}),
                    _buildItem(AppIcons.userColor, "Novo Jogador", () {}),
                    _buildItem(
                        AppIcons.copyLink, "Participar em torneio", () {}),
                    _buildItem(AppIcons.copyLink, "Convidar Equipes", () {}),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showBlurModalChangeProfile(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Material(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Trocar Perfil",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Divider(color: Colors.grey.shade300),
                    _buildItem(AppIcons.competitionchampion, "Adepto", () {}),
                    _buildItem(AppIcons.footballJersey, "Organizador", () {}),
                    _buildItem(AppIcons.footballJersey, "Árbitro", () {}),
                    _buildItem(AppIcons.userColor, "Jogador", () {}),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function()? onTap;

  const DrawerItem(
      {super.key, required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.lightWightColor,
      ),
      title: Text(
        label,
        // style: const TextStyle(color: Colors.white),
        style: TextStyle(
          color: AppColors.lightWightColor,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap;
      },
    );
  }
}
