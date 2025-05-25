import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../repositories/i_match_repository.dart';

class DeleteMatchUseCase extends BaseUseCases<Unit, String> {
  final IMatchRepository repository;

  DeleteMatchUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(String params) {
    return repository.deleteMatch(params);
  }
}
