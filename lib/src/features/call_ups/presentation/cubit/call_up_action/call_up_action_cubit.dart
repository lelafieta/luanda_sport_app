import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luanda_sport_app/src/features/call_ups/domain/params/update_call_up_status_params.dart';

import '../../../domain/entities/call_up_entity.dart';
import '../../../domain/usecases/cancel_call_up_usecase.dart';
import '../../../domain/usecases/create_call_up_usecase.dart';
import '../../../domain/usecases/delete_call_up_usecase.dart';
import '../../../domain/usecases/update_call_up_status_usecase.dart';

part 'call_up_action_state.dart';

class CallUpActionCubit extends Cubit<CallUpActionState> {
  final CancelCallUpUseCase cancelCallUpUseCase;
  final CreateCallUpUseCase createCallUpUseCase;
  final DeleteCallUpUseCase deleteCallUpUseCase;
  final UpdateCallUpStatusUseCase updateCallUpStatusUseCase;
  CallUpActionCubit({
    required this.cancelCallUpUseCase,
    required this.createCallUpUseCase,
    required this.deleteCallUpUseCase,
    required this.updateCallUpStatusUseCase,
  }) : super(CallUpActionInitial());

  Future<void> cancelCallUp(String callUpId) async {
    emit(CallUpActionLoading());

    final result = await cancelCallUpUseCase(callUpId);

    result.fold(
      (failure) => emit(CallUpActionFailure(error: failure.message)),
      (success) => emit(CallUpActionSuccess()),
    );
  }

  Future<void> createCallUp(CallUpEntity callUp) async {
    emit(CallUpActionLoading());

    final result = await createCallUpUseCase(callUp);

    result.fold(
      (failure) => emit(CallUpActionFailure(error: failure.message)),
      (success) => emit(CallUpActionSuccess()),
    );
  }

  Future<void> deleteCallUp(String callUpId) async {
    emit(CallUpActionLoading());

    final result = await deleteCallUpUseCase(callUpId);

    result.fold(
      (failure) => emit(CallUpActionFailure(error: failure.message)),
      (success) => emit(CallUpActionSuccess()),
    );
  }

  Future<void> updateCallUpStatus(UpdateCallUpStatusParams callUpParams) async {
    emit(CallUpActionLoading());

    final result = await updateCallUpStatusUseCase(callUpParams);

    result.fold(
      (failure) => emit(CallUpActionFailure(error: failure.message)),
      (success) => emit(CallUpActionSuccess()),
    );
  }
}
