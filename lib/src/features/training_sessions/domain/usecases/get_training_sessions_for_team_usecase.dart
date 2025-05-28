import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/training_session_entity.dart';
import '../repositories/i_training_session_repository.dart';

class GetTrainingSessionsForTeamUseCase
    extends BaseUseCases<List<TrainingSessionEntity>, String> {
  final ITrainingSessionRepository repository;

  GetTrainingSessionsForTeamUseCase({required this.repository});

  @override
  Future<Either<Failure, List<TrainingSessionEntity>>> call(
      String params) async {
    return repository.getTrainingSessionsForTeam(params);
  }
}
