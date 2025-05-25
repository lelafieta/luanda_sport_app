import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../params/assign_players_to_match_params.dart';
import '../repositories/i_match_repository.dart';

class AssignPlayersToMatchUseCase
    extends BaseUseCases<Unit, AssignPlayersToMatchParams> {
  final IMatchRepository repository;

  AssignPlayersToMatchUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(AssignPlayersToMatchParams params) {
    return repository.assignPlayersToMatch(params);
  }
}
