import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/player_entity.dart';
import '../repositories/i_player_repository.dart';

class CreatePlayerUseCase extends BaseUseCases<Unit, PlayerEntity> {
  final IPlayerRepository playerRepository;

  CreatePlayerUseCase({required this.playerRepository});

  @override
  Future<Either<Failure, Unit>> call(PlayerEntity params) async {
    return await playerRepository.createPlayer(params);
  }
}
