import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String BASE_URL = "https://dharmamedicare.com/api/";
const Map<String, dynamic> DEFAULT_HEADERS = {
  'Content-Type': 'application/json',
};

class Api {
  final Dio _dio = Dio();

  Api() {
    _dio.options.baseUrl = BASE_URL;
    _dio.options.headers = DEFAULT_HEADERS;

    _dio.options.connectTimeout = const Duration(seconds: 30); // 5 seconds
    _dio.options.receiveTimeout = const Duration(seconds: 30); // 5 seconds

    _dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint('Request: ${options.method} ${options.uri}');
        debugPrint('Headers: ${options.headers}');
        debugPrint('Body: ${options.data}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint(
            'Response: ${response.statusCode} ${response.statusMessage}');
        debugPrint('Data: ${response.data}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        debugPrint('Dio error: $e');
        return handler.next(e);
      },
    ));
  }

  Dio get sendRequest => _dio;
}

class ApiResponse {
  final int status;
  final String message;

  ApiResponse({
    required this.status,
    required this.message,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'],
      message: json['message'],
    );
  }
}
