import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/player_stats_entity.dart';
import '../../../domain/params/player_stats_params.dart';
import '../../../domain/usecases/get_player_stats_by_id_usecase.dart';
import '../../../domain/usecases/get_player_stats_by_team_usecase.dart';

part 'fetch_player_stats_state.dart';

class FetchPlayerStatsCubit extends Cubit<FetchPlayerStatsState> {
  final GetPlayerStatsByIdUseCase getPlayerStatsByIdUseCase;
  final GetPlayerStatsByTeamUseCase getPlayerStatsByTeamUseCase;

  FetchPlayerStatsCubit({
    required this.getPlayerStatsByIdUseCase,
    required this.getPlayerStatsByTeamUseCase,
  }) : super(FetchPlayerStatsInitial());

  Future<void> fetchPlayerStatsById(String playerId) async {
    emit(FetchPlayerStatsLoading());
    final result = await getPlayerStatsByIdUseCase(playerId);
    result.fold(
      (failure) => emit(FetchPlayerStatsFailure(error: failure.message)),
      (playerStats) => emit(FetchPlayerStatsLoaded(playerStats: playerStats)),
    );
  }

  Future<void> fetchPlayerStatsByTeam(String teamId, String playerId) async {
    emit(FetchPlayerStatsLoading());
    final result = await getPlayerStatsByTeamUseCase(PlayerStatsParams(
      teamId: teamId,
      playerId: playerId,
    ));
    result.fold(
      (failure) => emit(FetchPlayerStatsFailure(error: failure.message)),
      (playerStats) => emit(FetchPlayerStatsLoaded(playerStats: playerStats)),
    );
  }
}
