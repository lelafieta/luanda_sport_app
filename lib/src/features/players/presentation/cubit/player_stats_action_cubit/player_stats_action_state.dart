part of 'player_stats_action_cubit.dart';

sealed class PlayerStatsActionState extends Equatable {
  const PlayerStatsActionState();

  @override
  List<Object> get props => [];
}

final class PlayerStatsActionInitial extends PlayerStatsActionState {}
