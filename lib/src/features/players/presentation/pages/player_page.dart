import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../app/app_entity.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import '../../../../core/resources/app_images.dart';
import '../../../achievements/presentation/views/achievements_view.dart';
import '../cubit/get_my_player_data/get_my_player_data_cubit.dart';
import '../widgets/my_profile_widget.dart';
import '../widgets/player_stats_widget.dart';
import 'player_feed_page.dart';

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
    context.read<GetMyPlayerDataCubit>().fetchPlayerData(AppEntity.uId!);
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
              tabAlignment: TabAlignment.center,
              isScrollable: true,
              unselectedLabelColor: AppColors.white.withOpacity(.6),
              labelColor: AppColors.white,
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              onTap: (value) {
                setState(() {
                  selectedTabIndex = value;
                });
              },
              tabs: const [
                Tab(text: 'Perfil'),
                Tab(text: 'Feed'),
                Tab(text: 'Estatísticas'),
                Tab(text: 'Conquistas'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                BlocBuilder<GetMyPlayerDataCubit, GetMyPlayerDataState>(
                  builder: (context, state) {
                    if (state is GetMyPlayerDataLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetMyPlayerDataFailure) {
                      return const Center(
                        child: Text("Erro ao carregar dados do jogador"),
                      );
                    } else if (state is GetMyPlayerDataLoaded) {
                      if (state.player == null) {
                        return const Center(
                          child: Text("Nenhum jogador encontrado"),
                        );
                      }
                      return MyProfileWidget(
                        player: state.player!,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const PlayerFeedPage(),
                BlocBuilder<GetMyPlayerDataCubit, GetMyPlayerDataState>(
                  builder: (context, state) {
                    if (state is GetMyPlayerDataLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetMyPlayerDataFailure) {
                      return const Center(
                        child: Text("Erro ao carregar estatísticas"),
                      );
                    } else if (state is GetMyPlayerDataLoaded) {
                      if (state.player == null) {
                        return const Center(
                          child: Text("Nenhuma estatística encontrada"),
                        );
                      }
                      return PlayerStatsWidget(
                        player: state.player!,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                AchievementsView(),
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
