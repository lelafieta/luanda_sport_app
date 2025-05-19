import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:luanda_sport_app/src/features/teams/domain/usecases/get_team_by_id_usecase.dart';

import '../../../domain/entities/team_entity.dart';

part 'get_team_equipament_state.dart';

class GetTeamEquipamentCubit extends Cubit<GetTeamEquipamentState> {
  final GetTeamByIdUseCase getTeamByIdUseCase;
  GetTeamEquipamentCubit({required this.getTeamByIdUseCase})
      : super(GetTeamEquipamentInitial());

  Future<void> getTeamEquipament(String teamId) async {
    emit(GetTeamEquipamentLoading());

    final result = await getTeamByIdUseCase.call(teamId);

    result.fold(
        (failure) => emit(GetTeamEquipamentFailure(error: failure.message)),
        (team) => emit(GetTeamEquipamentLoaded(team: team)));
  }
}
