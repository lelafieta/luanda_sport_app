import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/squad_entity.dart';
import '../repositories/squad_repository.dart';

class GetSquadByGameTypeFormationUseCase
    extends BaseUseCases<SquadEntity?, GetSquadByGameTypeFormationParams> {
  final ISquadRepository squadRepository;

  GetSquadByGameTypeFormationUseCase({required this.squadRepository});

  @override
  Future<Either<Failure, SquadEntity?>> call(
      GetSquadByGameTypeFormationParams params) {
    return squadRepository.getSquadByGameTypeFormation(
        params.gameType, params.formation, params.teamId);
  }
}

class GetSquadByGameTypeFormationParams {
  final String formation;
  final String gameType;
  final String teamId;

  GetSquadByGameTypeFormationParams({
    required this.formation,
    required this.gameType,
    required this.teamId,
  });
}
