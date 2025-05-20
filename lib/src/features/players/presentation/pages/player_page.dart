import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luanda_sport_app/src/core/resources/app_images.dart';
import 'package:luanda_sport_app/src/features/communities/presentation/pages/community_page.dart';
import 'package:luanda_sport_app/src/features/followers/presentation/pages/follower_page.dart';
import 'package:tab_container/tab_container.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/app_icons.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> with TickerProviderStateMixin {
  late TabController _tabController;
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
          // Container(
          //   color: AppColors.primary,
          //   child: TabBar(
          //     controller: _tabController,
          //     isScrollable: true,
          //     tabAlignment: TabAlignment.center,
          //     unselectedLabelColor: AppColors.white.withOpacity(.6),
          //     labelColor: AppColors.white,
          //     indicatorColor: Colors.white,
          //     indicatorSize: TabBarIndicatorSize.tab,
          //     onTap: (value) {
          //       setState(() {
          //         selectedTabIndex = value;
          //       });
          //     },
          //     tabs: [
          //       Tab(
          //         icon: SvgPicture.asset(
          //           AppIcons.football,
          //           width: 20,
          //           color: selectedTabIndex == 0
          //               ? Colors.white
          //               : AppColors.white.withOpacity(.6),
          //         ),
          //         text: 'Perfil',
          //       ),
          //       Tab(
          //         icon: SvgPicture.asset(
          //           AppIcons.settings,
          //           color: selectedTabIndex == 1
          //               ? Colors.white
          //               : AppColors.white.withOpacity(.6),
          //         ),
          //         text: 'Configurações',
          //       ),
          //       Tab(
          //         icon: SvgPicture.asset(
          //           AppIcons.barsStaggered,
          //           color: selectedTabIndex == 1
          //               ? Colors.white
          //               : AppColors.white.withOpacity(.6),
          //         ),
          //         text: 'Estatísticas',
          //       ),
          //       Tab(
          //         icon: SvgPicture.asset(
          //           AppIcons.thumbsup,
          //           color: selectedTabIndex == 2
          //               ? Colors.white
          //               : AppColors.white.withOpacity(.6),
          //         ),
          //         text: 'Seguidores',
          //       ),
          //       Tab(
          //         icon: SvgPicture.asset(
          //           AppIcons.memo,
          //           color: selectedTabIndex == 3
          //               ? Colors.white
          //               : AppColors.white.withOpacity(.6),
          //         ),
          //         text: 'Contracto',
          //       ),
          //     ],
          //   ),
          // ),

          Expanded(
            child: Container(
              color: AppColors.white,
              child: TabContainer(
                controller: _tabController,
                tabEdge: TabEdge.right,
                tabsStart: 0.1,
                tabsEnd: 0.9,
                tabMaxLength: 100,
                borderRadius: BorderRadius.circular(10),
                tabBorderRadius: BorderRadius.circular(10),
                childPadding: const EdgeInsets.all(20.0),
                selectedTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
                unselectedTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 13.0,
                ),
                colors: [
                  Colors.red,
                  Colors.green,
                  Colors.blue,
                ],
                tabs: [
                  Text('Tab 1'),
                  Text('Tab 2'),
                  Text('Tab 3'),
                ],
                children: [
                  Container(
                    child: Text('Child 1'),
                  ),
                  Container(
                    child: Text('Child 2'),
                  ),
                  Container(
                    child: Text('Child 3'),
                  ),
                ],
              ),
            ),
          ),

          // Expanded(
          //   child: TabBarView(
          //     controller: _tabController,
          //     children: [
          //       _buildPlayerProfile(),
          //       CommunityPage(),
          //       FollowerPage(),
          //       Text("data"),
          //       Center(child: Text('Jogos')),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildPlayerProfile() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          SizedBox(
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

            // child: Column(
            //   children: [
            //     Expanded(
            //       child: Container(
            //         width: double.infinity,
            //         decoration: const BoxDecoration(
            //           borderRadius: BorderRadius.only(
            //             bottomRight: Radius.circular(100),
            //             topLeft: Radius.circular(10),
            //             topRight: Radius.circular(10),
            //           ),
            //           boxShadow: [
            //             BoxShadow(
            //               blurRadius: 2,
            //               color: Colors.black54,
            //               offset: Offset(0, 0),
            //             ),
            //           ],
            //         ),
            //         child: ClipRRect(
            //           borderRadius: const BorderRadius.only(
            //             bottomRight: Radius.circular(100),
            //             topLeft: Radius.circular(10),
            //             topRight: Radius.circular(10),
            //           ),
            //           child: Image.asset(
            //             AppImages.avatar,
            //             fit: BoxFit.cover,
            //             width: double.infinity,
            //             height: 200, // ou outro valor de altura que preferires
            //           ),
            //         ),
            //       ),
            //     ),
            //     Container(
            //       padding: EdgeInsets.all(10),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Text(
            //             "12",
            //             style: TextStyle(
            //                 fontSize: 50,
            //                 fontWeight: FontWeight.bold,
            //                 color: Colors.black,
            //                 shadows: [
            //                   Shadow(
            //                     blurRadius: 2,
            //                     color: Colors.black26,
            //                     offset: Offset(0, 2),
            //                   )
            //                 ]),
            //           ),
            //           SizedBox(width: 10),
            //           Text(
            //             "|",
            //             style: TextStyle(
            //               fontSize: 30,
            //               fontWeight: FontWeight.normal,
            //               color: Colors.black,
            //             ),
            //           ),
            //           SizedBox(width: 10),
            //           Text(
            //             "Bellingahm".toUpperCase(),
            //             style: TextStyle(
            //                 fontSize: 12,
            //                 fontWeight: FontWeight.bold,
            //                 color: Colors.black,
            //                 height: 1,
            //                 overflow: TextOverflow.ellipsis),
            //           ),
            //         ],
            //       ),
            //     )
            //   ],
            // ),
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
