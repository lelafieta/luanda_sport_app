import '../models/training_session_model.dart';

abstract class ITrainingSessionDataSource {
  Future<List<TrainingSessionModel>> getTrainingSessionsForTeam(String teamId);
  Future<void> createTrainingSession(TrainingSessionModel trainingSession);
  Future<void> deleteTrainingSession(String trainingSessionId);
}
