import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/team_entity.dart';
import '../repositories/i_team_repository.dart';

class GetMyTeamsUseCase extends BaseUseCases<List<TeamEntity>, NoParams> {
  final ITeamRepository teamRepository;

  GetMyTeamsUseCase({required this.teamRepository});
  @override
  Future<Either<Failure, List<TeamEntity>>> call(NoParams params) async {
    return await teamRepository.getMyTeams();
  }
}
