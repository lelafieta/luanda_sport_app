part of 'player_upcoming_match_cubit.dart';

sealed class PlayerUpcomingMatchState extends Equatable {
  const PlayerUpcomingMatchState();

  @override
  List<Object> get props => [];
}

final class PlayerUpcomingMatchInitial extends PlayerUpcomingMatchState {}

final class PlayerUpcomingMatchLoading extends PlayerUpcomingMatchState {}

final class PlayerUpcomingMatchLoaded extends PlayerUpcomingMatchState {
  final List<MatchEntity> upcomingMatches;

  const PlayerUpcomingMatchLoaded({required this.upcomingMatches});

  @override
  List<Object> get props => [upcomingMatches];
}

final class PlayerUpcomingMatchFailure extends PlayerUpcomingMatchState {
  final String error;

  const PlayerUpcomingMatchFailure({required this.error});

  @override
  List<Object> get props => [error];
}
