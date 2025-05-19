import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/squad_entity.dart';
import '../../domain/usecases/create_squad_usecase.dart';
import '../../domain/usecases/get_squad_by_game_type_formation_usecase.dart';
import '../../domain/usecases/get_squads_by_team_usecase.dart';

part 'squad_state.dart';

class SquadCubit extends Cubit<SquadState> {
  final CreateSquadUseCase createSquadUseCase;
  final GetSquadsByTeamUseCase getSquadsByTeamUseCase;
  final GetSquadByGameTypeFormationUseCase getSquadByGameTypeFormationUseCase;

  SquadCubit(
      {required this.createSquadUseCase,
      required this.getSquadsByTeamUseCase,
      required this.getSquadByGameTypeFormationUseCase})
      : super(SquadInitial());

  Future<void> createSquad(SquadEntity squad) async {
    emit(SquadLoading());

    final result = await createSquadUseCase.call(squad);

    result.fold((failure) => emit(SquadFailure(error: failure.message)),
        (squad) => SquadLoaded(squad: squad));
  }

  Future<void> fetchSquadsByTeam(String teamId) async {
    // emit(SquadLoading());

    // final result = await getSquadsByTeamUseCase.call(teamId);

    // result.fold((failure) => emit(SquadFailure(error: failure.message)),
    //     (squad) => SquadLoaded(squad: squad));
  }

  Future<void> getSquadByGameTypeFormation(
      String gameType, String formation, String teamId) async {
    emit(SquadLoading());

    final result = await getSquadByGameTypeFormationUseCase.call(
        GetSquadByGameTypeFormationParams(
            formation: formation, gameType: gameType, teamId: teamId));

    result.fold(
      (failure) => emit(SquadFailure(error: failure.message)),
      (squad) => emit(SquadLoaded(squad: squad)),
    );
  }
}
