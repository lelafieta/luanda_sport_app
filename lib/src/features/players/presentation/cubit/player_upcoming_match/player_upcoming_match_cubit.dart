import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../matches/domain/entities/match_entity.dart';
import '../../../../matches/domain/usecases/get_up_coming_matches_by_player_usecase.dart';

part 'player_upcoming_match_state.dart';

class PlayerUpcomingMatchCubit extends Cubit<PlayerUpcomingMatchState> {
  final GetUpComingMatchesByPlayerUseCase getUpComingMatchesByPlayerUseCase;
  PlayerUpcomingMatchCubit({required this.getUpComingMatchesByPlayerUseCase})
      : super(PlayerUpcomingMatchInitial());

  Future<void> getUpComingMatchesByPlayer(String playerId) async {
    emit(PlayerUpcomingMatchLoading());
    final result = await getUpComingMatchesByPlayerUseCase(playerId);
    result.fold(
      (failure) => emit(PlayerUpcomingMatchFailure(error: failure.message)),
      (matches) => emit(PlayerUpcomingMatchLoaded(upcomingMatches: matches)),
    );
  }
}
