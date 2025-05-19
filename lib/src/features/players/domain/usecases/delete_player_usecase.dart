import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../repositories/i_player_repository.dart';

class DeletePlayerUseCase extends BaseUseCases<Unit, String> {
  final IPlayerRepository playerRepository;

  DeletePlayerUseCase({required this.playerRepository});

  @override
  Future<Either<Failure, Unit>> call(String params) async {
    return await playerRepository.deletePlayer(params);
  }
}
