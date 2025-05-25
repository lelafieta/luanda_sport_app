part of 'fetch_players_team_cubit.dart';

sealed class FetchPlayersTeamState extends Equatable {
  const FetchPlayersTeamState();

  @override
  List<Object> get props => [];
}

final class FetchPlayersTeamInitial extends FetchPlayersTeamState {}

final class FetchPlayersTeamLoading extends FetchPlayersTeamState {}

final class FetchPlayersTeamFailure extends FetchPlayersTeamState {
  final String error;

  const FetchPlayersTeamFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class FetchPlayersTeamLoaded extends FetchPlayersTeamState {
  final List<PlayerEntity> players;

  const FetchPlayersTeamLoaded({required this.players});

  @override
  List<Object> get props => [players];
}
