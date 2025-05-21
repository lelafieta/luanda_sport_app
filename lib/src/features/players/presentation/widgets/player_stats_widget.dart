import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app/app_entity.dart';
import '../../../../core/resources/app_icons.dart';
import '../../../../core/resources/app_images.dart';
import '../../../player_teams/domain/entities/player_team_entity.dart';
import '../../../player_teams/presentation/cubit/player_team_cubit.dart';
import '../../domain/entities/player_stats_entity.dart';

class PlayerStatsWidget extends StatefulWidget {
  final PlayerStatsEntity playerStats;
  const PlayerStatsWidget({super.key, required this.playerStats});

  @override
  State<PlayerStatsWidget> createState() => _PlayerStatsWidgetState();
}

class _PlayerStatsWidgetState extends State<PlayerStatsWidget> {
  final dropDownKey = GlobalKey<DropdownSearchState>();
  PlayerTeamEntity? selectedTeam;
  String selectedTeamId = "";
  @override
  void initState() {
    selectedTeamId = widget.playerStats.teamId ?? '';
    context
        .read<PlayerTeamCubit>()
        .getPlayerTeams("9f829de7-50dc-4351-aff9-fc0d1c93cef2");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          BlocConsumer<PlayerTeamCubit, PlayerTeamState>(
            listener: (context, state) {
              if (state is PlayerTeamLoaded) {
                print("YAAA");
              }
            },
            builder: (context, state) {
              if (state is PlayerTeamLoaded) {
                var selectedTeam = state.playerTeams.firstWhere(
                  (team) => team.team?.id == selectedTeamId,
                );
                return DropdownSearch<PlayerTeamEntity>(
                  key: dropDownKey,
                  selectedItem: selectedTeam,
                  items: state.playerTeams,
                  onChanged: (team) {
                    setState(() {
                      selectedTeamId = team?.team?.id ?? '';
                      selectedTeam = team!;
                    });
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
                      return const Text("Selecione um time");
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
                          vertical: 16, horizontal: 20),
                      child: Center(
                        child: Text(
                          "Equipes de Passagem",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    itemBuilder: (context, item, isSelected) {
                      return Container(
                        color: selectedTeamId == item.team?.id
                            ? Theme.of(context)
                                .colorScheme
                                .primary
                                .withAlpha(50)
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
                          title: Text(item.team?.name ?? 'Time desconhecido'),
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

              return DropdownSearch<String>(
                key: dropDownKey,
                selectedItem: "Menu",
                items: const [
                  "Menu",
                  "Dialog",
                  "Modal",
                  "BottomSheet",
                  "Dialog",
                ],
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
                popupProps: PopupProps.dialog(
                  showSearchBox: false,
                  title: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    child: Center(
                      child: Text(
                        "Equipes de Passagem",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                  itemBuilder: (context, item, isSelected) {
                    return ListTile(
                      leading: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://template.canva.com/EAGP4Vom1pY/1/0/1600w-IOa8p4GmFqQ.jpg',
                          width: 40,
                          height: 40,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: const Text("Dourada FC"),
                      subtitle: const Text('Subtitle'),
                      selected: isSelected,
                    );
                  },
                  dialogProps: const DialogProps(
                      // Removido shape e backgroundColor para herdar o padrão do sistema
                      // Isso usa a borda padrão do sistema automaticamente
                      ),
                ),
              );
            },
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: SvgPicture.asset(
                    AppIcons.footballBall,
                    width: 25,
                  ),
                  title: const Text('Gols'),
                  trailing: Text(
                    '${widget.playerStats.goals}',
                    style: TextStyle(
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
                    '${widget.playerStats.assists}',
                    style: TextStyle(
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
                    '${widget.playerStats.match}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              '${widget.playerStats.lose}',
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
                              '${widget.playerStats.win}',
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
                              '${widget.playerStats.draw}',
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              '${widget.playerStats.yellowCards}',
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
                              '${widget.playerStats.redCards}',
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
          ),
        ],
      ),
    );
  }
}
