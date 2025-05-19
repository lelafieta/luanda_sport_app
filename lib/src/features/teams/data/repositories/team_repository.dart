import 'package:dartz/dartz.dart';

import 'package:luanda_sport_app/src/core/error/failure.dart';
import 'package:luanda_sport_app/src/features/teams/domain/entities/tactical_formation_entity.dart';

import '../../domain/entities/team_entity.dart';
import '../../domain/repositories/i_team_repository.dart';
import '../datasources/i_team_datasource.dart';
import '../models/team_model.dart';

class TeamRepository extends ITeamRepository {
  final ITeamRemoteDataSource teamDatasource;

  TeamRepository({required this.teamDatasource});

  @override
  Future<Either<Failure, Unit>> createTeam(TeamEntity team) async {
    try {
      await teamDatasource.createTeam(TeamModel.fromEntity(team));
      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTeam(String teamId) async {
    try {
      await teamDatasource.deleteTeam(teamId);
      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TeamEntity>>> getMyTeams() async {
    try {
      final teams = await teamDatasource.getMyTeams();
      return Right(teams);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TeamEntity?>> getTeamById(String teamId) async {
    try {
      final team = await teamDatasource.getTeamById(teamId);
      return Right(team);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TeamEntity>>> getTeams() async {
    try {
      final teams = await teamDatasource.getTeams();
      return Right(teams);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTeam(TeamEntity team) async {
    try {
      await teamDatasource.updateTeam(TeamModel.fromEntity(team));
      print("TRUE");
      return const Right(unit);
    } catch (e) {
      print("Error ${e}");
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TacticalFormationEntity?>> getTeamTacticalFormation(
      String teamId) async {
    // TODO: implement getTeamTacticalFormation
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updateTeamSquad(
      String gameType, String formation, String teamId) async {
    try {
      await teamDatasource.updateTeamSquad(gameType, formation, teamId);

      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
