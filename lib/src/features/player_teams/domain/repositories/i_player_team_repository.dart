import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/player_team_entity.dart';
import '../params/create_player_team_params.dart';

abstract class IPlayerTeamRepository {
  Future<Either<Failure, Unit>> createPlayerTeam(
      CreatePlayerTeamParams playerTeam);
  Future<Either<Failure, List<PlayerTeamEntity>>> getPlayerTeams(
      String playerId);
}
