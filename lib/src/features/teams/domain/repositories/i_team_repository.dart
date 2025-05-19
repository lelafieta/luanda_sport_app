import 'package:dartz/dartz.dart';
import 'package:luanda_sport_app/src/features/teams/domain/entities/tactical_formation_entity.dart';

import '../../../../core/error/failure.dart';
import '../entities/team_entity.dart';

abstract class ITeamRepository {
  Future<Either<Failure, Unit>> createTeam(TeamEntity team);
  Future<Either<Failure, List<TeamEntity>>> getTeams();
  Future<Either<Failure, List<TeamEntity>>> getMyTeams();
  Future<Either<Failure, TacticalFormationEntity?>> getTeamTacticalFormation(
      String teamId);
  Future<Either<Failure, TeamEntity?>> getTeamById(String teamId);
  Future<Either<Failure, Unit>> updateTeam(TeamEntity team);
  Future<Either<Failure, Unit>> updateTeamSquad(
      String gameType, String formation, String teamId);
  Future<Either<Failure, Unit>> deleteTeam(String teamId);
}
