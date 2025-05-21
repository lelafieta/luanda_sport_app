import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/player_stats_entity.dart';
import '../repositories/i_player_stats_repository.dart';

class GetPlayerStatsByIdUseCase
    extends BaseUseCases<PlayerStatsEntity?, String> {
  final IPlayerStatsRepository playerStatsRepository;

  GetPlayerStatsByIdUseCase({required this.playerStatsRepository});

  @override
  Future<Either<Failure, PlayerStatsEntity?>> call(String params) async {
    return await playerStatsRepository.getPlayerStatsById(params);
  }
}
