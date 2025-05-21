import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:luanda_sport_app/src/core/resources/app_images.dart';
import 'package:luanda_sport_app/src/core/strings/app_strings.dart';
import 'package:luanda_sport_app/src/features/players/domain/entities/player_entity.dart';
import 'package:luanda_sport_app/src/features/players/presentation/cubit/fetch_players_team_cubit/fetch_players_team_cubit.dart';
import 'package:luanda_sport_app/src/features/teams/presentation/cubit/action_team_squad_cubit/action_team_squad_cubit.dart';
import 'package:luanda_sport_app/src/features/teams/presentation/cubit/get_one_team_cubit/get_one_team_cubit.dart';
import 'package:luanda_sport_app/src/features/teams/presentation/cubit/get_team_equipament_cubit/get_team_equipament_cubit.dart';
import 'package:luanda_sport_app/src/features/teams/presentation/cubit/starting_lineup_player_cubit/starting_lineup_player_cubit.dart';
import 'package:luanda_sport_app/src/features/teams/presentation/pages/build_equipament_page.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import '../../../../core/utils/app_date_utils.dart';
import '../../../../core/utils/equipment_widget_utils.dart';
import '../../../home/presentantion/screens/home_page.dart';
import '../../../home/presentantion/old_home';
import '../../../squads/presentation/cubit/squad_cubit.dart';
import '../../../trophies/presentation/cubit/fetch_trophies_team_cubit/fetch_trophies_team_cubit.dart';
import '../../data/models/team_model.dart';
import '../../domain/entities/starting_lineup_player_entity.dart';
import '../../domain/entities/team_entity.dart';

class TeamDetailsPage extends StatefulWidget {
  final TeamEntity team;
  const TeamDetailsPage({super.key, required this.team});

  @override
  State<TeamDetailsPage> createState() => _TeamDetailsPageState();
}

class _TeamDetailsPageState extends State<TeamDetailsPage>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<String?> selectedType =
      ValueNotifier<String?>("treeBarras");
  final ValueNotifier<Color> selectedMainShirtColor =
      ValueNotifier<Color>(Colors.red);
  final ValueNotifier<Color> selectedStyleShirtColor =
      ValueNotifier<Color>(Colors.blue);

  // final Map<String, String> typeToImage = {
  //   'treeBarras': AppImages.treeBarras,
  //   'leftOneLongVerticalBar': AppImages.leftOneLongVerticalBar,
  // };

  final List<Color> colors = [
    Colors.yellow,
    Colors.black,
    Colors.brown,
    Colors.white,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];
  String selectedCount = '11x11';
  String selectedFormation = '4-4-2';

  ValueNotifier<PlayerEntity?> theSelectedPlayer =
      ValueNotifier<PlayerEntity?>(null);
  ValueNotifier<int?> plantelIndex = ValueNotifier<int?>(null);

  final List<String> playerCounts =
      List.generate(11, (i) => '${i + 1}x${i + 1}');
  final List<String> formations = [
    '4-4-2',
    '4-3-3',
    '3-5-2',
    '4-5-1',
    '5-4-1',
    '5-3-2',
    '3-4-3',
  ];
  List<int> get fieldFormation {
    return selectedFormation.split('-').map(int.parse).toList();
  }

  List<Widget> _buildFormationWithLimit(
      List<int> formationLines, TeamEntity team) {
    int totalPlayers = int.tryParse(selectedCount.split('x').first) ?? 11;
    int playersUsed = 0;
    int globalPositionIndex = 0;
    List<Widget> lines = [];

    for (int count in formationLines) {
      if (playersUsed >= totalPlayers) break;

      int remaining = totalPlayers - playersUsed;
      int playersInLine = count <= remaining ? count : remaining;

      lines.add(
        _buildLine(playersInLine, team, globalPositionIndex),
      );
      playersUsed += playersInLine;
      globalPositionIndex += playersInLine;
    }

    // Add goalkeeper (posição final)
    if (totalPlayers > 1) {
      lines.add(
        _buildLine(1, team, globalPositionIndex, isGoalkeeper: true),
      );
    }

    return lines;
  }

  Widget _buildBottomSheet(
      BuildContext context,
      ScrollController scrollController,
      double bottomSheetOffset,
      PlayerEntity? selectedPlayer) {
    return Material(
      child: Column(
        children: [
          (selectedPlayer != null)
              ? Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.2),
                    border:
                        Border.all(width: 2, color: Colors.red.withOpacity(.6)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(child: PlayerTile(player: selectedPlayer)),
                      IconButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.red)),
                        onPressed: () {
                          BlocProvider.of<StartingLineupPlayerCubit>(context)
                              .removeTeamPlayerStartingLineup(selectedPlayer);
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          // Expanded(
          //   child: Container(
          //     child: SizedBox(
          //       child: GridView.builder(
          //         itemCount: 10,
          //         controller: scrollController,
          //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: 3, // 3 por linha
          //           mainAxisSpacing: 12,
          //           crossAxisSpacing: 12,
          //           childAspectRatio: 1,
          //         ),
          //         itemBuilder: (context, index) {
          //           // final player = players[index];
          //           return Text("data");
          //           // return GestureDetector(
          //           //   onTap: () {
          //           //     // Aqui você pode tratar a seleção
          //           //     Navigator.pop(context);
          //           //     ScaffoldMessenger.of(context).showSnackBar(
          //           //       SnackBar(content: Text('$player selecionado')),
          //           //     );
          //           //   },
          //           //   child: Container(
          //           //     decoration: BoxDecoration(
          //           //       color: Colors.blueAccent,
          //           //       shape: BoxShape.circle,
          //           //     ),
          //           //     child: Center(
          //           //       child: Text(
          //           //         player.split(' ').last, // Mostra só o número
          //           //         style: const TextStyle(
          //           //           fontSize: 16,
          //           //           color: Colors.white,
          //           //         ),
          //           //       ),
          //           //     ),
          //           //   ),
          //           // );
          //         },
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(
            child: BlocBuilder<FetchPlayersTeamCubit, FetchPlayersTeamState>(
              builder: (context, state) {
                if (state is FetchPlayersTeamLoading) {
                  return Container(
                    height: 300,
                    padding: const EdgeInsets.only(bottom: 50),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.green),
                      image: const DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage(
                          AppImages.campoReto,
                        ),
                      ),
                    ),
                    // child: Column(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: _buildFormationWithLimit(
                    //       fieldFormation.reversed.toList(), team),
                    // ),
                  );
                } else if (state is FetchPlayersTeamFailure) {
                  return Center(child: Text("error"));
                } else if (state is FetchPlayersTeamLoaded) {
                  final players = state.players;
                  return Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      children: [
                        Expanded(
                          child: _showPlayersToPlantel(
                              players, scrollController, selectedPlayer),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ValueListenableBuilder(
                              valueListenable: plantelIndex,
                              builder: (context, __, _) {
                                return ElevatedButton(
                                  child: Text("Selecionar"),
                                  onPressed: () {
                                    BlocProvider.of<
                                            StartingLineupPlayerCubit>(context)
                                        .createStartingLineupPlayer(
                                            StartingLineupPlayersEntity(
                                                id: const Uuid().v4(),
                                                teamId: theSelectedPlayer
                                                    .value!.teamId!,
                                                playerId: theSelectedPlayer
                                                    .value!.id!,
                                                positionIndex: __!));
                                    theSelectedPlayer.value = null;
                                    plantelIndex.value = null;
                                    Navigator.pop(context);
                                  },
                                );
                              }),
                        )
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLine(int playerCount, TeamEntity team, int startIndex,
      {bool isGoalkeeper = false, PlayerEntity? selectedPlayer}) {
    return BlocBuilder<StartingLineupPlayerCubit, StartingLineupPlayerState>(
      builder: (context, state) {
        if (state is SquadLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is StartingLineupPlayerFailure) {
          return Center(child: Text(state.error));
        } else if (state is StartingLineupPlayerLoaded) {
          final startingLineupPlayers = state.startingLineupPlayers;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(playerCount, (i) {
              final index = startIndex + i;

              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      plantelIndex.value = index;
                      showFlexibleBottomSheet(
                        minHeight: 0,
                        initHeight: 0.5,
                        maxHeight: 1,
                        context: context,
                        builder:
                            (context, scrollController, bottomSheetOffset) =>
                                _buildBottomSheet(
                                    context,
                                    scrollController,
                                    bottomSheetOffset,
                                    (startingLineupPlayers.any((element) =>
                                            element.positionIndex == index))
                                        ? startingLineupPlayers
                                            .firstWhere((element) =>
                                                element.positionIndex == index)
                                            .player!
                                        : null),
                        anchors: [0, 0.5, 1],
                        isSafeArea: true,
                      );
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      child: EquipmentWidgetUtils.equipamentBackComponent(
                        team,
                        number: (startingLineupPlayers.any(
                                (element) => element.positionIndex == index))
                            ? startingLineupPlayers
                                .firstWhere(
                                    (element) => element.positionIndex == index)
                                .player!
                                .shirtNumber
                                .toString()
                            : "",
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        (startingLineupPlayers.any(
                                (element) => element.positionIndex == index))
                            ? startingLineupPlayers
                                .firstWhere(
                                    (element) => element.positionIndex == index)
                                .player!
                                .nickname
                                .toString()
                            : "",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 10,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  )
                ],
              );

              return Container(
                color: Colors.orange,
                width: 40,
                height: 40,
                child: Center(
                  child: Text(
                    (startingLineupPlayers
                            .any((element) => element.positionIndex == index))
                        ? startingLineupPlayers
                            .firstWhere(
                                (element) => element.positionIndex == index)
                            .player!
                            .nickname
                            .toString()
                        : "s",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              );
              final player = startingLineupPlayers
                  .firstWhere((element) => element.positionIndex == index);

              return Text("${player}");

              // Se não encontrou jogador para a posição
              if (player == null) {
                return SizedBox.shrink();
                return Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      child: EquipmentWidgetUtils.equipamentBackComponent(team),
                    ),
                    Container(
                      width: 50,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                );
              }

              return Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    child: EquipmentWidgetUtils.equipamentBackComponent(team),
                  ),
                  Container(
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        player.player?.nickname ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  late TabController _tabController;
  final int totalPartidas = 6;
  final ValueNotifier<int> partidaAtual = ValueNotifier<int>(3);

  final String backgroundUrl =
      'https://cdn.pixabay.com/photo/2014/10/14/20/24/football-488714_1280.jpg';
  final String profileUrl =
      'https://scontent.flad5-1.fna.fbcdn.net/v/t39.30808-6/468946321_1143394810468991_6731165110528390324_n.jpg?_nc_cat=1&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=wSrOeJxvDDEQ7kNvwEbvT6L&_nc_oc=AdlTqHYlCPFGfrAGQlDwBDoWGWHzOtYBQvPLz5DFEahZRV2c0WoBBuSIrcQrBKYO_91fpJuk6Y9c1v6oU_Uldije&_nc_zt=23&_nc_ht=scontent.flad5-1.fna&_nc_gid=bu1cwd0CKmhmqZJFsKvxIg&oh=00_AfHS3wRkCA00310Cb6BF1t2f-b46KjsWZzhIrcgxTejGig&oe=68048141';
  final String team1Logo =
      'https://scontent.flad5-1.fna.fbcdn.net/v/t39.30808-1/449761244_1062646795218211_4139834764378388664_n.jpg?stp=c196.196.1199.1199a_dst-jpg_s200x200_tt6&_nc_cat=1&ccb=1-7&_nc_sid=2d3e12&_nc_ohc=2PIv9d0zbT4Q7kNvwFrDdyl&_nc_oc=Adnbea-uBG6-Yjz-swaIok52lxeGLlxbFYlST90cK4dm1KdQveMu-MleJfCBBy4zbgL6PbCyY77uA-Jx-87CXmsf&_nc_zt=24&_nc_ht=scontent.flad5-1.fna&_nc_gid=b_6-6aTZFayQsgqhCcyxhQ&oh=00_AfE78XoqOuYLsaL3vLfGnPlltyuw8ZA_dK-vkLTcnXYkEA&oe=68047744';
  final String team2Logo =
      'https://scontent.flad5-1.fna.fbcdn.net/v/t39.30808-1/273144602_10152602977424953_1955203260619408476_n.jpg?stp=dst-jpg_s200x200_tt6&_nc_cat=1&ccb=1-7&_nc_sid=2d3e12&_nc_ohc=q-W_7Ofx0GIQ7kNvwGEJVrU&_nc_oc=Adnh-RBMtZE6Kr9ubdATmRiKH6NAEiVO92HwxQXcJXb10vyt6hqv1nhkO14Pimi4X05KqocWeD2Q83HP7vsW3Xw6&_nc_zt=24&_nc_ht=scontent.flad5-1.fna&_nc_gid=tINtmFSQ5O2qx6UrzJ1Xjg&oh=00_AfFWaHkb26Gz6qnHdeiku917wrHIZY8eRqAgYFACd31o-Q&oe=68047B4B';

  int selectedTabIndex = 0;

  Color parseColorFromString(String colorString) {
    // Remove a parte "Color(" e ")"
    final hexString = colorString.replaceAll(RegExp(r'[^0-9a-fA-F]'), '');

    // Converte a string hexadecimal para inteiro
    return Color(int.parse('0xff$hexString'));
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    context.read<FetchPlayersTeamCubit>().fetchPlayersByTeam(widget.team.id!);
    context.read<FetchTrophiesTeamCubit>().fetchTrophiesByTeam(widget.team.id!);
    context.read<GetTeamEquipamentCubit>().getTeamEquipament(widget.team.id!);
    context.read<SquadCubit>().getSquadByGameTypeFormation(
          widget.team.gameType!,
          widget.team.formation!,
          widget.team.id!,
        );
    context
        .read<StartingLineupPlayerCubit>()
        .getTeamStartingLineupPlayers(widget.team.id!);

    selectedFormation = widget.team.formation.toString();
    selectedCount = widget.team.gameType.toString();
  }

  @override
  void dispose() {
    _tabController.dispose();
    selectedType.dispose();
    selectedMainShirtColor.dispose();
    selectedStyleShirtColor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetOneTeamCubit, GetOneTeamState>(
        builder: (context, state) {
          if (state is GetOneTeamLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetOneTeamFailure) {
            return Center(child: Text(state.error));
          } else if (state is GetOneTeamLoaded) {
            final team = state.team;
            return Column(
              children: [
                Container(
                  color: AppColors.primary,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
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
                          AppIcons.shield,
                          color: selectedTabIndex == 0
                              ? Colors.white
                              : AppColors.white.withOpacity(.6),
                        ),
                        text: 'Detalhes',
                      ),
                      Tab(
                        icon: SvgPicture.asset(
                          AppIcons.soccerBoots,
                          color: selectedTabIndex == 1
                              ? Colors.white
                              : AppColors.white.withOpacity(.6),
                        ),
                        text: 'Jogos',
                      ),
                      Tab(
                        icon: SvgPicture.asset(
                          AppIcons.courtSport,
                          color: selectedTabIndex == 2
                              ? Colors.white
                              : AppColors.white.withOpacity(.6),
                        ),
                        text: 'Plantel',
                      ),
                      Tab(
                        icon: SvgPicture.asset(
                          AppIcons.trophyStar,
                          color: selectedTabIndex == 3
                              ? Colors.white
                              : AppColors.white.withOpacity(.6),
                        ),
                        text: 'Títulos',
                      ),
                      Tab(
                        icon: SvgPicture.asset(
                          AppIcons.footballPlayer,
                          color: selectedTabIndex == 4
                              ? Colors.white
                              : AppColors.white.withOpacity(.6),
                        ),
                        text: 'Jogadores',
                      ),
                      Tab(
                        icon: SvgPicture.asset(
                          AppIcons.newspaper,
                          color: selectedTabIndex == 5
                              ? Colors.white
                              : AppColors.white.withOpacity(.6),
                        ),
                        text: 'News',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildContantTeam(team!),
                      _buildMatchesTeam(team),
                      _buildPlantelTeam(team),
                      // _buildSettings(team),
                      _buildTrophiesTeam(),
                      // _buildTeamsList(),
                      // _buildStats(),
                      _buildPlyersTeam(team),
                      _buildNewsTeam()
                    ],
                  ),
                ),
              ],
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildPlyersTeam(TeamEntity team) {
    ScrollController scrollController = ScrollController();

    return RefreshIndicator(
      onRefresh: () async {
        await context
            .read<FetchPlayersTeamCubit>()
            .fetchPlayersByTeam(widget.team.id!);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.link),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Partilhar link"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(.1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Text(
                          "?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const TabBar(
                indicatorColor: AppColors.primary,
                labelColor: AppColors.primary,
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                tabAlignment: TabAlignment.center,
                tabs: [
                  Tab(text: 'Jogadores Reais'),
                  Tab(text: 'Jogadores Fictícios'),
                  Tab(text: 'À Venda'),
                  // Tab(text: 'Novo jogador'),
                ],
              ),
              Expanded(
                child:
                    BlocBuilder<FetchPlayersTeamCubit, FetchPlayersTeamState>(
                  builder: (context, state) {
                    if (state is FetchPlayersTeamLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is FetchPlayersTeamFailure) {
                      return Center(child: Text("error"));
                    } else if (state is FetchPlayersTeamLoaded) {
                      final players = state.players;
                      return TabBarView(
                        children: [
                          _buildPlayerRealWidget(players, scrollController),
                          _buildPlayerImaginaryWidget(players),
                          _buildPlayersToSendWidget(team),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContantTeam(TeamEntity team) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // Imagem de capa
                  Image.network(
                    backgroundUrl,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      color: Colors.black54,
                    ),
                  ),
                  Positioned(
                    bottom: -60,
                    child: Stack(
                      children: [
                        (team.logoUrl == null || team.logoUrl!.isEmpty)
                            ? SvgPicture.asset(AppIcons.security)
                            : CircleAvatar(
                                radius: 70, // aumentado o tamanho do círculo
                                backgroundColor: Colors.white,
                                child: CachedNetworkImage(
                                  imageUrl: team.logoUrl!,
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    radius: 66, // aumentado o tamanho da imagem
                                    backgroundImage: imageProvider,
                                  ),
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.verified,
                                color: Colors.blue, size: 22),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Text(
                      '${team.name}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              // Informações adicionais
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: AppStrings.fontFamily,
                  ),
                  children: [
                    const TextSpan(
                      text: '3',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' Colaboradores • ',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const TextSpan(
                      text: '3,5 M',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' seguidores',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, color: Colors.grey),
              const SizedBox(width: 5),
              Text("${team.location}"),
            ],
          ),
          ListView(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              BlocBuilder<GetTeamEquipamentCubit, GetTeamEquipamentState>(
                builder: (context, state) {
                  if (state is GetTeamEquipamentLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GetTeamEquipamentFailure) {
                    return Center(child: Text(state.error));
                  } else if (state is GetTeamEquipamentLoaded) {
                    final team = state.team;
                    return Container(
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
                          InkWell(
                            onTap: () {
                              // Get.to(BuildEquipamentPage(
                              //   teamData: equipament,
                              // ));
                            },
                            child: Container(
                              height: 150,
                              padding: const EdgeInsets.all(10),
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
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: EquipmentWidgetUtils
                                              .equipamentFrontComponent(team),
                                        ),
                                        Expanded(
                                          child: EquipmentWidgetUtils
                                              .equipamentBackComponent(team),
                                        ),
                                      ],
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
                  return const SizedBox.shrink();
                },
              ),

              ListTile(
                leading: SvgPicture.asset(
                  AppIcons.userColor,
                  width: 26,
                ),
                title: Text(
                  'Gerente',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  '${team.createdByProfile!.fullName}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  AppIcons.flag2,
                  width: 26,
                ),
                title: Text(
                  'Fundado aos',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  '${AppDateUtils.formatDate(data: team.foundedAt!)} - (${AppDateUtils.getYearDifference(team.foundedAt!)} anos)',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  AppIcons.footballJersey,
                  width: 26,
                ),
                title: Text(
                  'QTD. Jogadores',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  team.memberLimit.toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              // RichText(
              //   text: TextSpan(
              //     style: Theme.of(context).textTheme.bodyMedium,
              //     children: [
              //       TextSpan(
              //         text: 'Trofeos',
              //         style: Theme.of(context).textTheme.titleLarge,
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 8),
              // Container(
              //   padding: const EdgeInsets.all(10),
              //   decoration: BoxDecoration(
              //     color: AppColors.primary.withOpacity(.1),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Container(
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               SvgPicture.asset(
              //                 AppIcons.medalChampionAward3,
              //               ),
              //               const SizedBox(height: 5),
              //               Text(
              //                 "10",
              //                 style: Theme.of(context).textTheme.titleMedium,
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       Expanded(
              //         child: Container(
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               SvgPicture.asset(
              //                 AppIcons.medalChampionAward1,
              //               ),
              //               const SizedBox(height: 5),
              //               Text(
              //                 "1",
              //                 style: Theme.of(context).textTheme.titleMedium,
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       Expanded(
              //         child: Container(
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               SvgPicture.asset(
              //                 AppIcons.medalChampionAward2,
              //               ),
              //               const SizedBox(height: 5),
              //               Text(
              //                 "2",
              //                 style: Theme.of(context).textTheme.titleMedium,
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              //   // child: ListTile(
              //   //   leading: const Icon(Icons.emoji_events, color: Colors.amber),
              //   //   title: const Text('1000000 \$ - Valor do grande prêmio'),
              //   // ),
              // ),
              const SizedBox(height: 16),
              ListTile(
                leading: SvgPicture.asset(
                  AppIcons.money,
                  width: 40,
                ),
                title: const Text('Taxa de registro'),
                subtitle: const Text('10 \$'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeam(String logoUrl, String name, CrossAxisAlignment align) {
    return Column(
      crossAxisAlignment: align,
      children: [
        Image.network(logoUrl, width: 40, height: 40),
        const SizedBox(height: 8),
        Text(name,
            style: const TextStyle(fontSize: 14),
            overflow: TextOverflow.ellipsis),
      ],
    );
  }

  Widget _buildMatchesTeam(TeamEntity team) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.09),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ValueListenableBuilder<int>(
            valueListenable: partidaAtual,
            builder: (context, value, _) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Botão esquerda
                  Expanded(
                    child: IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: value > 1 ? () => partidaAtual.value-- : null,
                    ),
                  ),

                  // Dropdown com estilo
                  Center(
                    child: ValueListenableBuilder<int>(
                      valueListenable: partidaAtual,
                      builder: (context, value, _) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () => _showPartidasBottomSheet(context),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 16),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Partida $value / $totalPartidas'),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Botão direita
                  Expanded(
                    child: IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: value < totalPartidas
                          ? () => partidaAtual.value++
                          : null,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const PlayerHighlightCard(),
              const SizedBox(height: 16),
              const Text(
                "Sem Data Ainda",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              MatchGroupCard(
                team1: "Equipe 2",
                team2: "Equipe 3",
                group: "GRUPO A",
              ),
              MatchGroupCard(
                team1: "Equipe 2",
                team2: "Equipe 3",
                group: "GRUPO A",
              ),
              MatchGroupCard(
                team1: "Equipe 2",
                team2: "Equipe 3",
                group: "GRUPO A",
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showPartidasBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: totalPartidas,
          itemBuilder: (context, index) {
            int num = index + 1;
            return ListTile(
              title: Text('Partida $num / $totalPartidas'),
              onTap: () {
                partidaAtual.value = num;
                Navigator.pop(
                    context); // Fecha o bottom sheet depois de selecionar
              },
            );
          },
        );
      },
    );
  }

  Widget _buildPlayerImaginaryWidget(List<PlayerEntity> players) {
    return ListView.builder(
      itemCount: players.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        final player = players[index];
        if (player.type == 'real') {
          return const SizedBox.shrink();
        }
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.09),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: (player.avatarUrl == null)
                  ? Image.asset(
                      width: 40,
                      height: 40,
                      AppImages.soccerPlayer,
                    )
                  : CachedNetworkImage(
                      imageUrl: player.avatarUrl!,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
            ),
            title: Text(
              player.fullName!,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Row(
                children: [
                  Text(player.position ?? "Unknown"),
                ],
              ),
            ),
            trailing: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: SvgPicture.asset(
                      width: 20,
                      AppIcons.footballJersey,
                    ),
                  ),
                  TextSpan(
                    text: " ${player.shirtNumber}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: AppStrings.fontFamily),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTrophiesTeam() {
    return BlocBuilder<FetchTrophiesTeamCubit, FetchTrophiesTeamState>(
      builder: (context, state) {
        if (state is FetchTrophiesTeamLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FetchTrophiesTeamFailure) {
          return Center(child: Text(state.error));
        } else if (state is FetchTrophiesTeamLoaded) {
          final trophies = state.trophies;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: trophies.length,
            itemBuilder: (context, index) {
              final trophy = trophies[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.09),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '#${index + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  title: Text(
                    trophy.name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Ano ${trophy.awardedAt}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Handle trophy click
                  },
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildSettings(TeamEntity team) {
    return SingleChildScrollView(
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
                            print("object");
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
    );
    // return ListView.builder(
    //   itemCount: matches.length,
    //   itemBuilder: (context, index) {
    //     final match = matches[index];
    //     return Container(
    //       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //       decoration: BoxDecoration(
    //         color: Colors.white,
    //         borderRadius: BorderRadius.circular(10),
    //         boxShadow: [
    //           BoxShadow(
    //             color: Colors.black.withOpacity(0.09),
    //             blurRadius: 12,
    //             offset: const Offset(0, 4),
    //           ),
    //         ],
    //       ),
    //       child: ListTile(
    //         leading: ClipRRect(
    //           borderRadius: BorderRadius.circular(50),
    //           child: Image.network(
    //             "https://fpfimagehandler.fpf.pt/FPFImageHandler.ashx?type=Person&id=3883014&op=t&w=325&h=378",
    //             width: 40,
    //             height: 40,
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //         title: Text(
    //           'Bayern Munich',
    //           style: TextStyle(
    //             fontWeight: FontWeight.w600,
    //           ),
    //         ),
    //         subtitle: Padding(
    //           padding: const EdgeInsets.only(top: 5),
    //           child: Row(
    //             children: [
    //               ClipRRect(
    //                 borderRadius: BorderRadius.circular(50),
    //                 child: Container(
    //                   width: 20,
    //                   height: 20,
    //                   child: CachedNetworkImage(imageUrl: match.homeLogo),
    //                 ),
    //               ),
    //               Text("Real Madrid"),
    //             ],
    //           ),
    //         ),
    //         trailing: RichText(
    //           text: TextSpan(
    //             children: [
    //               TextSpan(
    //                 text: "20 ",
    //                 style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.black,
    //                     fontSize: 18,
    //                     fontFamily: AppStrings.fontFamily),
    //               ),
    //               TextSpan(
    //                 text: "Gol.",
    //                 style: TextStyle(
    //                     color: Colors.grey, fontFamily: AppStrings.fontFamily),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }

  Widget _buildTeamsList(TeamEntity team) {
    return Center();
    // return ListView.builder(
    //   itemCount: matches.length,
    //   itemBuilder: (context, index) {
    //     final match = matches[index];
    //     return Container(
    //       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //       decoration: BoxDecoration(
    //         color: Colors.white,
    //         borderRadius: BorderRadius.circular(10),
    //         boxShadow: [
    //           BoxShadow(
    //             color: Colors.black.withOpacity(0.09),
    //             blurRadius: 12,
    //             offset: const Offset(0, 4),
    //           ),
    //         ],
    //       ),
    //       child: ListTile(
    //         leading: ClipRRect(
    //           borderRadius: BorderRadius.circular(50),
    //           child: Image.network(
    //             "https://fpfimagehandler.fpf.pt/FPFImageHandler.ashx?type=Person&id=3883014&op=t&w=325&h=378",
    //             width: 40,
    //             height: 40,
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //         title: Text(
    //           'Bayern Munich',
    //           style: TextStyle(
    //             fontWeight: FontWeight.w600,
    //           ),
    //         ),
    //         subtitle: Padding(
    //           padding: const EdgeInsets.only(top: 5),
    //           child: Row(
    //             children: [
    //               ClipRRect(
    //                 borderRadius: BorderRadius.circular(50),
    //                 child: Container(
    //                   width: 20,
    //                   height: 20,
    //                   child: CachedNetworkImage(imageUrl: match.homeLogo),
    //                 ),
    //               ),
    //               Text("Real Madrid"),
    //             ],
    //           ),
    //         ),
    //         trailing: RichText(
    //           text: TextSpan(
    //             children: [
    //               TextSpan(
    //                 text: "20 ",
    //                 style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.black,
    //                     fontSize: 18,
    //                     fontFamily: AppStrings.fontFamily),
    //               ),
    //               TextSpan(
    //                 text: "Gol.",
    //                 style: TextStyle(
    //                     color: Colors.grey, fontFamily: AppStrings.fontFamily),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }

  Widget _buildPlayersToSendWidget(TeamEntity team) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.09),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: color),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable() {
    return Column(
      children: [
        // Header row
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          color: AppColors.primary,
          child: const Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  "POS",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  "Clube",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "V",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  "E",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  "D",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  "Pts",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        // Table rows
        Expanded(child: Container()),
      ],
    );
  }

  Widget _buildNewsTeam() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final newss = NewsArticle.fromJson(news[index]);
          return Container(
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: newss.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        newss.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.calendar,
                            width: 16,
                            // color: AppColors.color,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text("10/10/2024 10:10"),
                          const SizedBox(
                            width: 10,
                          ),
                          SvgPicture.asset(
                            AppIcons.siteAlt,
                            width: 16,
                            // color: AppColors.color,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(newss.sourceStr),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 20,
          );
        },
        itemCount: news.length,
      ),
    );
  }

  Widget playerSlot(String label) {
    return GestureDetector(
      onTap: () {
        // Aqui você pode abrir uma modal ou buscar jogador
        debugPrint("Selecionou: $label");
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green[800],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add, color: Colors.white),
              Text(label, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlantelTeam(TeamEntity team) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          // Dropdowns
          BlocBuilder<SquadCubit, SquadState>(
            builder: (context, state) {
              if (state is SquadLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SquadFailure) {
                return Center(child: Text(state.error));
              } else if (state is SquadLoaded) {
                final squad = state.squad;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: DropdownButton<String>(
                            value: selectedCount,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  selectedCount = value;

                                  BlocProvider.of<ActionTeamSquadCubit>(context)
                                      .updateTeamSquad(
                                    selectedCount,
                                    selectedFormation,
                                    team.id!,
                                  );
                                });
                              }
                            },
                            isExpanded: true,
                            underline: const SizedBox(),
                            items: playerCounts.map((e) {
                              return DropdownMenuItem<String>(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: DropdownButton<String>(
                            value: selectedFormation,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  selectedFormation = value;
                                  BlocProvider.of<ActionTeamSquadCubit>(context)
                                      .updateTeamSquad(
                                    selectedCount,
                                    selectedFormation,
                                    team.id!,
                                  );
                                });
                              }
                            },
                            isExpanded: true,
                            underline: SizedBox(),
                            items: formations.map((e) {
                              return DropdownMenuItem<String>(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),

          const SizedBox(height: 16),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Row(
                    //   children: [
                    //     Text(
                    //       "Titulares",
                    //       style: Theme.of(context).textTheme.titleLarge,
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 16),
                    BlocBuilder<StartingLineupPlayerCubit,
                        StartingLineupPlayerState>(
                      builder: (context, state) {
                        if (state is StartingLineupPlayerLoading) {
                          return Container(
                            width: double.infinity,
                            height: 300,
                            padding: const EdgeInsets.only(bottom: 50),
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.green),
                              image: const DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage(
                                  AppImages.campoReto,
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: _buildFormationWithLimit(
                                  fieldFormation.reversed.toList(), team),
                            ),
                          );
                        }
                        return Container(
                          height: 300,
                          padding: const EdgeInsets.only(bottom: 50),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.green),
                            image: const DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage(
                                AppImages.campoReto,
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: _buildFormationWithLimit(
                                fieldFormation.reversed.toList(), team),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                        onPressed: () {
                          BlocProvider.of<StartingLineupPlayerCubit>(context)
                              .deleteSquadTeamUse(team.id!);
                        },
                        child: const Text("Zerar Escalação")),
                    const SizedBox(height: 10),

                    BlocBuilder<StartingLineupPlayerCubit,
                        StartingLineupPlayerState>(
                      builder: (context, lineupState) {
                        if (lineupState is StartingLineupPlayerLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (lineupState is StartingLineupPlayerLoaded) {
                          final startingLineup =
                              lineupState.startingLineupPlayers;

                          return BlocBuilder<FetchPlayersTeamCubit,
                              FetchPlayersTeamState>(
                            builder: (context, playersState) {
                              if (playersState is FetchPlayersTeamLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (playersState
                                  is FetchPlayersTeamLoaded) {
                                final allPlayers = playersState.players;

                                // Filtra jogadores que ainda NÃO estão no lineup
                                final availablePlayers =
                                    allPlayers.where((player) {
                                  return !startingLineup.any(
                                    (lineupPlayer) =>
                                        lineupPlayer.playerId == player.id,
                                  );
                                }).toList();

                                return Wrap(
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: availablePlayers.map((player) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          child: EquipmentWidgetUtils
                                              .equipamentBackComponent(
                                            team,
                                            number: player.shirtNumber
                                                    ?.toString() ??
                                                '',
                                          ),
                                        ),
                                        Container(
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.black54,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                            child: Text(
                                              player.nickname ?? 'Sem nome',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                );
                              } else if (playersState
                                  is FetchPlayersTeamFailure) {
                                return Center(
                                    child: Text('Erro: ${playersState.error}'));
                              }

                              return const SizedBox.shrink();
                            },
                          );
                        } else if (lineupState is StartingLineupPlayerFailure) {
                          return Center(
                              child: Text('Erro: ${lineupState.error}'));
                        }

                        return const SizedBox.shrink();
                      },
                    )

                    // Wrap(
                    //   spacing: 5,
                    //   runSpacing: 5,
                    //   children: List.generate(10, (index) {
                    //     return Column(
                    //       mainAxisSize: MainAxisSize.min,
                    //       children: [
                    //         Container(
                    //           width: 50,
                    //           height: 50,
                    //           // color: Colors.red,
                    //           child:
                    //               EquipmentWidgetUtils.equipamentBackComponent(
                    //                   team),
                    //         ),
                    //         Container(
                    //           width: 50,
                    //           decoration: BoxDecoration(
                    //             color: Colors.black54,
                    //             borderRadius: BorderRadius.circular(5),
                    //           ),
                    //           child: Center(
                    //             child: Text(
                    //               "nome d",
                    //               style: const TextStyle(
                    //                   fontWeight: FontWeight.normal,
                    //                   color: Colors.white,
                    //                   fontSize: 12),
                    //               overflow: TextOverflow.ellipsis,
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     );
                    //   }),
                    // )

                    // Row(
                    //   children: [
                    //     Text(
                    //       "Suplentes",
                    //       style: Theme.of(context).textTheme.titleLarge,
                    //     ),
                    //     const SizedBox(width: 5),
                    //     Text(
                    //       "[10]",
                    //       style: Theme.of(context)
                    //           .textTheme
                    //           .bodyLarge!
                    //           .copyWith(fontWeight: FontWeight.bold),
                    //     )
                    //   ],
                    // ),
                    // const SizedBox(height: 16),
                    // Wrap(
                    //   spacing: 10,
                    //   runSpacing: 10,
                    //   children: List.generate(7, (index) {
                    //     return Container(
                    //       width: MediaQuery.of(context).size.width / 2 - 30,
                    //       padding: const EdgeInsets.all(10),
                    //       decoration: BoxDecoration(
                    //         color: Colors.blue,
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: [
                    //           CircleAvatar(
                    //             radius: 20,
                    //             backgroundImage: AssetImage(AppImages.avatar),
                    //           ),
                    //           const SizedBox(height: 8),
                    //           Text(
                    //             "10",
                    //             style: TextStyle(
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 16,
                    //               color: Colors.white,
                    //             ),
                    //           ),
                    //           const SizedBox(height: 4),
                    //           Text(
                    //             "Atacante",
                    //             style: TextStyle(
                    //               fontSize: 14,
                    //               color: Colors.white70,
                    //             ),
                    //           ),
                    //           const SizedBox(height: 4),
                    //           Text(
                    //             "Jogador",
                    //             style: TextStyle(
                    //               fontSize: 14,
                    //               color: Colors.white,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     );
                    //   }),
                    // ),
                  ],
                ),
              ),
            ),
          ),

          // Expanded(
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: Colors.green[100],
          //       borderRadius: BorderRadius.circular(16),
          //       border: Border.all(color: Colors.green),
          //       image: DecorationImage(
          //         fit: BoxFit.fitWidth,
          //         image: AssetImage(
          //           AppImages.campoReto,
          //         ),
          //       ),
          //     ),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: _buildFormationWithLimit(
          //           fieldFormation.reversed.toList()),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _showPlayersToPlantel(List<PlayerEntity> players,
      ScrollController scrollController, PlayerEntity? selectedPlayer) {
    const positionOrder = [
      'GoalKeeper',
      'Center Back',
      'Right Back',
      'Left Back',
      'Midfielder',
      'Forward'
    ];
    final groupedPlayers = <String, List<PlayerEntity>>{};
    for (var pos in positionOrder) {
      groupedPlayers[pos] =
          players.where((p) => p.type == 'real' && p.position == pos).toList();
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      controller: scrollController,
      itemCount: positionOrder.fold<int>(0, (count, pos) {
        final group = groupedPlayers[pos]!;
        return count +
            (group.isNotEmpty ? group.length + 1 : 0); // +1 para o título
      }),
      itemBuilder: (context, index) {
        int runningIndex = 0;

        for (final position in positionOrder) {
          final playersInGroup = groupedPlayers[position]!;

          if (playersInGroup.isEmpty) continue;

          // Cabeçalho da posição
          if (index == runningIndex) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                position,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            );
          }

          final playerIndex = index - runningIndex - 1;
          if (playerIndex < playersInGroup.length) {
            final player = playersInGroup[playerIndex];

            return ValueListenableBuilder(
                valueListenable: theSelectedPlayer,
                builder: (context, value, _) {
                  final isSlected =
                      value != null && theSelectedPlayer.value!.id == player.id;
                  return InkWell(
                    onTap: () {
                      theSelectedPlayer.value = player;
                      print(index);
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: (isSlected)
                              ? const EdgeInsets.symmetric(vertical: 0)
                              : EdgeInsets.zero,
                          decoration: BoxDecoration(
                              color: isSlected
                                  ? Colors.green.withOpacity(.2)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: PlayerTile(player: player),
                        ),
                        (isSlected)
                            ? Positioned(
                                top: 5,
                                right: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.blue.shade800,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  );
                });
          }

          runningIndex += playersInGroup.length + 1;
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildPlayerRealWidget(
      List<PlayerEntity> players, ScrollController scrollController,
      {String type = "players"}) {
    const positionOrder = [
      'GoalKeeper',
      'Center Back',
      'Right Back',
      'Left Back',
      'Midfielder',
      'Forward'
    ];
    final groupedPlayers = <String, List<PlayerEntity>>{};
    for (var pos in positionOrder) {
      groupedPlayers[pos] =
          players.where((p) => p.type == 'real' && p.position == pos).toList();
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      controller: scrollController,
      itemCount: positionOrder.fold<int>(0, (count, pos) {
        final group = groupedPlayers[pos]!;
        return count +
            (group.isNotEmpty ? group.length + 1 : 0); // +1 para o título
      }),
      itemBuilder: (context, index) {
        int runningIndex = 0;

        for (final position in positionOrder) {
          final playersInGroup = groupedPlayers[position]!;

          if (playersInGroup.isEmpty) continue;

          // Cabeçalho da posição
          if (index == runningIndex) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                position,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            );
          }

          final playerIndex = index - runningIndex - 1;
          if (playerIndex < playersInGroup.length) {
            final player = playersInGroup[playerIndex];

            return PlayerTile(player: player);
          }

          runningIndex += playersInGroup.length + 1;
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class PlayerTile extends StatelessWidget {
  final PlayerEntity player;
  final VoidCallback? onTap;

  const PlayerTile({
    super.key,
    required this.player,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(10),
      // ),
      child: ListTile(
        onTap: onTap,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: (player.avatarUrl == null)
              ? Image.asset(
                  width: 40,
                  height: 40,
                  AppImages.soccerPlayer,
                )
              : CachedNetworkImage(
                  imageUrl: player.avatarUrl!,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
        ),
        title: Text(
          player.nickname ?? '',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(player.position ?? "Unknown"),
        trailing: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: SvgPicture.asset(
                  width: 20,
                  AppIcons.footballJersey,
                ),
              ),
              TextSpan(
                text: " ${player.shirtNumber}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: AppStrings.fontFamily,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayerHighlightCard extends StatelessWidget {
  const PlayerHighlightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
              image: CachedNetworkImageProvider(
                  scale: 2.5,
                  // 'https://lh3.googleusercontent.com/gps-cs-s/AB5caB_xM6ql3O50gDkC8Xzk-VYnE0gDSk5WJKT0n7k_eHjSWh6Bp-u8vsFjjly3bupWhkl5BvJ8xIgpc4WVeNU-KZovlL1YhHIbnYxGS2zKElZLvUa6wG-uKoOwdX_CV0sltZ2yvd3z=s1360-w1360-h1020',
                  // 'https://lh3.googleusercontent.com/gps-cs-s/AB5caB8inwH_KFKJm-45QElqe4RYAnwkGyWXDnPucd-VR3Y4b1rMeOpALAn3gtOjFdI-gYmdSwM1NIU2YdgQ7CI5yBvLfnDOoCVnzpxEK3WUeiUbkbUp8uvP6GPe_mg12WT2_rRJ2ZU=s1360-w1360-h1020'),
                  'https://lh3.googleusercontent.com/gps-cs-s/AB5caB9SGdNVDWSoYrRDpwCW8IC3wcBVfEafWXhfonttQOo1eFw5kDuC1f9PCAa6UzA41L46zEunc4G0DLmyIr_SP-Fj4CGltLmWLcCmbk7U2g0kljLeMUVKiiGj3T2Tu2U0LSPhz1Ne=s1360-w1360-h1020'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'NOVO',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.emoji_events, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'Jogador da semana 1',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MatchGroupCard extends StatelessWidget {
  final String team1;
  final String team2;
  final String group;

  const MatchGroupCard({
    super.key,
    required this.team1,
    required this.team2,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(.04),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: Colors.black12,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TeamRowHome(name: team1),
                    const SizedBox(height: 8),
                    TeamRowAway(name: team2),
                  ],
                ),
                Row(
                  children: [
                    const Column(
                      children: [
                        Text("-", style: TextStyle(fontSize: 18)),
                        SizedBox(height: 8),
                        Text("-", style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    const SizedBox(width: 15),
                    SvgPicture.asset(
                      AppIcons.fileEdit,
                      color: Colors.blue.shade900,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 0, top: 4, bottom: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              group,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TeamRowHome extends StatelessWidget {
  final String name;

  const TeamRowHome({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(AppIcons.security),
        const SizedBox(width: 8),
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class TeamRowAway extends StatelessWidget {
  final String name;

  const TeamRowAway({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(AppIcons.security),
        const SizedBox(width: 8),
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
