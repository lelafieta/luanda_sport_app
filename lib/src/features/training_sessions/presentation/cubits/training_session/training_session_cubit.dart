import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/training_session_entity.dart';
import '../../../domain/usecases/create_training_session_usecase.dart';
import '../../../domain/usecases/delete_training_session_usecase.dart';
import '../../../domain/usecases/get_training_sessions_for_team_usecase.dart';

part 'training_session_state.dart';

class TrainingSessionCubit extends Cubit<TrainingSessionState> {
  final GetTrainingSessionsForTeamUseCase getTrainingSessionsForTeamUseCase;
  final DeleteTrainingSessionUseCase deleteTrainingSessionUseCase;
  final CreateTrainingSessionUseCase createTrainingSessionUseCase;

  TrainingSessionCubit({
    required this.getTrainingSessionsForTeamUseCase,
    required this.deleteTrainingSessionUseCase,
    required this.createTrainingSessionUseCase,
  }) : super(TrainingSessionInitial());
}
