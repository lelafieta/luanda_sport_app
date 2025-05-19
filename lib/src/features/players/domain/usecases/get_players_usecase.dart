import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/player_entity.dart';
import '../repositories/i_player_repository.dart';

class GetPlayersUseCase extends BaseUseCases<List<PlayerEntity>, NoParams> {
  final IPlayerRepository playerRepository;

  GetPlayersUseCase({required this.playerRepository});

  @override
  Future<Either<Failure, List<PlayerEntity>>> call(NoParams params) async {
    return await playerRepository.getPlayers();
  }
}
