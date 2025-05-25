part of 'player_match_action_cubit.dart';

sealed class PlayerMatchActionState extends Equatable {
  const PlayerMatchActionState();

  @override
  List<Object> get props => [];
}

final class PlayerMatchActionInitial extends PlayerMatchActionState {}
