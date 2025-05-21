import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/player_stats_entity.dart';
import '../../domain/params/player_stats_params.dart';
import '../../domain/repositories/i_player_stats_repository.dart';
import '../datasources/i_player_stats_datasource.dart';
import '../models/player_stats_model.dart';

class PlayerStatsRepository implements IPlayerStatsRepository {
  final IPlayerStatsRemoteDataSource playerStatsDataSource;

  PlayerStatsRepository({required this.playerStatsDataSource});

  @override
  Future<Either<Failure, Unit>> deletePlayer(String id) async {
    try {
      await playerStatsDataSource.deletePlayer(id);
      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> createPlayerStats(
      PlayerStatsEntity playerStats) async {
    try {
      await playerStatsDataSource
          .createPlayerStats(PlayerStatsModel.fromEntity(playerStats));
      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PlayerStatsEntity?>> getPlayerStatsById(
      String id) async {
    try {
      final response = await playerStatsDataSource.getPlayerStatsById(id);
      return Right(response);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PlayerStatsEntity?>> getPlayerStatsByTeam(
      PlayerStatsParams params) async {
    try {
      final response = await playerStatsDataSource.getPlayerStatsByTeam(params);
      return Right(response);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePlayerStats(
      PlayerStatsEntity playerStats) async {
    try {
      await playerStatsDataSource
          .updatePlayerStats(PlayerStatsModel.fromEntity(playerStats));
      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
