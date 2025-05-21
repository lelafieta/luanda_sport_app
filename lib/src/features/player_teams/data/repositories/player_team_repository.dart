import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/player_team_entity.dart';
import '../../domain/params/create_player_team_params.dart';
import '../../domain/repositories/i_player_team_repository.dart';
import '../datasources/i_player_team_datasource.dart';

class PlayerTeamRepository extends IPlayerTeamRepository {
  final IPlayerTeamRemoteDataSource playerTeamDataSource;

  PlayerTeamRepository({required this.playerTeamDataSource});
  @override
  Future<Either<Failure, Unit>> createPlayerTeam(
      CreatePlayerTeamParams playerTeam) async {
    try {
      final result = await playerTeamDataSource.createPlayerTeam(playerTeam);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PlayerTeamEntity>>> getPlayerTeams(
      String playerId) async {
    try {
      final result = await playerTeamDataSource.getPlayerTeams(playerId);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
