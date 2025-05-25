import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/match_entity.dart';
import '../repositories/i_match_repository.dart';

class DeleteMatchUseCase extends BaseUseCases<dynamic, dynamic> {
  final IMatchRepository repository;

  DeleteMatchUseCase({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(dynamic params) {
    return repository.deleteMatchUseCase(params);
  }
}
