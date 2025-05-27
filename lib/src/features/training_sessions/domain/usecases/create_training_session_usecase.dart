import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/training_session_entity.dart';
import '../repositories/i_training_session_repository.dart';

class CreateTrainingSessionUseCase
    extends BaseUseCases<Unit, TrainingSessionEntity> {
  final ITrainingSessionRepository repository;

  CreateTrainingSessionUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(TrainingSessionEntity params) async {
    return repository.createTrainingSession(params);
  }
}
