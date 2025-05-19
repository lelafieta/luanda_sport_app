import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/team_entity.dart';
import '../../../domain/params/update_team_squad_params.dart';
import '../../../domain/usecases/create_team_usecase.dart';
import '../../../domain/usecases/update_team_squad_usecase.dart';
import '../../../domain/usecases/update_team_usecase.dart';

part 'action_team_squad_state.dart';

class ActionTeamSquadCubit extends Cubit<ActionTeamSquadState> {
  final CreateTeamUseCase createTeamUseCase;
  final UpdateTeamSquadUseCase updateTeamSquadUseCase;

  ActionTeamSquadCubit({
    required this.createTeamUseCase,
    required this.updateTeamSquadUseCase,
  }) : super(ActionTeamSquadInitial());

  Future<void> updateTeamSquad(
      String gameType, String formation, String teamId) async {
    emit(ActionTeamSquadLoading());

    final result = await updateTeamSquadUseCase.call(UpdateTeamSquadParams(
      teamId: teamId,
      gameType: gameType,
      formation: formation,
    ));

    result.fold(
        (failure) => emit(ActionTeamSquadFailure(error: failure.message)),
        (success) => emit(const ActionTeamSquadSuccess(message: "message")));
  }
}
