import 'package:dartz/dartz.dart';
import 'package:luanda_sport_app/src/core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/rule_entity.dart';
import '../repositories/i_rules_repository.dart';

class SaveRulesUseCase extends BaseUseCases<Unit, RuleEntity> {
  final IRulesRepository rulesRepository;

  SaveRulesUseCase({required this.rulesRepository});

  @override
  Future<Either<Failure, Unit>> call(RuleEntity params) async {
    return await rulesRepository.saveRules(rules: params);
  }
}
