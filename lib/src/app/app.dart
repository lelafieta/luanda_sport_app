import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:luanda_sport_app/src/features/call_ups/presentation/cubit/call_up_action/call_up_action_cubit.dart';
import 'package:luanda_sport_app/src/features/call_ups/presentation/cubit/call_up_cubit.dart';
import 'package:luanda_sport_app/src/features/players/presentation/cubit/player_match/player_match_cubit.dart';
import 'package:luanda_sport_app/src/features/players/presentation/cubit/player_upcoming_match/player_upcoming_match_cubit.dart';
import 'package:luanda_sport_app/src/features/training_sessions/presentation/cubits/training_session/training_session_cubit.dart';

import '../config/routes/app_pages.dart';
import '../config/themes/app_theme.dart';
import '../features/auth/presentation/cubit/auth_cubit.dart';
import '../features/player_teams/presentation/cubit/player_team_cubit.dart';
import '../features/players/presentation/cubit/activity/activity_cubit.dart';
import '../features/players/presentation/cubit/call_up_response/call_up_response_cubit.dart';
import '../features/players/presentation/cubit/fetch_player_stats/fetch_player_stats_cubit.dart';
import '../features/players/presentation/cubit/fetch_players_team/fetch_players_team_cubit.dart';
import '../features/players/presentation/cubit/get_my_player_data/get_my_player_data_cubit.dart';
import '../features/players/presentation/cubit/player_call_up/player_call_up_cubit.dart';
import '../features/squads/presentation/cubit/squad_cubit.dart';
import '../features/teams/presentation/cubit/action_team_squad_cubit/action_team_squad_cubit.dart';
import '../features/teams/presentation/cubit/get_one_team_cubit/get_one_team_cubit.dart';
import '../features/teams/presentation/cubit/get_team_equipament_cubit/get_team_equipament_cubit.dart';
import '../features/teams/presentation/cubit/starting_lineup_player_cubit/starting_lineup_player_cubit.dart';
import '../features/teams/presentation/cubit/team_action_cubit/team_action_cubit.dart';
import '../features/teams/presentation/cubit/team_fetch_cubit/team_fetch_cubit.dart';
import '../features/trophies/presentation/cubit/fetch_trophies_team_cubit/fetch_trophies_team_cubit.dart';
import 'di.dart' as di;

class GameOnApp extends StatelessWidget {
  const GameOnApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => di.sl<AuthCubit>()),
          BlocProvider(create: (context) => di.sl<TeamActionCubit>()),
          BlocProvider(
              create: (context) => di.sl<TeamFetchCubit>()..getMyTeams()),
          BlocProvider(create: (context) => di.sl<GetOneTeamCubit>()),
          BlocProvider(create: (context) => di.sl<FetchPlayersTeamCubit>()),
          BlocProvider(create: (context) => di.sl<FetchTrophiesTeamCubit>()),
          BlocProvider(create: (context) => di.sl<GetTeamEquipamentCubit>()),
          BlocProvider(create: (context) => di.sl<SquadCubit>()),
          BlocProvider(create: (context) => di.sl<StartingLineupPlayerCubit>()),
          BlocProvider(create: (context) => di.sl<ActionTeamSquadCubit>()),
          BlocProvider(create: (context) => di.sl<GetMyPlayerDataCubit>()),
          BlocProvider(create: (context) => di.sl<FetchPlayerStatsCubit>()),
          BlocProvider(create: (context) => di.sl<PlayerTeamCubit>()),
          BlocProvider(create: (context) => di.sl<CallUpActionCubit>()),
          BlocProvider(create: (context) => di.sl<CallUpCubit>()),
          BlocProvider(create: (context) => di.sl<CallUpResponseCubit>()),
          BlocProvider(create: (context) => di.sl<PlayerUpcomingMatchCubit>()),
          BlocProvider(create: (context) => di.sl<PlayerMatchCubit>()),
          BlocProvider(create: (context) => di.sl<PlayerCallUpCubit>()),
          BlocProvider(create: (context) => di.sl<TrainingSessionCubit>()),
          BlocProvider(create: (context) => di.sl<ActivityCubit>()),
        ],
        child: GetMaterialApp(
          title: 'Luanda Sport',
          darkTheme: AppTheme.lightTheme,
          theme: AppTheme.lightTheme,
          onGenerateRoute: AppPages.generateRoute,
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
