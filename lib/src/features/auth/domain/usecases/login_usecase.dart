import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../entities/login_entity.dart';
import '../entities/user_entity.dart';
import '../repositories/i_auth_repository.dart';

class LoginUseCase extends BaseUseCases<UserEntity, LoginEntity> {
  final IAuthRepository authRepository;

  LoginUseCase({required this.authRepository});
  @override
  Future<Either<Failure, UserEntity>> call(LoginEntity params) async {
    return await authRepository.login(params.email, params.password);
  }
}
