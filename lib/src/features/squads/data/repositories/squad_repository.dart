import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/squad_entity.dart';
import '../../domain/repositories/squad_repository.dart';
import '../datasources/i_squad_datasource.dart';
import '../models/squad_model.dart';

class SquadRepository implements ISquadRepository {
  final ISquadRemoteDataSource squadDataSource;

  SquadRepository({required this.squadDataSource});

  @override
  Future<Either<Failure, SquadEntity>> createSquad(SquadEntity squad) async {
    try {
      await squadDataSource.createSquad(SquadModel.fromEntity(squad));
      return Right(squad);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SquadEntity>>> getSquadsByTeam(
      String teamId) async {
    try {
      final result = await squadDataSource.getSquadsByTeam(teamId);
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SquadEntity?>> getSquadByGameTypeFormation(
      String gameType, String formation, String teamId) async {
    try {
      final result = await squadDataSource.getSquadByGameTypeFormation(
          gameType, formation, teamId);
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
