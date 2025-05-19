import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/tactical_formation_entity.dart';
import '../repositories/i_team_repository.dart';

class GetTeamTacticalFormationUseCase
    extends BaseUseCases<TacticalFormationEntity?, String> {
  final ITeamRepository teamRepository;

  GetTeamTacticalFormationUseCase({required this.teamRepository});
  @override
  Future<Either<Failure, TacticalFormationEntity?>> call(String params) async {
    return await teamRepository.getTeamTacticalFormation(params);
  }
}
