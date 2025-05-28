import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/match_entity.dart';
import '../params/get_matches_by_player_team_params.dart';
import '../repositories/i_match_repository.dart';

class GetMatchesByPlayerTeamUseCase
    extends BaseUseCases<List<MatchEntity>, GetMatchesByPlayerTeamParams> {
  final IMatchRepository repository;

  GetMatchesByPlayerTeamUseCase({required this.repository});

  @override
  Future<Either<Failure, List<MatchEntity>>> call(
      GetMatchesByPlayerTeamParams params) {
    return repository.getMatchesByPlayerTeam(params);
  }
}
