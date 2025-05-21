import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

import '../entities/player_stats_entity.dart';
import '../params/player_stats_params.dart';

abstract class IPlayerStatsRepository {
  Future<Either<Failure, Unit>> createPlayerStats(
      PlayerStatsEntity playerStats);
  Future<Either<Failure, PlayerStatsEntity?>> getPlayerStatsById(String id);
  Future<Either<Failure, PlayerStatsEntity?>> getPlayerStatsByTeam(
      PlayerStatsParams params);
  Future<Either<Failure, Unit>> updatePlayerStats(
      PlayerStatsEntity playerStats);
  Future<Either<Failure, Unit>> deletePlayer(String playerId);
}
