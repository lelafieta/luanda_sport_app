import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../repositories/i_match_repository.dart';

class SearchMatchesUseCase extends BaseUseCases<dynamic, Map<String, dynamic>> {
  final IMatchRepository repository;

  SearchMatchesUseCase({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(Map<String, dynamic> params) {
    return repository.searchMatches(params);
  }
}
