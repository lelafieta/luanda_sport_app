import 'package:dartz/dartz.dart';
import 'package:luanda_sport_app/src/core/error/failure.dart';

import '../../../../core/usecases/base_usecases.dart';
import '../entities/call_up_entity.dart';
import '../repositories/i_call_up_repository.dart';

class CreateCallUpUseCase extends BaseUseCases<Unit, CallUpEntity> {
  final ICallUpRepository callUpRepository;
  CreateCallUpUseCase({required this.callUpRepository});

  @override
  Future<Either<Failure, Unit>> call(CallUpEntity params) {
    return callUpRepository.createCallUp(params);
  }
}
