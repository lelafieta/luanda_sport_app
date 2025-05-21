import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/player_team_entity.dart';
import '../../domain/params/create_player_team_params.dart';
import '../../domain/usecases/create_player_team_usecase.dart';
import '../../domain/usecases/get_player_teams_usecase.dart';

part 'player_team_state.dart';

class PlayerTeamCubit extends Cubit<PlayerTeamState> {
  final GetPlayerTeamUseCase getPlayerTeamUseCase;
  final CreatePlayerTeamUseCase createPlayerTeamUseCase;
  PlayerTeamCubit({
    required this.getPlayerTeamUseCase,
    required this.createPlayerTeamUseCase,
  }) : super(PlayerTeamInitial());

  Future<void> getPlayerTeams(String playerId) async {
    emit(PlayerTeamLoading());
    final result = await getPlayerTeamUseCase(playerId);
    result.fold(
      (failure) => emit(PlayerTeamFailure(error: failure.message)),
      (playerTeams) => emit(PlayerTeamLoaded(playerTeams: playerTeams)),
    );
  }

  Future<void> createPlayerTeam(
      {required String playerId, required String teamId}) async {
    emit(PlayerTeamLoading());
    final result = await createPlayerTeamUseCase(
        CreatePlayerTeamParams(playerId: playerId, teamId: teamId));
    result.fold(
      (failure) => emit(PlayerTeamFailure(error: failure.message)),
      (success) => emit(PlayerTeamSuccess()),
    );
  }
}
