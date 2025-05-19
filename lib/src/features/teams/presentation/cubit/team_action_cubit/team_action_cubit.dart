import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/team_entity.dart';
import '../../../domain/usecases/create_team_usecase.dart';
import '../../../domain/usecases/update_team_usecase.dart';

part 'team_action_state.dart';

class TeamActionCubit extends Cubit<TeamActionState> {
  final CreateTeamUseCase createTeamUseCase;
  final UpdateTeamUseCase updateTeamUseCase;

  TeamActionCubit({
    required this.createTeamUseCase,
    required this.updateTeamUseCase,
  }) : super(TeamActionInitial());

  Future<void> createTeam(TeamEntity team) async {
    emit(TeamActionLoading());

    final result = await createTeamUseCase.call(team);

    result.fold((failure) => emit(TeamActionFailure(error: failure.message)),
        (success) => emit(const TeamActionSuccess(message: "message")));
  }
}
