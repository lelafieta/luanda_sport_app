import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/player_team_entity.dart';
import '../repositories/i_player_team_repository.dart';

class GetPlayerTeamsUseCase
    extends BaseUseCases<List<PlayerTeamEntity>, String> {
  final IPlayerTeamRepository playerTeamRespository;

  GetPlayerTeamsUseCase({required this.playerTeamRespository});
  @override
  Future<Either<Failure, List<PlayerTeamEntity>>> call(String params) {
    return playerTeamRespository.getPlayerTeams(params);
  }
}
