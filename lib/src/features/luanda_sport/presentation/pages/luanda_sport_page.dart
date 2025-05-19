import 'dart:ui';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luanda_sport_app/src/config/themes/app_colors.dart';
import 'package:luanda_sport_app/src/core/resources/app_icons.dart';
import 'package:luanda_sport_app/src/core/resources/app_images.dart';

class LuandaSportPage extends StatefulWidget {
  final Map<dynamic, String?>? arguments;
  const LuandaSportPage({super.key, this.arguments});

  @override
  State<LuandaSportPage> createState() => _LuandaSportPageState();
}

class _LuandaSportPageState extends State<LuandaSportPage> {
  var _currentIndex = 0;
  late List<Widget> widgets;

  @override
  void initState() {
    super.initState();
    widgets = [
      const Text("GOME"),
      const Text("Live"),
      const Text("Profile"),
      const Text("Settings"),
    ];
  }

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
          // centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Adepto",
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
        // drawer: Drawer(
        //   child: Column(
        //     children: [
        //       Expanded(
        //         child: ListView(
        //           padding: EdgeInsets.zero,
        //           children: [
        //             Container(
        //               color: AppColors.primary,
        //               child: SafeArea(
        //                 child: ListTile(
        //                   contentPadding: const EdgeInsets.all(16),
        //                   title: const Text(
        //                     'Jesse Lingard',
        //                     style: TextStyle(
        //                       color: Colors.white,
        //                     ),
        //                   ),
        //                   subtitle: Text(
        //                     'Organizador',
        //                     style: TextStyle(
        //                       color: Colors.white.withOpacity(.5),
        //                     ),
        //                   ),
        //                   leading: const CircleAvatar(
        //                     backgroundImage: AssetImage(AppImages.avatar),
        //                   ),
        //                   trailing: SvgPicture.asset(
        //                     AppIcons.changePosition,
        //                     width: 26,
        //                     color: AppColors.lightWightColor,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             Container(
        //               padding: const EdgeInsets.all(16.0),
        //               child: const Text(
        //                 "Painel",
        //                 style: TextStyle(
        //                   fontSize: 16,
        //                   color: AppColors.primary,
        //                   fontWeight: FontWeight.w600,
        //                 ),
        //               ),
        //             ),
        //             ListTile(
        //               leading: SvgPicture.asset(
        //                 AppIcons.userPerson,
        //                 width: 25,
        //               ),
        //               title: Text('Meu Perfil'),
        //               onTap: () {},
        //             ),
        //             ListTile(
        //               leading: SvgPicture.asset(
        //                 AppIcons.trophyCup,
        //                 width: 25,
        //               ),
        //               title: Text('Campeonatos'),
        //               onTap: () {},
        //             ),
        //             ListTile(
        //               leading: SvgPicture.asset(
        //                 AppIcons.badgeMedal,
        //                 width: 25,
        //               ),
        //               title: Text('Equipas'),
        //               onTap: () {
        //                 // context.pushNamed("list-teams");
        //               },
        //             ),
        //             ListTile(
        //               leading: SvgPicture.asset(
        //                 AppIcons.note,
        //                 width: 25,
        //               ),
        //               title: Text('Inscrições'),
        //               onTap: () {
        //                 // Navigator.pop(context)
        //               },
        //             ),
        //             ListTile(
        //               leading: SvgPicture.asset(
        //                 AppIcons.footballBall,
        //                 width: 25,
        //               ),
        //               title: Text('Jogos'),
        //               onTap: () {
        //                 Navigator.pop(context);
        //               },
        //             ),
        //             ListTile(
        //               leading: SvgPicture.asset(
        //                 AppIcons.settingsGear,
        //                 width: 25,
        //               ),
        //               title: Text('Configurações'),
        //               onTap: () {
        //                 Navigator.pop(context);
        //               },
        //             ),
        //             ListTile(
        //               leading: SvgPicture.asset(
        //                 AppIcons.creditCard,
        //                 width: 25,
        //               ),
        //               title: Text('Planos/Subscrição'),
        //               onTap: () {
        //                 Navigator.pop(context);
        //               },
        //             ),
        //             ListTile(
        //               leading: Icon(Icons.logout),
        //               title: Text('Logout'),
        //               onTap: () {
        //                 Navigator.pop(context);
        //               },
        //             ),
        //           ],
        //         ),
        //       ),
        //       Text("Pacotes")
        //     ],
        //   ),
        // ),
        drawer: Drawer(
          backgroundColor: AppColors.lightWightColor,
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
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  title: const Text(
                    "LINGARD",
                    style: TextStyle(
                      // fontSize: 18,

                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Container(
                    height: 30,
                    child: DropDownTextField(
                      clearOption: false,
                      enableSearch: false,
                      readOnly: true,
                      initialValue: "player",
                      searchTextStyle: const TextStyle(color: Colors.red),
                      searchDecoration: const InputDecoration(
                        hintText: "enter your custom hint text here",
                        border: InputBorder.none,
                      ),
                      textFieldDecoration: const InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      dropDownItemCount: 6,
                      dropDownList: const [
                        DropDownValueModel(name: 'Adépto', value: "fan"),
                        DropDownValueModel(name: 'Jogador', value: "player"),
                        DropDownValueModel(
                            name: 'Organizador', value: "organizer"),
                        DropDownValueModel(name: 'Treinador', value: "coach"),
                        DropDownValueModel(name: 'Árbitro', value: "referee"),
                      ],
                      onChanged: (val) {},
                    ),
                  ),
                ),
                const DrawerItem(icon: Icons.calendar_today, label: 'Menu'),
                const DrawerItem(icon: Icons.email, label: 'Contato'),
                const DrawerItem(icon: Icons.help_outline, label: 'Como usar'),
                const DrawerItem(icon: Icons.star, label: 'Ir para Premium'),
                const DrawerItem(
                    icon: Icons.attach_money, label: 'Compartilhe para ...'),
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

        body: widgets[_currentIndex],
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
          shadow: BoxShadow(
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

  const DrawerItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        // color: Colors.white,
      ),
      title: Text(
        label,
        // style: const TextStyle(color: Colors.white),
      ),
      onTap: () {
        Navigator.pop(context);
        // Aqui você pode adicionar a navegação correspondente
      },
    );
  }
}
