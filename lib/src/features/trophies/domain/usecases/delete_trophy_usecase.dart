import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../repositories/i_trophy_repository.dart';

class DeleteTrophyUseCase extends BaseUseCases<Unit, String> {
  final ITrophyRepository trophyRepository;

  DeleteTrophyUseCase({required this.trophyRepository});

  @override
  Future<Either<Failure, Unit>> call(String params) {
    return trophyRepository.deleteTrophy(params);
  }
}
