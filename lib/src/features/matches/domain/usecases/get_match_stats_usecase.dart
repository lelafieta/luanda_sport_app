import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/match_stats_entity.dart';
import '../repositories/i_match_repository.dart';

class GetMatchStatsUseCase extends BaseUseCases<MatchStatsEntity?, String> {
  final IMatchRepository repository;

  GetMatchStatsUseCase({required this.repository});

  @override
  Future<Either<Failure, MatchStatsEntity?>> call(String params) {
    return repository.getMatchStats(params);
  }
}
