// import 'package:dio/dio.dart';
// import 'package:luanda_sport_app/src/core/error/failure.dart';

// class ServerFailure extends Failure {
//   const ServerFailure({required super.message});

//   factory ServerFailure.fromDioException(DioException dioException) {
//     switch (dioException.type) {
//       case DioExceptionType.connectionTimeout:
//         return const ServerFailure(message: 'Connection timeout');
//       case DioExceptionType.sendTimeout:
//         return const ServerFailure(message: 'Send timeout');
//       case DioExceptionType.receiveTimeout:
//         return const ServerFailure(message: 'Receive timeout');
//       case DioExceptionType.badResponse:
//         return ServerFailure(message: dioException.response!.statusMessage!);
//       case DioExceptionType.cancel:
//         return const ServerFailure(message: 'Request cancelled');
//       default:
//         return const ServerFailure(message: 'Unknown error');
//     }
//   }

//   factory ServerFailure.fromResponse(int statusCode, dynamic response) {
//     switch (statusCode) {
//       case 400:
//         return const ServerFailure(message: 'Bad request');
//       case 401:
//         return const ServerFailure(message: 'Unauthorized');
//       case 403:
//         return const ServerFailure(message: 'Forbidden');
//       case 404:
//         return const ServerFailure(message: 'Not found');
//       case 500:
//         return const ServerFailure(message: 'Internal server error');
//       default:
//         return const ServerFailure(message: 'Unknown error');
//     }
//   }
// }

// core/error/exception_mapper.dart
import 'failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ServerFailure extends Failure {
  const ServerFailure({required super.message});

  Failure mapSupabaseExceptionToFailure(dynamic exception) {
    if (exception is AuthException) {
      return Failure(
        message: 'Erro de autenticação.',
        code: exception.statusCode?.toString(),
        detail: exception.message,
      );
    }

    if (exception is PostgrestException) {
      return Failure(
        message: 'Erro de banco de dados.',
        code: exception.code,
        detail: exception.message,
      );
    }

    if (exception is RealtimeSubscribeException) {
      return Failure(
        message: 'Erro em tempo real.',
        detail: exception.details.toString(),
      );
    }

    if (exception is String) {
      return Failure(
        message: exception,
      );
    }

    return Failure(
      message: 'Erro inesperado.',
      detail: exception.toString(),
    );
  }
}
