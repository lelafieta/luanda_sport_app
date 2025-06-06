import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/trophy_entity.dart';
import '../repositories/i_trophy_repository.dart';

class GetTrophiesByTeamUseCase
    extends BaseUseCases<List<TrophyEntity>, String> {
  final ITrophyRepository trophyRepository;

  GetTrophiesByTeamUseCase({required this.trophyRepository});

  @override
  Future<Either<Failure, List<TrophyEntity>>> call(String params) {
    return trophyRepository.getTrophiesByTeam(params);
  }
}
