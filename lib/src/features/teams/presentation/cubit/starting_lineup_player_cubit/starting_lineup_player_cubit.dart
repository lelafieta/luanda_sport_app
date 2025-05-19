import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luanda_sport_app/src/features/teams/domain/usecases/remove_starting_lineup_player_usecase.dart';
import '../../../../players/domain/entities/player_entity.dart';
import '../../../domain/entities/starting_lineup_player_entity.dart';
import '../../../domain/usecases/create_starting_lineup_players_usecase.dart';
import '../../../domain/usecases/delete_squad_team_usecase.dart';
import '../../../domain/usecases/get_team_starting_lineup_players_usecase.dart';
part 'starting_lineup_player_state.dart';

class StartingLineupPlayerCubit extends Cubit<StartingLineupPlayerState> {
  final CreateTeamStartingLineupPlayersUseCase
      createTeamStartingLineupPlayersUseCase;
  final GetTeamStartingLineupPlayersUseCase getTeamStartingLineupPlayersUseCase;
  final RemoveStartingLineupPlayerUseCase removeStartingLineupPlayerUseCase;
  final DeleteSquadTeamUseCase deleteSquadTeamUseCase;
  StartingLineupPlayerCubit(
      {required this.createTeamStartingLineupPlayersUseCase,
      required this.getTeamStartingLineupPlayersUseCase,
      required this.removeStartingLineupPlayerUseCase,
      required this.deleteSquadTeamUseCase})
      : super(StartingLineupPlayerInitial());

  Future<void> createStartingLineupPlayer(
      StartingLineupPlayersEntity startingLineupPlayers) async {
    // emit(StartingLineupPlayerLoading());

    final result = await createTeamStartingLineupPlayersUseCase
        .call(startingLineupPlayers);

    result.fold(
        (failure) => emit(StartingLineupPlayerFailure(error: failure.message)),
        (startingLineupPlayers) => emit(StartingLineupPlayerLoaded(
            startingLineupPlayers: startingLineupPlayers)));
  }

  Future<void> removeTeamPlayerStartingLineup(PlayerEntity player) async {
    final result = await removeStartingLineupPlayerUseCase.call(player);

    result.fold(
        (failure) => emit(StartingLineupPlayerFailure(error: failure.message)),
        (startingLineupPlayers) => emit(StartingLineupPlayerLoaded(
            startingLineupPlayers: startingLineupPlayers)));
  }

  Future<void> getTeamStartingLineupPlayers(String teamId) async {
    final result = await getTeamStartingLineupPlayersUseCase.call(teamId);

    result.fold(
        (failure) => emit(StartingLineupPlayerFailure(error: failure.message)),
        (startingLineupPlayers) => emit(StartingLineupPlayerLoaded(
            startingLineupPlayers: startingLineupPlayers)));
  }

  Future<void> deleteSquadTeamUse(String teamId) async {
    final result = await deleteSquadTeamUseCase.call(teamId);

    result.fold(
        (failure) => emit(StartingLineupPlayerFailure(error: failure.message)),
        (startingLineupPlayers) => emit(StartingLineupPlayerLoaded(
            startingLineupPlayers: startingLineupPlayers)));
  }
}
