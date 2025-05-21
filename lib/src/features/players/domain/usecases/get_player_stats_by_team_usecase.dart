import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/player_stats_entity.dart';
import '../params/player_stats_params.dart';
import '../repositories/i_player_stats_repository.dart';

class GetPlayerStatsByTeamUseCase
    extends BaseUseCases<PlayerStatsEntity?, PlayerStatsParams> {
  final IPlayerStatsRepository playerStatsRepository;

  GetPlayerStatsByTeamUseCase({required this.playerStatsRepository});

  @override
  Future<Either<Failure, PlayerStatsEntity?>> call(
      PlayerStatsParams params) async {
    return await playerStatsRepository.getPlayerStatsByTeam(params);
  }
}
