import 'package:dartz/dartz.dart';
import 'package:luanda_sport_app/src/core/usecases/base_usecases.dart';

import '../../../../core/error/failure.dart';
import '../entities/competition_entity.dart';
import '../repositories/i_competition_repository.dart';

class GetCompetitionsUseCase
    extends BaseUseCases<List<CompetitionEntity>, NoParams> {
  final ICompetitionRepository competitionRepository;

  GetCompetitionsUseCase({required this.competitionRepository});

  @override
  Future<Either<Failure, List<CompetitionEntity>>> call(NoParams params) {
    return competitionRepository.getCompetitions();
  }
}
