import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/training_session_entity.dart';

abstract class ITrainingSessionRepository {
  Future<Either<Failure, List<TrainingSessionEntity>>>
      getTrainingSessionsForTeam(String teamId);
  Future<Either<Failure, Unit>> createTrainingSession(
      TrainingSessionEntity session);
  Future<Either<Failure, Unit>> deleteTrainingSession(String id);
}
