import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luanda_sport_app/src/features/communities/presentation/pages/community_page.dart';
import 'package:luanda_sport_app/src/features/followers/presentation/pages/follower_page.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import 'adept_home_page.dart';

class AdeptPage extends StatefulWidget {
  const AdeptPage({super.key});

  @override
  State<AdeptPage> createState() => _AdeptPageState();
}

class _AdeptPageState extends State<AdeptPage> with TickerProviderStateMixin {
  late TabController _tabController;
  int selectedTabIndex = 0;

  // final List<Tab> myTabs = const [
  //   Tab(icon: Icon(Icons.home), text: 'Início'),
  //   Tab(icon: Icon(Icons.lightbulb), text: 'Palpites'),
  //   Tab(icon: Icon(Icons.calendar_today), text: 'Jogos'),
  //   Tab(icon: Icon(Icons.forum), text: 'Fórum'),
  //   Tab(icon: Icon(Icons.emoji_events), text: 'Conquistas'),
  //   Tab(icon: Icon(Icons.leaderboard), text: 'Rankings'),
  // ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
              isScrollable: true,
              tabAlignment: TabAlignment.center,
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
                    AppIcons.football,
                    width: 20,
                    color: selectedTabIndex == 0
                        ? Colors.white
                        : AppColors.white.withOpacity(.6),
                  ),
                  text: 'Jogos',
                ),
                Tab(
                  icon: SvgPicture.asset(
                    AppIcons.populationGlobe,
                    color: selectedTabIndex == 1
                        ? Colors.white
                        : AppColors.white.withOpacity(.6),
                  ),
                  text: 'Comunidades',
                ),
                Tab(
                  icon: SvgPicture.asset(
                    AppIcons.thumbsup,
                    color: selectedTabIndex == 2
                        ? Colors.white
                        : AppColors.white.withOpacity(.6),
                  ),
                  text: 'A seguir',
                ),
                Tab(
                  icon: SvgPicture.asset(
                    AppIcons.newspaper,
                    color: selectedTabIndex == 3
                        ? Colors.white
                        : AppColors.white.withOpacity(.6),
                  ),
                  text: 'Notícias',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                AdeptHomePage(), // Feed de notícias
                CommunityPage(), // Dados pessoais e histórico
                FollowerPage(), // Meus palpites
                Center(child: Text('Jogos')), // Jogos próximos
                Center(child: Text('Fórum')), // Comunidade
              ],
            ),
          ),
        ],
      ),
    );
  }
}
