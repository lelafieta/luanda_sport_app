import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luanda_sport_app/src/features/adepts/presentation/pages/adept_page.dart';
import 'package:luanda_sport_app/src/features/competitions/presentation/pages/my_competition_details_page.dart';
import 'package:luanda_sport_app/src/features/competitions/presentation/pages/list_my_competitions_page.dart';
import 'package:luanda_sport_app/src/features/teams/presentation/pages/list_my_teams.dart';
import 'package:luanda_sport_app/src/features/teams/presentation/pages/team_deatils_page.dart';

import '../../players/presentation/pages/player_page.dart';
import '../../squads/presentation/cubit/squad_cubit.dart';
import '../../teams/presentation/cubit/get_one_team_cubit/get_one_team_cubit.dart';

class HomePage extends StatefulWidget {
  final Map<dynamic, String?>? arguments;
  const HomePage({super.key, this.arguments});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    if (widget.arguments!["pageParams"] == "teams") {
      final teamId = widget.arguments!["componentId"] as String;
      context.read<GetOneTeamCubit>().getOneTeam(teamId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (widget.arguments == null) {
      content = const MyCompetitionDetailsPage();
    } else {
      switch (widget.arguments!["pageParams"]) {
        case "players":
          content = const PlayerPage();
          break;
        case "teams":
          content = BlocBuilder<GetOneTeamCubit, GetOneTeamState>(
            builder: (context, state) {
              if (state is GetOneTeamLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetOneTeamLoaded) {
                final team = state.team;
                return TeamDetailsPage(team: team!);
              } else if (state is GetOneTeamFailure) {
                return Center(child: Text('Error: ${state.error}'));
              } else {
                return const Center(child: Text('Unexpected state'));
              }
            },
          );
          break;
        case "2":
          content = const Center(child: Text('Tela 2'));

        case "adepts":
          content = AdeptPage();
          break;
        default:
          content = const Center(child: Text('Tela padrão'));
      }
    }

    return Scaffold(
      body: content,
    );
  }
}
