import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/training_session_entity.dart';

abstract class ITrainingSessionRepository {
  Future<Either<Failure, List<TrainingSessionEntity>>>
      getTrainingSessionsForTeam(String teamId);
  Future<Either<Failure, Unit>> createSession(TrainingSessionEntity session);
  Future<Either<Failure, Unit>> deleteSession(String id);
}
