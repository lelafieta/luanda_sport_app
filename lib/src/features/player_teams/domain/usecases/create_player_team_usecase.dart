import 'package:dartz/dartz.dart';
import 'package:luanda_sport_app/src/core/error/failure.dart';
import 'package:luanda_sport_app/src/core/usecases/base_usecases.dart';

import '../params/create_player_team_params.dart';
import '../repositories/i_player_team_repository.dart';

class CreatePlayerTeamUseCase
    extends BaseUseCases<Unit, CreatePlayerTeamParams> {
  final IPlayerTeamRepository playerTeamRespository;

  CreatePlayerTeamUseCase({required this.playerTeamRespository});
  @override
  Future<Either<Failure, Unit>> call(CreatePlayerTeamParams params) {
    return playerTeamRespository.createPlayerTeam(params);
  }
}
