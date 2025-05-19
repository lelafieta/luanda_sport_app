import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../datasources/i_auth_remote_datasource.dart';

class AuthRepository extends IAuthRepository {
  final IAuthRemoteDataSource authRemoteDataSource;

  AuthRepository({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final result = await authRemoteDataSource.isLoggedIn();

      return Right(result);
    } catch (e) {
      return Left(Failure(message: "$e"));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login(
      String email, String password) async {
    try {
      final response = await authRemoteDataSource.login(email, password);
      return Right(response);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(Failure(
        message: e.toString(),
      ));
    }
  }
}
