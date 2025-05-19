part of 'starting_lineup_player_cubit.dart';

sealed class StartingLineupPlayerState extends Equatable {
  const StartingLineupPlayerState();

  @override
  List<Object> get props => [];
}

final class StartingLineupPlayerInitial extends StartingLineupPlayerState {}

final class StartingLineupPlayerLoading extends StartingLineupPlayerState {}

final class StartingLineupPlayerLoaded extends StartingLineupPlayerState {
  final List<StartingLineupPlayersEntity> startingLineupPlayers;

  const StartingLineupPlayerLoaded({required this.startingLineupPlayers});
  @override
  List<Object> get props => [startingLineupPlayers];
}

final class StartingLineupPlayerFailure extends StartingLineupPlayerState {
  final String error;

  const StartingLineupPlayerFailure({required this.error});
  @override
  List<Object> get props => [error];
}
