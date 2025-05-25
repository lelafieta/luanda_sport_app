import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../matches/domain/entities/match_entity.dart';

part 'player_match_state.dart';

class PlayerMatchCubit extends Cubit<PlayerMatchState> {
  PlayerMatchCubit() : super(PlayerMatchInitial());
}
