import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/call_up_entity.dart';
import '../../domain/repositories/i_call_up_repository.dart';

import '../datasources/i_call_up_datasource.dart';
import '../models/call_up_model.dart';

class CallUpRepository extends ICallUpRepository {
  final ICallUpRemoteDataSource callUpDataSource;

  CallUpRepository({required this.callUpDataSource});

  @override
  Future<Either<Failure, Unit>> cancelCallUp(String id) async {
    try {
      await callUpDataSource.cancelCallUp(id);
      return right(unit);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> createCallUp(CallUpEntity callUp) async {
    try {
      final model = CallUpModel.fromEntity(callUp);
      await callUpDataSource.createCallUp(model);
      return right(unit);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCallUp(String id) async {
    try {
      await callUpDataSource.deleteCallUp(id);
      return right(unit);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CallUpEntity>>> getCallUpsByCoach(
      String coachId) async {
    try {
      final result = await callUpDataSource.getCallUpsByCoach(coachId);
      return right(result);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CallUpEntity>>> getCallUpsByPlayer(
      String playerId) async {
    try {
      final result = await callUpDataSource.getCallUpsByPlayer(playerId);
      return right(result);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCallUpStatus(
      String id, String status) async {
    try {
      await callUpDataSource.updateCallUpStatus(id, status);
      return right(unit);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
