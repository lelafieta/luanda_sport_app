import 'package:dartz/dartz.dart';
import 'package:luanda_sport_app/src/features/training_sessions/data/models/training_session_model.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/server_failure.dart';
import '../../domain/entities/training_session_entity.dart';
import '../../domain/repositories/i_training_session_repository.dart';
import '../datasources/i_training_session_datasource.dart';

class TrainingSessionRepository extends ITrainingSessionRepository {
  final ITrainingSessionDataSource dataSource;

  TrainingSessionRepository({required this.dataSource});

  @override
  Future<Either<Failure, Unit>> createTrainingSession(
      TrainingSessionEntity session) async {
    try {
      await dataSource
          .createTrainingSession(TrainingSessionModel.fromEntity(session));
      return right(unit);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTrainingSession(String id) async {
    try {
      await dataSource.deleteTrainingSession(id);
      return right(unit);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TrainingSessionEntity>>>
      getTrainingSessionsForTeam(String teamId) async {
    try {
      final result = await dataSource.getTrainingSessionsForTeam(teamId);
      return right(result);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
