import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/app_entity.dart';
import '../../../../core/cache/i_secure_storage_helper.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/usecases/is_logged_in_usecase.dart';
import '../../domain/usecases/login_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final IsLoggedInUseCase isLoggedInUseCase;
  final ISecureStorageHelper secureStorageHelper;

  AuthCubit(
      {required this.loginUseCase,
      required this.isLoggedInUseCase,
      required this.secureStorageHelper})
      : super(AuthInitial());

  Future<void> login(LoginEntity params) async {
    emit(AuthLoading());
    final result = await loginUseCase.call(params);

    result.fold((l) => emit(AuthError(message: l.message)), (user) async {
      await secureStorageHelper.saveDate("uId", user.id).then((_) {
        AppEntity.uId = user.id;
        emit(AuthAuthenticated());
      });
    });
  }
}
