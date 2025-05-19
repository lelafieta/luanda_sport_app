import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/trophy_entity.dart';

abstract class ITrophyRepository {
  Future<Either<Failure, List<TrophyEntity>>> getTrophies(
      {String? competitionId});
  Future<Either<Failure, TrophyEntity?>> getTrophyById(String id);
  Future<Either<Failure, Unit>> createTrophy(TrophyEntity trophy);
  Future<Either<Failure, Unit>> updateTrophy(TrophyEntity trophy);
  Future<Either<Failure, Unit>> deleteTrophy(String id);
  Future<Either<Failure, List<TrophyEntity>>> getTrophiesByTeam(String teamId);
}
