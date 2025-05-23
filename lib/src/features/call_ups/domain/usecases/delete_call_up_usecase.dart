import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../repositories/i_call_up_repository.dart';

class DeleteCallUpUseCase extends BaseUseCases<Unit, String> {
  final ICallUpRepository callUpRepository;
  DeleteCallUpUseCase({required this.callUpRepository});

  @override
  Future<Either<Failure, Unit>> call(String params) {
    return callUpRepository.deleteCallUp(params);
  }
}
