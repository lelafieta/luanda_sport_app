import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/trophy_entity.dart';
import '../repositories/i_trophy_repository.dart';

class UpdateTrophyUseCase extends BaseUseCases<Unit, TrophyEntity> {
  final ITrophyRepository trophyRepository;

  UpdateTrophyUseCase({required this.trophyRepository});

  @override
  Future<Either<Failure, Unit>> call(TrophyEntity params) {
    return trophyRepository.updateTrophy(params);
  }
}
