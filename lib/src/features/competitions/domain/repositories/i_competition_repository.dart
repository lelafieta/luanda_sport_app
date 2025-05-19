import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/competition_entity.dart';

abstract class ICompetitionRepository {
  Future<Either<Failure, List<CompetitionEntity>>> getCompetitions();
  Future<Either<Failure, CompetitionEntity>> getCompetitionById(int id);
  Future<Either<Failure, Unit>> createCompetition(
      CompetitionEntity competition);
  Future<Either<Failure, Unit>> updateCompetition(
      CompetitionEntity competition);
  Future<Either<Failure, Unit>> deleteCompetition(int id);
  Future<Either<Failure, List<CompetitionEntity>>> searchCompetitions(
      String query);
  Future<Either<Failure, Unit>> joinCompetition(
      String competitionId, String userId);
  Future<Either<Failure, Unit>> leaveCompetition(
      String competitionId, String userId);
  Future<Either<Failure, List<String>>> getParticipants(String competitionId);
}

// Use Cases

class SearchCompetitions {
  final ICompetitionRepository repository;

  SearchCompetitions(this.repository);

  Future<Either<Failure, List<CompetitionEntity>>> call(String query) {
    return repository.searchCompetitions(query);
  }
}

class JoinCompetition {
  final ICompetitionRepository repository;

  JoinCompetition(this.repository);

  Future<Either<Failure, Unit>> call(String competitionId, String userId) {
    return repository.joinCompetition(competitionId, userId);
  }
}

class LeaveCompetition {
  final ICompetitionRepository repository;

  LeaveCompetition(this.repository);

  Future<Either<Failure, Unit>> call(String competitionId, String userId) {
    return repository.leaveCompetition(competitionId, userId);
  }
}

class GetParticipants {
  final ICompetitionRepository repository;

  GetParticipants(this.repository);

  Future<Either<Failure, List<String>>> call(String competitionId) {
    return repository.getParticipants(competitionId);
  }
}
