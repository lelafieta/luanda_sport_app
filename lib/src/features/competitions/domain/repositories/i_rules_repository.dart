import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/rule_entity.dart';

abstract class IRulesRepository {
  Future<Either<Failure, Unit>> saveRules({required RuleEntity rules});
  Future<RuleEntity> getRules();
  Future<Either<Failure, RuleEntity>> getRulesByCompetition(
      {required int competitionId});
}
