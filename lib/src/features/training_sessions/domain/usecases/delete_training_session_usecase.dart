import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../repositories/i_training_session_repository.dart';

class DeleteTrainingSessionUseCase extends BaseUseCases<Unit, String> {
  final ITrainingSessionRepository repository;

  DeleteTrainingSessionUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(String params) async {
    return repository.deleteTrainingSession(params);
  }
}
