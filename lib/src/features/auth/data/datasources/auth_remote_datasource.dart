import 'package:dartz/dartz.dart';
import 'package:luanda_sport_app/src/core/error/server_failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_model.dart';
import 'i_auth_remote_datasource.dart';

class AuthRemoteDataSource extends IAuthRemoteDataSource {
  final SupabaseClient client;

  AuthRemoteDataSource({required this.client});

  @override
  Future<bool> isLoggedIn() async {
    final session = client.auth.currentSession;
    return session != null;
  }

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final result = await client.auth
          .signInWithPassword(email: email, password: password);
      if (result.user != null) {
        final user = UserModel(
          id: result.user!.id,
          email: result.user!.email!,
          name: result.user!.userMetadata!["name"],
        );
        return user;
      }
      throw const ServerFailure(message: "E-mail ou password errada");
    } catch (e) {
      rethrow;
    }
  }
}
