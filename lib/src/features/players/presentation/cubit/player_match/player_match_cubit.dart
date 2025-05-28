import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../matches/domain/entities/match_entity.dart';
import '../../../../matches/domain/usecases/get_matches_by_player_usecase.dart';
part 'player_match_state.dart';

class PlayerMatchCubit extends Cubit<PlayerMatchState> {
  final GetMatchesByPlayerUseCase getMatchesByPlayerUseCase;

  PlayerMatchCubit({
    required this.getMatchesByPlayerUseCase,
  }) : super(PlayerMatchInitial());

  Future<void> getMatchesByPlayer(String playerId) async {
    emit(PlayerMatchLoading());

    final result = await getMatchesByPlayerUseCase(playerId);

    result.fold(
      (failure) => emit(PlayerMatchFailure(error: failure.message)),
      (matches) => emit(PlayerMatchLoaded(playerMatches: matches)),
    );
  }
}
