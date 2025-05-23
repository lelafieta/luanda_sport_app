import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/call_up_entity.dart';
import '../repositories/i_call_up_repository.dart';

class GetCallUpsByCoachUseCase
    extends BaseUseCases<List<CallUpEntity>, String> {
  final ICallUpRepository callUpRepository;
  GetCallUpsByCoachUseCase({required this.callUpRepository});

  @override
  Future<Either<Failure, List<CallUpEntity>>> call(String params) {
    return callUpRepository.getCallUpsByCoach(params);
  }
}
