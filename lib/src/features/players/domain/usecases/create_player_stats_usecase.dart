import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/player_stats_entity.dart';
import '../repositories/i_player_stats_repository.dart';

class CreatePlayerStatsUseCase extends BaseUseCases<Unit, PlayerStatsEntity> {
  final IPlayerStatsRepository playerStatsRepository;

  CreatePlayerStatsUseCase({required this.playerStatsRepository});

  @override
  Future<Either<Failure, Unit>> call(PlayerStatsEntity params) async {
    return await playerStatsRepository.createPlayerStats(params);
  }
}
