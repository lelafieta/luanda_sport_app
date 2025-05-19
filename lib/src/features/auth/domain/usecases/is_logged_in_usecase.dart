import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/base_usecases.dart';
import '../repositories/i_auth_repository.dart';

class IsLoggedInUseCase extends BaseUseCases<bool, NoParams> {
  final IAuthRepository authRepository;

  IsLoggedInUseCase({required this.authRepository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) =>
      authRepository.isLoggedIn();
}
