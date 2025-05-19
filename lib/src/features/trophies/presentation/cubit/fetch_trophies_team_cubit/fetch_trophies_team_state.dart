part of 'fetch_trophies_team_cubit.dart';

sealed class FetchTrophiesTeamState extends Equatable {
  const FetchTrophiesTeamState();

  @override
  List<Object> get props => [];
}

final class FetchTrophiesTeamInitial extends FetchTrophiesTeamState {}

final class FetchTrophiesTeamLoading extends FetchTrophiesTeamState {}

final class FetchTrophiesTeamLoaded extends FetchTrophiesTeamState {
  final List<TrophyEntity> trophies;

  const FetchTrophiesTeamLoaded({required this.trophies});

  @override
  List<Object> get props => [trophies];
}

final class FetchTrophiesTeamFailure extends FetchTrophiesTeamState {
  final String error;

  const FetchTrophiesTeamFailure({required this.error});

  @override
  List<Object> get props => [error];
}
