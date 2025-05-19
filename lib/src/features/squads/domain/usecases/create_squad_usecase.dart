import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/squad_entity.dart';
import '../repositories/squad_repository.dart';

class CreateSquadUseCase extends BaseUseCases<SquadEntity, SquadEntity> {
  final ISquadRepository squadRepository;

  CreateSquadUseCase({required this.squadRepository});

  @override
  Future<Either<Failure, SquadEntity>> call(SquadEntity params) {
    return squadRepository.createSquad(params);
  }
}
