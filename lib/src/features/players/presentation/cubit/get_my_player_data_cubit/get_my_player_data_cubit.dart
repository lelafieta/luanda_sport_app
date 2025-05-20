import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_my_player_data_state.dart';

class GetMyPlayerDataCubit extends Cubit<GetMyPlayerDataState> {
  GetMyPlayerDataCubit() : super(GetMyPlayerDataInitial());
}
