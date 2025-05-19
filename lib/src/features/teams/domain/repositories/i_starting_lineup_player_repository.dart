import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../players/domain/entities/player_entity.dart';
import '../entities/starting_lineup_player_entity.dart';

abstract class IStartingLineupPlayerRepository {
  Future<Either<Failure, List<StartingLineupPlayersEntity>>>
      getTeamStartingLineupPlayers(String teamId);

  Future<Either<Failure, List<StartingLineupPlayersEntity>>>
      createStartingLineupPlayer(
          StartingLineupPlayersEntity startingLineupPlayer);

  Future<Either<Failure, List<StartingLineupPlayersEntity>>>
      removeStartingLineupPlayer(PlayerEntity player);

  Future<Either<Failure, List<StartingLineupPlayersEntity>>>
      deleteStartingLineupTeam(String teamId);
}
