part of 'get_my_player_data_cubit.dart';

sealed class GetMyPlayerDataState extends Equatable {
  const GetMyPlayerDataState();

  @override
  List<Object> get props => [];
}

final class GetMyPlayerDataInitial extends GetMyPlayerDataState {}

final class GetMyPlayerDataLoading extends GetMyPlayerDataState {}

final class GetMyPlayerDataFailure extends GetMyPlayerDataState {
  final String error;

  const GetMyPlayerDataFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class GetMyPlayerDataLoaded extends GetMyPlayerDataState {
  final PlayerEntity? player;

  const GetMyPlayerDataLoaded({required this.player});

  @override
  List<Object> get props => [];
}
