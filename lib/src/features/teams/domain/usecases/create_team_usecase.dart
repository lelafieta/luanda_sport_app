import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/team_entity.dart';
import '../repositories/i_team_repository.dart';

class CreateTeamUseCase extends BaseUseCases<Unit, TeamEntity> {
  final ITeamRepository teamRepository;

  CreateTeamUseCase({required this.teamRepository});
  @override
  Future<Either<Failure, Unit>> call(TeamEntity params) async {
    return await teamRepository.createTeam(params);
  }
}
