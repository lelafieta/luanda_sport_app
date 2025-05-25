import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/match_entity.dart';
import '../repositories/i_match_repository.dart';

class GetMatchByIdUseCase extends BaseUseCases<MatchEntity?, String> {
  final IMatchRepository repository;

  GetMatchByIdUseCase({required this.repository});

  @override
  Future<Either<Failure, MatchEntity?>> call(String params) {
    return repository.getMatchById(params);
  }
}
