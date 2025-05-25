import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/match_entity.dart';
import '../repositories/i_match_repository.dart';

class CreateMatchUseCase extends BaseUseCases<Unit, MatchEntity> {
  final IMatchRepository repository;

  CreateMatchUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(MatchEntity params) {
    return repository.createMatch(params);
  }
}
