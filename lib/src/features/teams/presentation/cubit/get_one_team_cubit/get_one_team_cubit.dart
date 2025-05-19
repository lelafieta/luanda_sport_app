import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:luanda_sport_app/src/features/teams/domain/usecases/get_team_by_id_usecase.dart';

import '../../../domain/entities/team_entity.dart';

part 'get_one_team_state.dart';

class GetOneTeamCubit extends Cubit<GetOneTeamState> {
  final GetTeamByIdUseCase getTeamByIdUseCase;
  GetOneTeamCubit({required this.getTeamByIdUseCase})
      : super(GetOneTeamInitial());

  Future<void> getOneTeam(String id) async {
    emit(GetOneTeamLoading());
    final result = await getTeamByIdUseCase.call(id);

    result.fold((failure) => emit(GetOneTeamFailure(error: failure.message)),
        (team) => emit(GetOneTeamLoaded(team: team)));
  }
}
