import 'package:dartz/dartz.dart';

import '../models/user_model.dart';

abstract class IAuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<bool> isLoggedIn();
}
