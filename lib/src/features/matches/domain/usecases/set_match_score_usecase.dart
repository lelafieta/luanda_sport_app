import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../repositories/i_match_repository.dart';

class SetMatchScoreUseCase extends BaseUseCases<dynamic, dynamic> {
  final IMatchRepository repository;

  SetMatchScoreUseCase({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(dynamic params) {
    return repository.setMatchScore(params);
  }
}
