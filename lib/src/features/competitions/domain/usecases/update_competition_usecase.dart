import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/competition_entity.dart';
import '../repositories/i_competition_repository.dart';

class UpdateCompetitionUseCase extends BaseUseCases<Unit, CompetitionEntity> {
  final ICompetitionRepository competitionRepository;

  UpdateCompetitionUseCase({required this.competitionRepository});

  @override
  Future<Either<Failure, Unit>> call(CompetitionEntity params) {
    return competitionRepository.updateCompetition(params);
  }
}
