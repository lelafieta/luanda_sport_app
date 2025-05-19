import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:luanda_sport_app/src/core/usecases/base_usecases.dart';
import 'package:luanda_sport_app/src/features/teams/domain/usecases/get_my_teams_usecase.dart';

import '../../../domain/entities/team_entity.dart';

part 'team_fetch_state.dart';

class TeamFetchCubit extends Cubit<TeamFetchState> {
  final GetMyTeamsUseCase getMyTeamsUseCase;
  TeamFetchCubit({required this.getMyTeamsUseCase}) : super(TeamFetchInitial());

  Future<void> getMyTeams() async {
    emit(TeamFetchLoading());

    final result = await getMyTeamsUseCase.call(NoParams());

    result.fold((failure) => emit(TeamFetchFailure(error: failure.message)),
        (teams) => emit(TeamFetchLoaded(teams: teams)));
  }
}
