import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../repositories/i_team_repository.dart';

class DeleteTeamUseCase extends BaseUseCases<Unit, String> {
  final ITeamRepository teamRepository;

  DeleteTeamUseCase({required this.teamRepository});
  @override
  Future<Either<Failure, Unit>> call(String params) async {
    return await teamRepository.deleteTeam(params);
  }
}
