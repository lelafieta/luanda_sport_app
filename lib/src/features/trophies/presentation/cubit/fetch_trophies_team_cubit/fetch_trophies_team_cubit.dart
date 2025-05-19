import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/trophy_entity.dart';
import '../../../domain/usecases/get_trophies_by_team_usecase.dart';

part 'fetch_trophies_team_state.dart';

class FetchTrophiesTeamCubit extends Cubit<FetchTrophiesTeamState> {
  final GetTrophiesByTeamUseCase getTrophiesByTeamUseCase;
  FetchTrophiesTeamCubit({required this.getTrophiesByTeamUseCase})
      : super(FetchTrophiesTeamInitial());

  Future<void> fetchTrophiesByTeam(String teamId) async {
    emit(FetchTrophiesTeamLoading());
    final result = await getTrophiesByTeamUseCase(teamId);
    result.fold(
      (failure) => emit(FetchTrophiesTeamFailure(error: failure.message)),
      (trophies) => emit(FetchTrophiesTeamLoaded(trophies: trophies)),
    );
  }
}
