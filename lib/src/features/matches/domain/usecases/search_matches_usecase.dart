import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/match_entity.dart';
import '../repositories/i_match_repository.dart';

class SearchMatchesUseCase extends BaseUseCases<dynamic, dynamic> {
  final IMatchRepository repository;

  SearchMatchesUseCase({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(dynamic params) {
    return repository.searchMatchesUseCase(params);
  }
}
