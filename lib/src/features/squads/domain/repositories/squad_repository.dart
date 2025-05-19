import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/squad_entity.dart';

abstract class ISquadRepository {
  Future<Either<Failure, SquadEntity>> createSquad(SquadEntity squad);
  Future<Either<Failure, List<SquadEntity>>> getSquadsByTeam(String teamId);
  Future<Either<Failure, SquadEntity?>> getSquadByGameTypeFormation(
      String gameType, String formation, String teamId);
}
