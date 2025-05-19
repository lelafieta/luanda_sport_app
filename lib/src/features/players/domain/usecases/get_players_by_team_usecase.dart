import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/player_entity.dart';
import '../repositories/i_player_repository.dart';

class GetPlayersByTeamUseCase extends BaseUseCases<List<PlayerEntity>, String> {
  final IPlayerRepository playerRepository;

  GetPlayersByTeamUseCase({required this.playerRepository});

  @override
  Future<Either<Failure, List<PlayerEntity>>> call(String params) async {
    return await playerRepository.getPlayersByTeam(params);
  }
}
