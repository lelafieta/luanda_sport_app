part of 'squad_cubit.dart';

sealed class SquadState extends Equatable {
  const SquadState();

  @override
  List<Object> get props => [];
}

final class SquadInitial extends SquadState {}

final class SquadLoading extends SquadState {}

final class SquadLoaded extends SquadState {
  final SquadEntity? squad;

  const SquadLoaded({this.squad});

  // @override
  // List<Object> get props => [squad!];
}

final class SquadFailure extends SquadState {
  final String error;

  const SquadFailure({required this.error});

  @override
  List<Object> get props => [error];
}
