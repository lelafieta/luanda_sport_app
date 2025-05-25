import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/match_event_entity.dart';
import '../repositories/i_match_repository.dart';

class GetMatchEventsUseCase extends BaseUseCases<dynamic, String> {
  final IMatchRepository repository;

  GetMatchEventsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<MatchEventEntity>>> call(String params) {
    return repository.getMatchEvents(params);
  }
}
