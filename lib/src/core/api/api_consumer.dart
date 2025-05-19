import 'package:dio/dio.dart';

abstract class ApiConsumer {
  Future<Response> post({
    String? baseUrl,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    String? apiFaceToken,
    bool isMultipart = false,
  });

  Future<Response> delete({
    String? baseUrl,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    String? apiFaceToken,
    bool isMultipart = false,
  });

  Future<Response> get({
    String? baseUrl,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    String? apiFaceToken,
    bool isMultipart = false,
  });

  Future<Response> put({
    String? baseUrl,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    bool isMultipart = false,
  });
}
