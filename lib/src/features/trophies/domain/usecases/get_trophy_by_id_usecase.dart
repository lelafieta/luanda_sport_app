import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/trophy_entity.dart';
import '../repositories/i_trophy_repository.dart';

class GetTrophyByIdUseCase extends BaseUseCases<TrophyEntity?, String> {
  final ITrophyRepository trophyRepository;

  GetTrophyByIdUseCase({required this.trophyRepository});

  @override
  Future<Either<Failure, TrophyEntity?>> call(String params) {
    return trophyRepository.getTrophyById(params);
  }
}
