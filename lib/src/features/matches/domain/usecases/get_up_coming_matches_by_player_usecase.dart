import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/match_entity.dart';
import '../repositories/i_match_repository.dart';

class GetUpComingMatchesByPlayerUseCase
    extends BaseUseCases<List<MatchEntity>, String> {
  final IMatchRepository repository;

  GetUpComingMatchesByPlayerUseCase({required this.repository});

  @override
  Future<Either<Failure, List<MatchEntity>>> call(String params) {
    return repository.getUpcomingMatchesByPlayer(params);
  }
}
