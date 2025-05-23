import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/call_up_entity.dart';
import '../repositories/i_call_up_repository.dart';

class GetCallUpsByPlayerUseCase
    extends BaseUseCases<List<CallUpEntity>, String> {
  final ICallUpRepository callUpRepository;
  GetCallUpsByPlayerUseCase({required this.callUpRepository});

  @override
  Future<Either<Failure, List<CallUpEntity>>> call(String params) {
    return callUpRepository.getCallUpsByPlayer(params);
  }
}
