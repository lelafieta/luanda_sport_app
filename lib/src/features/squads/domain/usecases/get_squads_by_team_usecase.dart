import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/squad_entity.dart';
import '../repositories/squad_repository.dart';

class GetSquadsByTeamUseCase extends BaseUseCases<List<SquadEntity>, String> {
  final ISquadRepository squadRepository;

  GetSquadsByTeamUseCase({required this.squadRepository});

  @override
  Future<Either<Failure, List<SquadEntity>>> call(String params) {
    return squadRepository.getSquadsByTeam(params);
  }
}
