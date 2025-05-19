import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/team_entity.dart';
import '../repositories/i_team_repository.dart';

class GetTeamByIdUseCase extends BaseUseCases<TeamEntity?, String> {
  final ITeamRepository teamRepository;

  GetTeamByIdUseCase({required this.teamRepository});
  @override
  Future<Either<Failure, TeamEntity?>> call(String params) async {
    return await teamRepository.getTeamById(params);
  }
}
