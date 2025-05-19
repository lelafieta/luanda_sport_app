import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/player_entity.dart';
import '../repositories/i_player_repository.dart';

class GetPlayerByIdUseCase extends BaseUseCases<PlayerEntity?, String> {
  final IPlayerRepository playerRepository;

  GetPlayerByIdUseCase({required this.playerRepository});

  @override
  Future<Either<Failure, PlayerEntity?>> call(String params) async {
    return await playerRepository.getPlayerById(params);
  }
}
