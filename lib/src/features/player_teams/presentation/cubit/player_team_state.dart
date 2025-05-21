part of 'player_team_cubit.dart';

sealed class PlayerTeamState extends Equatable {
  const PlayerTeamState();

  @override
  List<Object> get props => [];
}

final class PlayerTeamInitial extends PlayerTeamState {}

final class PlayerTeamLoading extends PlayerTeamState {}

final class PlayerTeamLoaded extends PlayerTeamState {
  final List<PlayerTeamEntity> playerTeams;

  const PlayerTeamLoaded({required this.playerTeams});

  @override
  List<Object> get props => [playerTeams];
}

final class PlayerTeamFailure extends PlayerTeamState {
  final String error;

  const PlayerTeamFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class PlayerTeamSuccess extends PlayerTeamState {}
