import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import '../../../../core/resources/app_images.dart';
import 'coach_profile_screen.dart';

class CoachScreen extends StatefulWidget {
  const CoachScreen({super.key});

  @override
  State<CoachScreen> createState() => _CoachScreenState();
}

class _CoachScreenState extends State<CoachScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.primary,
            child: TabBar(
              controller: _tabController,
              tabAlignment: TabAlignment.fill,
              unselectedLabelColor: AppColors.white.withOpacity(.6),
              labelColor: AppColors.white,
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              onTap: (value) {
                setState(() {
                  selectedTabIndex = value;
                });
              },
              tabs: [
                Tab(
                  icon: SvgPicture.asset(
                    AppIcons.membossMano,
                    width: 25,
                    color: selectedTabIndex == 0
                        ? Colors.white
                        : AppColors.white.withOpacity(.6),
                  ),
                  text: 'Perfil',
                ),
                Tab(
                  icon: SvgPicture.asset(
                    AppIcons.footballPlayer,
                    width: 25,
                    color: selectedTabIndex == 1
                        ? Colors.white
                        : AppColors.white.withOpacity(.6),
                  ),
                  text: 'Treinos',
                ),
                Tab(
                  icon: SvgPicture.asset(
                    AppIcons.medal,
                    width: 25,
                    color: selectedTabIndex == 1
                        ? Colors.white
                        : AppColors.white.withOpacity(.6),
                  ),
                  text: 'Conquistas',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                CoachProfileScreen(),
                Text("data"),
                Text("data"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerProfile() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            width: 250,
            height: 350,
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   borderRadius: BorderRadius.circular(10),
            //   boxShadow: [
            //     BoxShadow(
            //       blurRadius: 2,
            //       color: Colors.black26,
            //       offset: Offset(0, 2),
            //     ),
            //   ],
            // ),
            child: Stack(
              children: [
                Positioned.fill(
                  top: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(
                      AppImages.avatar,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Image.asset(
                  AppImages.playerCard,
                ),
                const Positioned(
                  top: 45,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      "MAURO CONDA",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // opcional, depende da imagem
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 5,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      "DOURADA FC",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // opcional, depende da imagem
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ListTile(
                  leading: SvgPicture.asset(
                    AppIcons.footballShoesShoe,
                    width: 26,
                  ),
                  title: Text(
                    'Pé',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  subtitle: Text(
                    "Direito",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    AppIcons.footballShoesShoe,
                    width: 26,
                  ),
                  title: Text(
                    'Posição',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  subtitle: Text(
                    "Atacante",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    AppIcons.footballShoesShoe,
                    width: 26,
                  ),
                  title: Text(
                    'Camisa',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  subtitle: Text(
                    "7",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    AppIcons.footballShoesShoe,
                    width: 26,
                  ),
                  title: Text(
                    'Equipe',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  subtitle: Text(
                    "Dourada FC",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
