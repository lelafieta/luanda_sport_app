part of 'training_session_cubit.dart';

sealed class TrainingSessionState extends Equatable {
  const TrainingSessionState();

  @override
  List<Object> get props => [];
}

final class TrainingSessionInitial extends TrainingSessionState {}

final class TrainingSessionLoading extends TrainingSessionState {}

final class TrainingSessionLoaded extends TrainingSessionState {
  final List<TrainingSessionEntity> traingSessions;

  const TrainingSessionLoaded({required this.traingSessions});

  @override
  List<Object> get props => [traingSessions];
}

final class TrainingSessionFailure extends TrainingSessionState {
  final String error;

  const TrainingSessionFailure({required this.error});

  @override
  List<Object> get props => [error];
}
