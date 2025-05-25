part of 'player_match_cubit.dart';

sealed class PlayerMatchState extends Equatable {
  const PlayerMatchState();

  @override
  List<Object> get props => [];
}

final class PlayerMatchInitial extends PlayerMatchState {}

final class PlayerMatchLoading extends PlayerMatchState {}

final class PlayerMatchLoaded extends PlayerMatchState {
  final List<MatchEntity> playerMatches;

  const PlayerMatchLoaded({required this.playerMatches});

  @override
  List<Object> get props => [playerMatches];
}

final class PlayerMatchFailure extends PlayerMatchState {
  final String error;

  const PlayerMatchFailure({required this.error});

  @override
  List<Object> get props => [error];
}
