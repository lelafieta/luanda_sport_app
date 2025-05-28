part of 'player_training_session_cubit.dart';

sealed class PlayerTrainingSessionState extends Equatable {
  const PlayerTrainingSessionState();

  @override
  List<Object> get props => [];
}

final class PlayerTrainingSessionInitial extends PlayerTrainingSessionState {}
