import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/match_entity.dart';
import '../repositories/i_match_repository.dart';

class GenerateMatchReportUseCase extends BaseUseCases<dynamic, dynamic> {
  final IMatchRepository repository;

  GenerateMatchReportUseCase({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(dynamic params) {
    return repository.generateMatchReport(params);
  }
}
