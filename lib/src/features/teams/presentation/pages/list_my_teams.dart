import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luanda_sport_app/src/config/routes/app_routes.dart';
import 'package:luanda_sport_app/src/features/teams/domain/entities/team_entity.dart';
import 'package:get/get.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import '../cubit/team_fetch_cubit/team_fetch_cubit.dart';

class ListMyTeamsPage extends StatelessWidget {
  const ListMyTeamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Minhas Equipas"),
      ),
      body: Column(
        children: [
          Expanded(
            child: DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  Container(
                    color: AppColors.primary,
                    child: TabBar(
                      labelColor: AppColors.white,
                      unselectedLabelColor: Colors.white60,
                      indicatorColor: AppColors.white,
                      isScrollable: true,
                      padding: EdgeInsets.zero,
                      tabAlignment: TabAlignment.center,
                      tabs: [
                        const Tab(text: "Todos"),
                        Tab(
                          child: Row(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.red,
                                ),
                                child: const Center(
                                  child: Text(
                                    "2",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              const Text("Notificações"),
                            ],
                          ),
                        ),
                        Tab(text: "Rascunho"),
                        Tab(text: "Mídia"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _listAllTeams(),
                        Center(child: Text("Torneios ativos")),
                        Center(child: Text("Torneios encerrados")),
                        Center(child: Text("Torneios favoritos")),
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

  Widget _listAllTeams() {
    return BlocBuilder<TeamFetchCubit, TeamFetchState>(
      builder: (context, state) {
        if (state is TeamFetchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TeamFetchFailure) {
          return Center(
            child: Text("ERRORRRR ${state.error}"),
          );
        } else if (state is TeamFetchLoaded) {
          final teams = state.teams;
          return ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount:
                teams.length, // Replace with the actual number of competitions
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final team = teams.elementAt(index);
              return TeamProfileWidget(team: team);
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}

class TeamProfileWidget extends StatelessWidget {
  const TeamProfileWidget({
    super.key,
    required this.team,
  });

  final TeamEntity team;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Map<dynamic, String?> arguments = {
          "pageParams": "teams",
          "componentId": team.id.toString()
        };
        Get.toNamed(AppRoutes.luandaSport, arguments: arguments);
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: (team.logoUrl == null || team.logoUrl!.isEmpty)
                    ? SvgPicture.asset(AppIcons.security)
                    : CachedNetworkImage(
                        imageUrl: team.logoUrl!,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
              ),
              title: Text(
                '${team.name}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.marker,
                      width: 16,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text("${team.location}"),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    AppIcons.link,
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {
                    // Add share functionality here
                  },
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    AppIcons.facebook,
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {
                    // Add Facebook share functionality here
                  },
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    AppIcons.whatsapp,
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {
                    // Add WhatsApp share functionality here
                  },
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    AppIcons.instagram,
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {
                    // Add copy link functionality here
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '03',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Competições',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '8',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Jogadores',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '0',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Troféos',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
