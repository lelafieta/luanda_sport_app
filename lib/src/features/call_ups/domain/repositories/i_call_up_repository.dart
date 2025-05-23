import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/call_up_entity.dart';

abstract class ICallUpRepository {
  Future<Either<Failure, Unit>> createCallUp(CallUpEntity callUp);
  Future<Either<Failure, List<CallUpEntity>>> getCallUpsByPlayer(
      String playerId);
  Future<Either<Failure, List<CallUpEntity>>> getCallUpsByPlayerPending(
      String playerId);
  Future<Either<Failure, List<CallUpEntity>>> getCallUpsByCoach(String coachId);
  Future<Either<Failure, Unit>> updateCallUpStatus(String id, String status);
  Future<Either<Failure, Unit>> cancelCallUp(String id);
  Future<Either<Failure, Unit>> deleteCallUp(String id);
}
