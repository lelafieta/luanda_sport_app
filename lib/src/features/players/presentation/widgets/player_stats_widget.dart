import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luanda_sport_app/src/core/utils/warning_widget.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import '../../../../core/resources/app_images.dart';
import '../../../player_teams/domain/entities/player_team_entity.dart';
import '../../../player_teams/presentation/cubit/player_team_cubit.dart';
import '../../domain/entities/player_entity.dart';
import '../cubit/fetch_player_stats_cubit/fetch_player_stats_cubit.dart';
import 'player_team_dropdown_skeleton.dart';

class PlayerStatsWidget extends StatefulWidget {
  final PlayerEntity player;
  const PlayerStatsWidget({super.key, required this.player});

  @override
  State<PlayerStatsWidget> createState() => _PlayerStatsWidgetState();
}

class _PlayerStatsWidgetState extends State<PlayerStatsWidget> {
  final dropDownKey = GlobalKey<DropdownSearchState>();
  ValueNotifier<PlayerTeamEntity?> playerTeam = ValueNotifier(null);
  String selectedTeamId = "";
  @override
  void initState() {
    selectedTeamId = widget.player.teamId ?? '';
    context
        .read<PlayerTeamCubit>()
        .getPlayerTeams("9f829de7-50dc-4351-aff9-fc0d1c93cef2");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ValueListenableBuilder<PlayerTeamEntity?>(
          valueListenable: playerTeam,
          builder: (context, selected, _) {
            return Column(
              children: [
                BlocConsumer<PlayerTeamCubit, PlayerTeamState>(
                  listener: (context, state) {
                    if (state is PlayerTeamLoaded) {
                      if (playerTeam.value != null) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          context
                              .read<FetchPlayerStatsCubit>()
                              .fetchPlayerStatsByTeam(
                                  playerTeam.value!.team!.id.toString(),
                                  playerTeam.value!.player!.id.toString());
                        });
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is PlayerTeamLoaded) {
                      if (state.playerTeams.isEmpty) {
                        // return WarningWidget();
                        return const Text("Ainda nunca passou em uma equipe");
                      }

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        playerTeam.value = state.playerTeams.firstWhere(
                          (team) => team.team?.id == selectedTeamId,
                        );
                      });

                      return DropdownSearch<PlayerTeamEntity>(
                        key: dropDownKey,
                        selectedItem: selected,
                        items: state.playerTeams,
                        onChanged: (value) {
                          playerTeam.value = value;
                          selectedTeamId = value?.team?.id ?? '';
                          context
                              .read<FetchPlayerStatsCubit>()
                              .fetchPlayerStatsByTeam(
                                  selectedTeamId, widget.player.id.toString());
                        },
                        itemAsString: (PlayerTeamEntity? team) => team == null
                            ? ''
                            : (team.position != null
                                ? "${team.position} - ${team.team?.name ?? ''}"
                                : (team.team?.name ?? '')),
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        dropdownBuilder: (context, item) {
                          if (item == null || item.team == null) {
                            return const Text("Selecione um time de passagem");
                          }
                          return Row(
                            children: [
                              ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: item.team!.logoUrl ??
                                      'https://placehold.co/40x40',
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  item.team!.name ?? '',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          );
                        },
                        popupProps: PopupProps.dialog(
                          showSearchBox: false,
                          title: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 20,
                            ),
                            child: Center(
                              child: Text(
                                "Equipes de Passagem",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ),
                          itemBuilder: (context, item, isSelected) {
                            return Container(
                              color: selectedTeamId == item.team?.id
                                  ? AppColors.primary.withAlpha(50)
                                  : Colors.transparent,
                              child: ListTile(
                                leading: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: item.team?.logoUrl ??
                                        'https://placehold.co/40x40',
                                    width: 40,
                                    height: 40,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(
                                    item.team?.name ?? 'Time desconhecido'),
                                subtitle: Text(
                                  "Desde: ${item.joinedAt?.toString().split(' ')[0]} até Agora",
                                ),
                                selected: isSelected,
                              ),
                            );
                          },
                        ),
                      );
                    }

                    return const PlayerTeamDropdownSkeleton();
                  },
                ),
                Expanded(
                  child:
                      BlocBuilder<FetchPlayerStatsCubit, FetchPlayerStatsState>(
                    builder: (context, state) {
                      if (state is FetchPlayerStatsLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is FetchPlayerStatsLoaded) {
                        final playerStats = state.playerStats;
                        if (playerStats == null) {
                          return const Center(
                            child: Text('Nenhum dado encontrado'),
                          );
                        }
                        return FadeIn(
                          child: ListView(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 8),
                            children: [
                              ListTile(
                                contentPadding: const EdgeInsets.all(0),
                                leading: SvgPicture.asset(
                                  AppIcons.footballBall,
                                  width: 25,
                                ),
                                title: const Text('Gols'),
                                trailing: Text(
                                  '${playerStats.goals}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ListTile(
                                contentPadding: const EdgeInsets.all(0),
                                leading: SvgPicture.asset(
                                  AppIcons.footballShoesShoe,
                                  width: 25,
                                ),
                                title: const Text('Assistências'),
                                trailing: Text(
                                  '${playerStats.assists}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ListTile(
                                contentPadding: const EdgeInsets.all(0),
                                leading: SvgPicture.asset(
                                  AppIcons.footballJersey,
                                  width: 25,
                                ),
                                title: const Text('Partidas'),
                                trailing: Text(
                                  '${playerStats.match}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          const Text('Derrotas'),
                                          const SizedBox(height: 10),
                                          SvgPicture.asset(
                                            AppIcons.cross,
                                            width: 25,
                                            color: Colors.red.shade600,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            '${playerStats!.lose}',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          const Text('Victórias'),
                                          const SizedBox(height: 10),
                                          SvgPicture.asset(
                                            AppIcons.medal,
                                            width: 25,
                                            color: Colors.green.shade600,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            '${playerStats!.win}',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          const Text('Empates'),
                                          const SizedBox(height: 10),
                                          SvgPicture.asset(
                                            AppIcons.minus,
                                            width: 25,
                                            color: Colors.orange.shade600,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            '${playerStats!.draw}',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: AssetImage(AppImages.design1),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Amarelos',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                          const SizedBox(height: 10),
                                          SvgPicture.asset(
                                            AppIcons.yellowSquare,
                                            width: 25,
                                            // color: Colors.yellow.shade600,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            '${playerStats!.yellowCards}',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: AssetImage(AppImages.design1),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Vermelhos',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                          const SizedBox(height: 10),
                                          SvgPicture.asset(
                                            AppIcons.redSquare,
                                            width: 25,
                                            // color: Colors.yellow.shade600,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            '${playerStats!.redCards}',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }
}
