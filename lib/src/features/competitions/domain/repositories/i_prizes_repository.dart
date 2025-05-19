import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/prize_entity.dart';

abstract class IPrizesRepository {
  Future<Either<Failure, Unit>> savePrizes({required PrizeEntity prizes});
  Future<Either<Failure, PrizeEntity>> getPrizes();
  Future<Either<Failure, PrizeEntity>> getPrizesByCompetition(
      {required int competitionId});
}
