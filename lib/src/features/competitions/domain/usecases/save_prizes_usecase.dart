import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/prize_entity.dart';
import '../repositories/i_prizes_repository.dart';

class SavePrizesUseCase extends BaseUseCases<Unit, PrizeEntity> {
  final IPrizesRepository prizesRepository;

  SavePrizesUseCase({required this.prizesRepository});

  @override
  Future<Either<Failure, Unit>> call(PrizeEntity params) async {
    return await prizesRepository.savePrizes(prizes: params);
  }
}
