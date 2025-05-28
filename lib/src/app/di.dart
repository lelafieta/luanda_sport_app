import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:luanda_sport_app/src/features/call_ups/domain/usecases/get_call_ups_by_coach_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:luanda_sport_app/src/features/players/presentation/cubit/call_up_response/call_up_response_cubit.dart';
import 'package:luanda_sport_app/src/features/players/presentation/cubit/player_call_up/player_call_up_cubit.dart';
import 'package:luanda_sport_app/src/features/players/presentation/cubit/player_match/player_match_cubit.dart';
import 'package:luanda_sport_app/src/features/players/presentation/cubit/player_training_session/player_training_session_cubit.dart';
import 'package:luanda_sport_app/src/features/training_sessions/domain/usecases/create_training_session_usecase.dart';
import 'package:luanda_sport_app/src/features/training_sessions/domain/usecases/delete_training_session_usecase.dart';
import 'package:luanda_sport_app/src/features/training_sessions/domain/usecases/get_training_sessions_for_team_usecase.dart';
import 'package:luanda_sport_app/src/features/training_sessions/presentation/cubits/training_session/training_session_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/cache/i_secure_storage_helper.dart';
import '../core/cache/secure_storage_helper.dart';
import '../features/auth/data/datasources/auth_remote_datasource.dart';
import '../features/auth/data/datasources/i_auth_remote_datasource.dart';
import '../features/auth/data/repositories/auth_repository.dart';
import '../features/auth/domain/repositories/i_auth_repository.dart';
import '../features/auth/domain/usecases/is_logged_in_usecase.dart';
import '../features/auth/domain/usecases/login_usecase.dart';
import '../features/auth/presentation/cubit/auth_cubit.dart';
import '../features/call_ups/data/datasources/call_up_datasource.dart';
import '../features/call_ups/data/datasources/i_call_up_datasource.dart';
import '../features/call_ups/data/repositories/call_up_repository.dart';
import '../features/call_ups/domain/repositories/i_call_up_repository.dart';
import '../features/call_ups/domain/usecases/cancel_call_up_usecase.dart';
import '../features/call_ups/domain/usecases/create_call_up_usecase.dart';
import '../features/call_ups/domain/usecases/delete_call_up_usecase.dart';
import '../features/call_ups/domain/usecases/get_call_ups_by_player_pending_usecase.dart';
import '../features/call_ups/domain/usecases/get_call_ups_by_player_usecase.dart';
import '../features/call_ups/domain/usecases/update_call_up_status_usecase.dart';
import '../features/call_ups/presentation/cubit/call_up_action/call_up_action_cubit.dart';
import '../features/call_ups/presentation/cubit/call_up_cubit.dart';
import '../features/matches/data/datasources/i_match_datasource.dart';
import '../features/matches/data/datasources/match_datasource.dart';
import '../features/matches/data/repositories/match_repository.dart';
import '../features/matches/domain/repositories/i_match_repository.dart';
import '../features/matches/domain/usecases/assign_players_to_match_usecase.dart';
import '../features/matches/domain/usecases/create_match_usecase.dart';
import '../features/matches/domain/usecases/delete_match_usecase.dart';
import '../features/matches/domain/usecases/generate_match_report_usecase.dart';
import '../features/matches/domain/usecases/get_all_matches_usecase.dart';
import '../features/matches/domain/usecases/get_latest_matches_usecase.dart';
import '../features/matches/domain/usecases/get_match_by_id_usecase.dart';
import '../features/matches/domain/usecases/get_match_events_usecase.dart';
import '../features/matches/domain/usecases/get_match_stats_usecase.dart';
import '../features/matches/domain/usecases/get_matches_by_player_usecase.dart';
import '../features/matches/domain/usecases/get_matches_by_team_usecase.dart';
import '../features/matches/domain/usecases/get_top_scorers_in_match_usecase.dart';
import '../features/matches/domain/usecases/get_up_coming_matches_by_player_usecase.dart';
import '../features/matches/domain/usecases/get_upcoming_matches_usecase.dart';
import '../features/matches/domain/usecases/search_matches_usecase.dart';
import '../features/matches/domain/usecases/set_match_score_usecase.dart';
import '../features/matches/domain/usecases/update_match_usecase.dart';
import '../features/player_teams/data/datasources/i_player_team_datasource.dart';
import '../features/player_teams/data/datasources/player_team_datasource.dart';
import '../features/player_teams/data/repositories/player_team_repository.dart';
import '../features/player_teams/domain/repositories/i_player_team_repository.dart';
import '../features/player_teams/domain/usecases/create_player_team_usecase.dart';
import '../features/player_teams/domain/usecases/get_player_teams_usecase.dart';
import '../features/player_teams/presentation/cubit/player_team_cubit.dart';
import '../features/players/data/datasources/i_player_datasource.dart';
import '../features/players/data/datasources/i_player_stats_datasource.dart';
import '../features/players/data/datasources/player_datasource.dart';
import '../features/players/data/datasources/player_stats_datasource.dart';
import '../features/players/data/repositories/player_repository.dart';
import '../features/players/data/repositories/player_stats_repository.dart';
import '../features/players/domain/repositories/i_player_repository.dart';
import '../features/players/domain/repositories/i_player_stats_repository.dart';
import '../features/players/domain/usecases/create_player_stats_usecase.dart';
import '../features/players/domain/usecases/create_player_usecase.dart';
import '../features/players/domain/usecases/delete_player_stats_usecase.dart';
import '../features/players/domain/usecases/delete_player_usecase.dart';
import '../features/players/domain/usecases/get_player_by_id_usecase.dart';
import '../features/players/domain/usecases/get_player_stats_by_id_usecase.dart';
import '../features/players/domain/usecases/get_player_stats_by_team_usecase.dart';
import '../features/players/domain/usecases/get_players_by_team_usecase.dart';
import '../features/players/domain/usecases/update_player_stats_usecase.dart';
import '../features/players/domain/usecases/update_player_usecase.dart';
import '../features/players/presentation/cubit/fetch_player_stats/fetch_player_stats_cubit.dart';
import '../features/players/presentation/cubit/fetch_players_team/fetch_players_team_cubit.dart';
import '../features/players/presentation/cubit/get_my_player_data/get_my_player_data_cubit.dart';
import '../features/players/presentation/cubit/player_upcoming_match/player_upcoming_match_cubit.dart';
import '../features/squads/data/datasources/i_squad_datasource.dart';
import '../features/squads/data/datasources/squad_datasource.dart';
import '../features/squads/data/repositories/squad_repository.dart';
import '../features/squads/domain/repositories/squad_repository.dart';
import '../features/squads/domain/usecases/create_squad_usecase.dart';
import '../features/squads/domain/usecases/get_squad_by_game_type_formation_usecase.dart';
import '../features/squads/domain/usecases/get_squads_by_team_usecase.dart';
import '../features/squads/presentation/cubit/squad_cubit.dart';
import '../features/teams/data/datasources/i_starting_lineup_player_datasource.dart';
import '../features/teams/data/datasources/i_team_datasource.dart';
import '../features/teams/data/datasources/starting_lineup_player_datasource.dart';
import '../features/teams/data/datasources/team_datasource.dart';
import '../features/teams/data/repositories/starting_lineup_player_repository.dart';
import '../features/teams/data/repositories/team_repository.dart';
import '../features/teams/domain/repositories/i_starting_lineup_player_repository.dart';
import '../features/teams/domain/repositories/i_team_repository.dart';
import '../features/teams/domain/usecases/create_starting_lineup_players_usecase.dart';
import '../features/teams/domain/usecases/create_team_usecase.dart';
import '../features/teams/domain/usecases/delete_squad_team_usecase.dart';
import '../features/teams/domain/usecases/delete_team_usecase.dart';
import '../features/teams/domain/usecases/get_my_teams_usecase.dart';
import '../features/teams/domain/usecases/get_team_by_id_usecase.dart';
import '../features/teams/domain/usecases/get_team_starting_lineup_players_usecase.dart';
import '../features/teams/domain/usecases/get_team_tactical_formation_usecase.dart';
import '../features/teams/domain/usecases/get_teams_usecase.dart';
import '../features/teams/domain/usecases/remove_starting_lineup_player_usecase.dart';
import '../features/teams/domain/usecases/update_team_squad_usecase.dart';
import '../features/teams/domain/usecases/update_team_usecase.dart';
import '../features/teams/presentation/cubit/action_team_squad_cubit/action_team_squad_cubit.dart';
import '../features/teams/presentation/cubit/get_one_team_cubit/get_one_team_cubit.dart';
import '../features/teams/presentation/cubit/get_team_equipament_cubit/get_team_equipament_cubit.dart';
import '../features/teams/presentation/cubit/starting_lineup_player_cubit/starting_lineup_player_cubit.dart';
import '../features/teams/presentation/cubit/team_action_cubit/team_action_cubit.dart';
import '../features/teams/presentation/cubit/team_fetch_cubit/team_fetch_cubit.dart';
import '../features/training_sessions/data/datasources/i_training_session_datasource.dart';
import '../features/training_sessions/data/datasources/training_session_datasource.dart';
import '../features/training_sessions/data/repositories/training_session_repository.dart';
import '../features/training_sessions/domain/repositories/i_training_session_repository.dart';
import '../features/trophies/data/datasources/i_trophy_datasource.dart';
import '../features/trophies/data/datasources/trophy_datasource.dart';
import '../features/trophies/data/repositories/trophy_repository.dart';
import '../features/trophies/domain/repositories/i_trophy_repository.dart';
import '../features/trophies/domain/usecases/create_trophy_usecase.dart';
import '../features/trophies/domain/usecases/delete_trophy_usecase.dart';
import '../features/trophies/domain/usecases/get_trophies_by_team_usecase.dart';
import '../features/trophies/domain/usecases/get_trophies_usecase.dart';
import '../features/trophies/domain/usecases/get_trophy_by_id_usecase.dart';
import '../features/trophies/domain/usecases/update_tropy_usecase.dart';
import '../features/trophies/presentation/cubit/fetch_trophies_team_cubit/fetch_trophies_team_cubit.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

GetIt sl = GetIt.instance;

Future<void> init() async {
  await _initSupabase();
  _registerCubits();
  _registerRepositories();
  _registerDatasources();
  _registerUseCases();
  _registerExternal();
}

Future<void> _initSupabase() async {
  final supabaseUrl = dotenv.env["SUPABASE_URL"];
  final supabaseAnon = dotenv.env["SUPABASE_ANON"];
  await Supabase.initialize(
    url: supabaseUrl!,
    anonKey: supabaseAnon!,
  );
  final supabase = Supabase.instance.client;
  sl.registerLazySingleton(() => supabase);
}

void _registerCubits() {
  // Registre seus Cubits aqui
  // Exemplo: sl.registerFactory(() => YourCubit(sl()));
  sl.registerFactory(() => AuthCubit(
      loginUseCase: sl(), isLoggedInUseCase: sl(), secureStorageHelper: sl()));
  // TEAM
  sl.registerFactory(
      () => TeamActionCubit(createTeamUseCase: sl(), updateTeamUseCase: sl()));
  sl.registerFactory(() => TeamFetchCubit(getMyTeamsUseCase: sl()));
  sl.registerFactory(() => GetOneTeamCubit(getTeamByIdUseCase: sl()));
  sl.registerFactory(() => GetTeamEquipamentCubit(getTeamByIdUseCase: sl()));

  sl.registerFactory(() => ActionTeamSquadCubit(
      createTeamUseCase: sl(), updateTeamSquadUseCase: sl()));

  //PLAYER
  sl.registerFactory(
      () => FetchPlayersTeamCubit(getPlayersByTeamUseCase: sl()));
  sl.registerFactory(() => GetMyPlayerDataCubit(getPlayerByIdUseCase: sl()));
  sl.registerFactory(() => FetchPlayerStatsCubit(
      getPlayerStatsByIdUseCase: sl(), getPlayerStatsByTeamUseCase: sl()));

  sl.registerFactory(() => PlayerCallUpCubit(getCallUpsByPlayerUseCase: sl()));
  sl.registerFactory(() => PlayerMatchCubit(getMatchesByPlayerUseCase: sl()));

  // TROPHY
  sl.registerFactory(
      () => FetchTrophiesTeamCubit(getTrophiesByTeamUseCase: sl()));

  // SQUAD
  sl.registerFactory(() => SquadCubit(
      createSquadUseCase: sl(),
      getSquadsByTeamUseCase: sl(),
      getSquadByGameTypeFormationUseCase: sl()));

  // STARTING LINEUP PLAYERS
  sl.registerFactory(() => StartingLineupPlayerCubit(
      createTeamStartingLineupPlayersUseCase: sl(),
      getTeamStartingLineupPlayersUseCase: sl(),
      removeStartingLineupPlayerUseCase: sl(),
      deleteSquadTeamUseCase: sl()));

  // PLAYER TEAM
  sl.registerFactory(() => PlayerTeamCubit(
        getPlayerTeamUseCase: sl(),
        createPlayerTeamUseCase: sl(),
      ));

  // CALL UP
  sl.registerFactory(() => CallUpActionCubit(
      createCallUpUseCase: sl(),
      cancelCallUpUseCase: sl(),
      updateCallUpStatusUseCase: sl(),
      deleteCallUpUseCase: sl()));

  sl.registerFactory(() => CallUpCubit(
      getCallUpByCoachUseCase: sl(),
      getCallUpByPlayerUseCase: sl(),
      getCallUpByPlayerPendingUseCase: sl()));

  sl.registerFactory(
      () => CallUpResponseCubit(updateCallUpStatusUseCase: sl()));

  sl.registerFactory(
      () => PlayerUpcomingMatchCubit(getUpComingMatchesByPlayerUseCase: sl()));

  // TRAINNING SESSION

  sl.registerFactory(() => TrainingSessionCubit(
      getTrainingSessionsForTeamUseCase: sl(),
      createTrainingSessionUseCase: sl(),
      deleteTrainingSessionUseCase: sl()));
}

void _registerRepositories() {
  // Registre seus repositórios aqui
  // Exemplo: sl.registerLazySingleton(() => YourRepository(sl()));
  sl.registerLazySingleton<IAuthRepository>(
      () => AuthRepository(authRemoteDataSource: sl()));
  // TEAM
  sl.registerLazySingleton<ITeamRepository>(
      () => TeamRepository(teamDatasource: sl()));

  //PLAYER
  sl.registerLazySingleton<IPlayerRepository>(
      () => PlayerRepository(playerDataSource: sl()));
  sl.registerLazySingleton<IPlayerStatsRepository>(
      () => PlayerStatsRepository(playerStatsDataSource: sl()));
  // TROPHY
  sl.registerLazySingleton<ITrophyRepository>(
      () => TrophyRepository(trophyDataSource: sl()));

  // SQUAD
  sl.registerLazySingleton<ISquadRepository>(
      () => SquadRepository(squadDataSource: sl()));

  // STARTING LINEUP PLAYERS
  sl.registerLazySingleton<IStartingLineupPlayerRepository>(() =>
      StartingLineupPlayerRepository(startingLineupPlayerDataSource: sl()));

  // PLAYER TEAM
  sl.registerLazySingleton<IPlayerTeamRepository>(
      () => PlayerTeamRepository(playerTeamDataSource: sl()));

  // CALL UP
  sl.registerLazySingleton<ICallUpRepository>(
      () => CallUpRepository(callUpDataSource: sl()));

  // MATCH
  sl.registerLazySingleton<IMatchRepository>(
      () => MatchRepository(matchDataSource: sl()));

  // TRAINNING SESSION
  sl.registerLazySingleton<ITrainingSessionRepository>(
      () => TrainingSessionRepository(dataSource: sl()));
}

void _registerDatasources() {
  // Registre seus datasources aqui
  // Exemplo: sl.registerLazySingleton(() => YourDatasource(sl()));

  sl.registerLazySingleton<IAuthRemoteDataSource>(
      () => AuthRemoteDataSource(client: sl()));
  // TEAM
  sl.registerLazySingleton<ITeamRemoteDataSource>(
      () => TeamRemoteDataSource(client: sl()));
  // PLAYER
  sl.registerLazySingleton<IPlayerRemoteDataSource>(
      () => PlayerRemoteDataSource(client: sl()));

  sl.registerLazySingleton<IPlayerStatsRemoteDataSource>(
      () => PlayerStatsRemoteDataSource(client: sl()));

  // TROPHY
  sl.registerLazySingleton<ITrophyRemoteDataSource>(
      () => TrophyRemoteDataSource(client: sl()));

  // SQUAD
  sl.registerLazySingleton<ISquadRemoteDataSource>(
      () => SquadRemoteDataSource(client: sl()));

  // STARTING LINEUP PLAYERS
  sl.registerLazySingleton<IStartingLineupPlayerRemoteDataSource>(
      () => StartingLineupPlayerRemoteDataSource(client: sl()));

  // PLAYER TEAM
  sl.registerLazySingleton<IPlayerTeamRemoteDataSource>(
      () => PlayerTeamRemoteDataSource(client: sl()));

  // CALL UP
  sl.registerLazySingleton<ICallUpRemoteDataSource>(
      () => CallUpRemoteDataSource(client: sl()));

  // MATCH
  sl.registerLazySingleton<IMatchRemoteDataSource>(
      () => MatchRemoteDataSource(client: sl()));

  // TRAINNING SESSION
  sl.registerLazySingleton<ITrainingSessionDataSource>(
      () => TrainingSessionDataSource(client: sl()));
}

void _registerUseCases() {
  // Registre seus casos de uso aqui
  // Exemplo: sl.registerLazySingleton(() => YourUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => IsLoggedInUseCase(authRepository: sl()));
  // TEAM
  sl.registerLazySingleton(() => CreateTeamUseCase(teamRepository: sl()));
  sl.registerLazySingleton(() => UpdateTeamUseCase(teamRepository: sl()));
  sl.registerLazySingleton(() => GetTeamsUseCase(teamRepository: sl()));
  sl.registerLazySingleton(() => GetTeamByIdUseCase(teamRepository: sl()));
  sl.registerLazySingleton(() => GetMyTeamsUseCase(teamRepository: sl()));
  sl.registerLazySingleton(() => DeleteTeamUseCase(teamRepository: sl()));
  sl.registerLazySingleton(() => UpdateTeamSquadUseCase(teamRepository: sl()));

  // PLAYER
  sl.registerLazySingleton(() => CreatePlayerUseCase(playerRepository: sl()));
  sl.registerLazySingleton(() => DeletePlayerUseCase(playerRepository: sl()));
  sl.registerLazySingleton(() => GetPlayerByIdUseCase(playerRepository: sl()));
  sl.registerLazySingleton(
      () => GetPlayersByTeamUseCase(playerRepository: sl()));
  sl.registerLazySingleton(() => UpdatePlayerUseCase(playerRepository: sl()));
  sl.registerLazySingleton(
      () => GetTeamTacticalFormationUseCase(teamRepository: sl()));
  sl.registerLazySingleton(
      () => CreatePlayerStatsUseCase(playerStatsRepository: sl()));
  sl.registerLazySingleton(
      () => GetPlayerStatsByIdUseCase(playerStatsRepository: sl()));
  sl.registerLazySingleton(
      () => GetPlayerStatsByTeamUseCase(playerStatsRepository: sl()));
  sl.registerLazySingleton(
      () => UpdatePlayerStatsUseCase(playerStatsRepository: sl()));

  sl.registerLazySingleton(
      () => DeletePlayerStatsUseCase(playerStatsRepository: sl()));

  // TROPHY
  sl.registerLazySingleton(() => CreateTrophyUseCase(trophyRepository: sl()));
  sl.registerLazySingleton(() => DeleteTrophyUseCase(trophyRepository: sl()));
  sl.registerLazySingleton(
      () => GetTrophiesByTeamUseCase(trophyRepository: sl()));
  sl.registerLazySingleton(() => GetTrophiesUseCase(trophyRepository: sl()));
  sl.registerLazySingleton(() => GetTrophyByIdUseCase(trophyRepository: sl()));
  sl.registerLazySingleton(() => UpdateTrophyUseCase(trophyRepository: sl()));

  // SQUAD
  sl.registerLazySingleton(() => CreateSquadUseCase(squadRepository: sl()));
  sl.registerLazySingleton(() => GetSquadsByTeamUseCase(squadRepository: sl()));
  sl.registerLazySingleton(
      () => GetSquadByGameTypeFormationUseCase(squadRepository: sl()));

  // STARTING LINEUP PLAYERS
  sl.registerLazySingleton(() => GetTeamStartingLineupPlayersUseCase(
      startingLineupPlayerRepository: sl()));
  sl.registerLazySingleton(() => CreateTeamStartingLineupPlayersUseCase(
      startingLineupPlayerRepository: sl()));
  sl.registerLazySingleton(() =>
      RemoveStartingLineupPlayerUseCase(startingLineupPlayerRepository: sl()));

  sl.registerLazySingleton(
      () => DeleteSquadTeamUseCase(startingLineupPlayerRepository: sl()));

  // PLAYER TEAM
  sl.registerLazySingleton(
      () => GetPlayerTeamsUseCase(playerTeamRespository: sl()));
  sl.registerLazySingleton(
      () => CreatePlayerTeamUseCase(playerTeamRespository: sl()));

  // CALL UP
  sl.registerLazySingleton(() => CreateCallUpUseCase(callUpRepository: sl()));
  sl.registerLazySingleton(() => CancelCallUpUseCase(callUpRepository: sl()));
  sl.registerLazySingleton(() => DeleteCallUpUseCase(callUpRepository: sl()));
  sl.registerLazySingleton(
      () => GetCallUpsByCoachUseCase(callUpRepository: sl()));
  sl.registerLazySingleton(
      () => GetCallUpsByPlayerUseCase(callUpRepository: sl()));
  sl.registerLazySingleton(
      () => UpdateCallUpStatusUseCase(callUpRepository: sl()));
  sl.registerLazySingleton(
      () => GetCallUpsByPlayerPendingUseCase(callUpRepository: sl()));

  // MATCH
  sl.registerLazySingleton(() => AssignPlayersToMatchUseCase(repository: sl()));
  sl.registerLazySingleton(() => CreateMatchUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteMatchUseCase(repository: sl()));
  sl.registerLazySingleton(() => GenerateMatchReportUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAllMatchesUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetLatestMatchesUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetMatchByIdUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetMatchEventsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetMatchStatsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetMatchesByPlayerUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetMatchesByTeamUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetTopScorersInMatchUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => GetUpComingMatchesByPlayerUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUpcomingMatchesUseCase(repository: sl()));
  sl.registerLazySingleton(() => SearchMatchesUseCase(repository: sl()));
  sl.registerLazySingleton(() => SetMatchScoreUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateMatchUseCase(repository: sl()));

  // TRAINMIMG SESSION
  sl.registerLazySingleton(
      () => GetTrainingSessionsForTeamUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => CreateTrainingSessionUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => DeleteTrainingSessionUseCase(repository: sl()));
}

void _registerExternal() {
  // Registre dependências externas aqui
  // Exemplo: sl.registerLazySingleton(() => YourExternalService());

  sl.registerLazySingleton<ISecureStorageHelper>(
      () => SecureStorageHelper(secureStorage: sl()));
  sl.registerLazySingleton(() => const FlutterSecureStorage());
}
