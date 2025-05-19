import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../../../players/domain/entities/player_entity.dart';
import '../entities/starting_lineup_player_entity.dart';
import '../repositories/i_starting_lineup_player_repository.dart';

class RemoveStartingLineupPlayerUseCase
    extends BaseUseCases<List<StartingLineupPlayersEntity>, PlayerEntity> {
  final IStartingLineupPlayerRepository startingLineupPlayerRepository;

  RemoveStartingLineupPlayerUseCase(
      {required this.startingLineupPlayerRepository});

  @override
  Future<Either<Failure, List<StartingLineupPlayersEntity>>> call(
      PlayerEntity params) {
    return startingLineupPlayerRepository.removeStartingLineupPlayer(params);
  }
}
