import 'package:dio/dio.dart';

import 'api_consumer.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio = Dio(
    BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60),
    ),
  );

  @override
  Future<Response> get(
      {String? baseUrl,
      required String endPoint,
      data,
      query,
      String? token,
      String? apiFaceToken,
      bool isMultipart = false}) async {
    dio.options.headers = {
      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
      if (apiFaceToken != null) 'token': apiFaceToken,
      if (token != null) 'Authorization': 'Bearer $token',
      'lang': 'en',
    };
    return await dio.get(
      endPoint,
      queryParameters: query,
    );
  }

  @override
  Future<Response> post(
      {String? baseUrl,
      required String endPoint,
      data,
      query,
      String? token,
      ProgressCallback? progressCallback,
      CancelToken? cancelToken,
      int? timeOut,
      String? apiFaceToken,
      bool isMultipart = false}) async {
    dio.options.headers = {
      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
      if (apiFaceToken != null) 'token': apiFaceToken,
      if (token != null) 'Authorization': 'Bearer $token',
      'lang': 'pt',
    };

    return await dio.post(
      endPoint,
      data: data,
      queryParameters: query,
      onSendProgress: progressCallback,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Response> delete(
      {String? baseUrl,
      required String endPoint,
      data,
      query,
      String? token,
      ProgressCallback? progressCallback,
      CancelToken? cancelToken,
      int? timeOut,
      String? apiFaceToken,
      bool isMultipart = false}) async {
    dio.options.headers = {
      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
      if (apiFaceToken != null) 'token': apiFaceToken,
      if (token != null) 'Authorization': 'Bearer $token',
      'lang': 'pt',
    };

    return await dio.delete(
      endPoint,
      data: data,
      queryParameters: query,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Response> put(
      {String? baseUrl,
      required String endPoint,
      data,
      query,
      String? token,
      bool isMultipart = false}) async {
    dio.options.headers = {
      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
      'lang': 'en',
    };
    return await dio.put(
      endPoint,
      data: data,
      queryParameters: query,
    );
  }
}
