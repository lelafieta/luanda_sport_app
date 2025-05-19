import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/trophy_entity.dart';
import '../../domain/repositories/i_trophy_repository.dart';
import '../datasources/i_trophy_datasource.dart';
import '../models/trophy_model.dart';

class TrophyRepository extends ITrophyRepository {
  final ITrophyRemoteDataSource trophyDataSource;

  TrophyRepository({required this.trophyDataSource});

  @override
  Future<Either<Failure, Unit>> createTrophy(TrophyEntity trophy) async {
    try {
      await trophyDataSource.createTrophy(TrophyModel.fromEntity(trophy));
      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTrophy(String id) async {
    try {
      await trophyDataSource.deleteTrophy(id);
      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TrophyEntity>>> getTrophies(
      {String? competitionId}) async {
    try {
      final trophies =
          await trophyDataSource.getTrophies(competitionId: competitionId);
      return Right(trophies);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TrophyEntity>>> getTrophiesByTeam(
      String teamId) async {
    try {
      final trophies = await trophyDataSource.getTrophiesByTeam(teamId);
      return Right(trophies);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TrophyEntity?>> getTrophyById(String id) async {
    try {
      final trophy = await trophyDataSource.getTrophyById(id);
      return Right(trophy);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTrophy(TrophyEntity trophy) async {
    try {
      await trophyDataSource.updateTrophy(TrophyModel.fromEntity(trophy));
      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
