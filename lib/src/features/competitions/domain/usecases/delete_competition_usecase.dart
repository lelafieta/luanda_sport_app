import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../repositories/i_competition_repository.dart';

class DeleteCompetitionUseCase extends BaseUseCases<Unit, int> {
  final ICompetitionRepository competitionRepository;

  DeleteCompetitionUseCase({required this.competitionRepository});

  @override
  Future<Either<Failure, Unit>> call(int params) async {
    return await competitionRepository.deleteCompetition(params);
  }
}
