import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../activities/domain/entities/activity_entity.dart';
import '../../../../call_ups/domain/usecases/get_call_ups_by_player_usecase.dart';
import '../../../../matches/domain/usecases/get_matches_by_player_usecase.dart';
import '../../../../training_sessions/domain/usecases/get_training_sessions_for_team_usecase.dart';
part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final GetTrainingSessionsForTeamUseCase getTrainingSessionsForTeamUseCase;
  final GetCallUpsByPlayerUseCase getCallUpsByPlayerUseCase;
  final GetMatchesByPlayerUseCase getMatchesByPlayerUseCase;

  ActivityCubit({
    required this.getTrainingSessionsForTeamUseCase,
    required this.getCallUpsByPlayerUseCase,
    required this.getMatchesByPlayerUseCase,
  }) : super(ActivityInitial());

  Future<void> loadActivities(String playerId, String teamId) async {
    emit(ActivityLoading());

    try {
      final trainingsResult = await getTrainingSessionsForTeamUseCase(teamId);
      final callUpsResult = await getCallUpsByPlayerUseCase(playerId);
      final matchesResult = await getMatchesByPlayerUseCase(playerId);

      final List<ActivityEntity> activities = [];

      trainingsResult.fold(
        (failure) => emit(ActivityFailure(error: failure.message)),
        (trainings) {
          activities.addAll(trainings.map((t) => ActivityEntity(
              date: t.sessionDate,
              title: t.notes,
              type: ActivityType.training,
              description: t.coachId,
              trainingSession: t)));
        },
      );

      callUpsResult.fold(
        (failure) => null,
        (callUps) {
          activities.addAll(callUps.map((c) => ActivityEntity(
              date: c.visibleUntil,
              title: c.notes,
              type: ActivityType.training,
              description: c.coachId,
              callUp: c)));
        },
      );

      matchesResult.fold(
        (failure) => null,
        (matches) {
          activities.addAll(matches.map((m) => ActivityEntity(
                date: m.matchDate,
                title: m.competition!.name,
                type: ActivityType.match,
                description: m.stadium,
              )));
        },
      );

      activities.sort((a, b) => a.date!.compareTo(b.date!));

      emit(ActivityLoaded(activities));
    } catch (e) {
      emit(const ActivityFailure(error: "Erro ao carregar atividades"));
    }
  }
}
