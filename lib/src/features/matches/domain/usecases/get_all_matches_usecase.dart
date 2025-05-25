import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/match_entity.dart';
import '../repositories/i_match_repository.dart';

class GetAllMatchesUseCase extends BaseUseCases<List<MatchEntity>, NoParams> {
  final IMatchRepository repository;

  GetAllMatchesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<MatchEntity>>> call(NoParams params) {
    return repository.getAllMatches();
  }
}
