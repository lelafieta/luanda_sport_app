part of 'fetch_player_stats_cubit.dart';

sealed class FetchPlayerStatsState extends Equatable {
  const FetchPlayerStatsState();

  @override
  List<Object> get props => [];
}

final class FetchPlayerStatsInitial extends FetchPlayerStatsState {}

final class FetchPlayerStatsLoading extends FetchPlayerStatsState {}

final class FetchPlayerStatsLoaded extends FetchPlayerStatsState {
  final PlayerStatsEntity? playerStats;

  const FetchPlayerStatsLoaded({required this.playerStats});

  @override
  List<Object> get props => [];
}

final class FetchPlayerStatsFailure extends FetchPlayerStatsState {
  final String error;

  const FetchPlayerStatsFailure({required this.error});

  @override
  List<Object> get props => [error];
}
