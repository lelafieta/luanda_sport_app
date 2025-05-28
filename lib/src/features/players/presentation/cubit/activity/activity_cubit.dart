import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../activities/domain/entities/activity_entity.dart';
import '../../../../call_ups/domain/usecases/get_call_ups_by_player_usecase.dart';
import '../../../../matches/domain/params/get_matches_by_player_team_params.dart';
import '../../../../matches/domain/usecases/get_matches_by_player_team_usecase.dart';
import '../../../../matches/domain/usecases/get_matches_by_player_usecase.dart';
import '../../../../training_sessions/domain/usecases/get_training_sessions_for_team_usecase.dart';
import '../../../domain/enums/activity_enum.dart';
part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final GetTrainingSessionsForTeamUseCase getTrainingSessionsForTeamUseCase;
  final GetCallUpsByPlayerUseCase getCallUpsByPlayerUseCase;
  final GetMatchesByPlayerTeamUseCase getMatchesByPlayerTeamUseCase;

  ActivityCubit({
    required this.getTrainingSessionsForTeamUseCase,
    required this.getCallUpsByPlayerUseCase,
    required this.getMatchesByPlayerTeamUseCase,
  }) : super(ActivityInitial());

  Future<void> loadActivities(String playerId, String teamId) async {
    emit(ActivityLoading());

    try {
      final trainingsResult = await getTrainingSessionsForTeamUseCase(teamId);
      final callUpsResult = await getCallUpsByPlayerUseCase(playerId);
      final matchesResult = await getMatchesByPlayerTeamUseCase(
          GetMatchesByPlayerTeamParams(playerId: playerId, teamId: teamId));

      final List<ActivityEntity> activities = [];

      trainingsResult.fold(
        (failure) => emit(ActivityFailure(error: failure.message)),
        (trainings) {
          activities.addAll(trainings.map((t) => ActivityEntity(
              date: t.sessionDate,
              title: t.notes,
              type: ActivityType.trainingSession,
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
              type: ActivityType.callUp,
              description: c.coachId,
              callUp: c)));
        },
      );

      matchesResult.fold(
        (failure) => null,
        (matches) {
          activities.addAll(matches.map((m) => ActivityEntity(
                date: m.matchDate,
                title: (m.competitionId == null)
                    ? "Exibição"
                    : m.competition!.name,
                type: ActivityType.match,
                description: m.stadium,
              )));
        },
      );

      activities.sort((a, b) => a.date!.compareTo(b.date!));

      emit(ActivityLoaded(activities));
    } catch (e, strack) {
      print(strack);
      emit(
          ActivityFailure(error: "Erro ao carregar atividades ${e} ${strack}"));
    }
  }
}
