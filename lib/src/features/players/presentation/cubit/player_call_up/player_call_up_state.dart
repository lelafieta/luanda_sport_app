part of 'player_call_up_cubit.dart';

sealed class PlayerCallUpState extends Equatable {
  const PlayerCallUpState();

  @override
  List<Object> get props => [];
}

final class PlayerCallUpInitial extends PlayerCallUpState {}

final class PlayerCallUpLoading extends PlayerCallUpState {}

final class PlayerCallUpLoaded extends PlayerCallUpState {
  final List<CallUpEntity> callUps;

  const PlayerCallUpLoaded({required this.callUps});

  @override
  List<Object> get props => [callUps];
}

final class PlayerCallUpError extends PlayerCallUpState {
  final String error;

  const PlayerCallUpError({required this.error});

  @override
  List<Object> get props => [error];
}
