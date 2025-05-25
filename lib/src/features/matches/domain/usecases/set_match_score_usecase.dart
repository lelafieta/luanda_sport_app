import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../params/set_match_score_params.dart';
import '../repositories/i_match_repository.dart';

class SetMatchScoreUseCase extends BaseUseCases<dynamic, SetMatchScoreParams> {
  final IMatchRepository repository;

  SetMatchScoreUseCase({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(SetMatchScoreParams params) {
    return repository.setMatchScore(params);
  }
}
