import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/training_session_model.dart';
import 'i_training_session_datasource.dart';

class TrainingSessionDataSource extends ITrainingSessionDataSource {
  final SupabaseClient client;

  TrainingSessionDataSource({required this.client});
  @override
  Future<void> createTrainingSession(
      TrainingSessionModel trainingSession) async {
    await client.from('training_sessions').insert(trainingSession.toJson());
  }

  @override
  Future<void> deleteTrainingSession(String trainingSessionId) async {
    await client.from('training_sessions').delete().eq('id', trainingSessionId);
  }

  @override
  Future<List<TrainingSessionModel>> getTrainingSessionsForTeam(
      String teamId) async {
    final response =
        await client.from('training_sessions').select().eq('team_id', teamId);
    if (response.isNotEmpty) {
      return (response as List)
          .map((e) => TrainingSessionModel.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }
}
