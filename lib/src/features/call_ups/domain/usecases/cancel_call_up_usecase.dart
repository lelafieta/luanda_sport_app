import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../repositories/i_call_up_repository.dart';

class CancelCallUpUseCase extends BaseUseCases<Unit, String> {
  final ICallUpRepository callUpRepository;
  CancelCallUpUseCase({required this.callUpRepository});

  @override
  Future<Either<Failure, Unit>> call(String params) {
    return callUpRepository.cancelCallUp(params);
  }
}
