import 'package:dartz/dartz.dart';

import '../models/call_up_model.dart';

abstract class ICallUpRemoteDataSource {
  Future<Unit> createCallUp(CallUpModel callUp);
  Future<List<CallUpModel>> getCallUpsByPlayer(String playerId);
  Future<List<CallUpModel>> getCallUpsByCoach(String coachId);
  Future<Unit> updateCallUpStatus(String id, String status);
  Future<Unit> cancelCallUp(String id);
  Future<Unit> deleteCallUp(String id);
}
