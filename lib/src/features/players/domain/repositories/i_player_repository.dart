import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/player_entity.dart';

abstract class IPlayerRepository {
  Future<Either<Failure, List<PlayerEntity>>> getPlayers();
  Future<Either<Failure, PlayerEntity?>> getPlayerById(String id);
  Future<Either<Failure, List<PlayerEntity>>> getPlayersByTeam(String teamId);
  Future<Either<Failure, Unit>> createPlayer(PlayerEntity player);
  Future<Either<Failure, Unit>> updatePlayer(PlayerEntity player);
  Future<Either<Failure, Unit>> deletePlayer(String id);
}
