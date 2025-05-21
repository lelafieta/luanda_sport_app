import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../repositories/i_player_repository.dart';

class DeletePlayerStatsUseCase extends BaseUseCases<Unit, String> {
  final IPlayerRepository playerStatsRepository;

  DeletePlayerStatsUseCase({required this.playerStatsRepository});

  @override
  Future<Either<Failure, Unit>> call(String params) async {
    return await playerStatsRepository.deletePlayer(params);
  }
}
