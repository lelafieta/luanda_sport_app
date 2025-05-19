import 'package:dartz/dartz.dart';
import 'package:luanda_sport_app/src/core/usecases/base_usecases.dart';

import '../../../../core/error/failure.dart';
import '../entities/competition_entity.dart';
import '../repositories/i_competition_repository.dart';

class GetCompetitionByIdUseCase extends BaseUseCases<CompetitionEntity, int> {
  final ICompetitionRepository competitionRepository;

  GetCompetitionByIdUseCase({required this.competitionRepository});

  @override
  Future<Either<Failure, CompetitionEntity>> call(int params) async {
    return await competitionRepository.getCompetitionById(params);
  }
}
