import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/team_entity.dart';
import '../repositories/i_team_repository.dart';

class UpdateTeamUseCase extends BaseUseCases<Unit, TeamEntity> {
  final ITeamRepository teamRepository;

  UpdateTeamUseCase({required this.teamRepository});
  @override
  Future<Either<Failure, Unit>> call(TeamEntity params) async {
    return await teamRepository.updateTeam(params);
  }
}

abstract class UpdateTeamParams {
  String? id;
  TeamEntity? team;
}
