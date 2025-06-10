import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/call_up_entity.dart';
import '../params/update_call_up_status_params.dart';
import '../repositories/i_call_up_repository.dart';

class UpdateCallUpStatusUseCase
    extends BaseUseCases<CallUpEntity, UpdateCallUpStatusParams> {
  final ICallUpRepository callUpRepository;
  UpdateCallUpStatusUseCase({required this.callUpRepository});

  @override
  Future<Either<Failure, CallUpEntity>> call(UpdateCallUpStatusParams params) {
    return callUpRepository.updateCallUpStatus(params.id, params.status);
  }
}
