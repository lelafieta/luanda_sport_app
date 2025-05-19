// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';

import '../params/update_team_squad_params.dart';
import '../repositories/i_team_repository.dart';

class UpdateTeamSquadUseCase extends BaseUseCases<Unit, UpdateTeamSquadParams> {
  final ITeamRepository teamRepository;

  UpdateTeamSquadUseCase({required this.teamRepository});
  @override
  Future<Either<Failure, Unit>> call(UpdateTeamSquadParams params) async {
    return await teamRepository.updateTeamSquad(
        params.gameType, params.formation, params.teamId);
  }
}
