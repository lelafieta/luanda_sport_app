import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/player_entity.dart';
import '../../domain/repositories/i_player_repository.dart';
import '../datasources/i_player_datasource.dart';
import '../models/player_model.dart';

class PlayerRepository implements IPlayerRepository {
  final IPlayerRemoteDataSource playerDataSource;

  PlayerRepository({required this.playerDataSource});

  @override
  Future<Either<Failure, List<PlayerEntity>>> getPlayers() async {
    try {
      final result = await playerDataSource.getPlayers();
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PlayerEntity?>> getPlayerById(String id) async {
    try {
      final result = await playerDataSource.getPlayerById(id);
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PlayerEntity>>> getPlayersByTeam(
      String teamId) async {
    try {
      final result = await playerDataSource.getPlayersByTeam(teamId);
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> createPlayer(PlayerEntity player) async {
    try {
      await playerDataSource.createPlayer(PlayerModel.fromEntity(player));
      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePlayer(PlayerEntity player) async {
    try {
      await playerDataSource.updatePlayer(PlayerModel.fromEntity(player));
      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePlayer(String id) async {
    try {
      await playerDataSource.deletePlayer(id);
      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
