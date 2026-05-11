// ignore_for_file: strict_top_level_inference

import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/';

  final Dio _dio;
  final SharedPreferences sharedPreferences;

  ApiService(this._dio, this.sharedPreferences) {
    _dio.options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 120), // Timeout for connecting
      receiveTimeout: const Duration(seconds: 120), // Timeout for receiving
      sendTimeout: const Duration(seconds: 120), // Timeout for sending
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = sharedPreferences.getString('access_token');
          final lang = 'ar';

          // 🔹 Always required headers
          options.headers['Accept'] = 'application/json';
          options.headers['Accept-Language'] = lang;

          // 🔹 Add Authorization if token exists
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          // 🔹 Decide Content-Type dynamically
          if (options.data is FormData) {
            // Multipart request
            options.headers['Content-Type'] = 'multipart/form-data';
          } else {
            // Normal JSON request
            options.headers['Content-Type'] = 'application/json';
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          // log response or modify before returning
          log(
            '✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
          );

          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          // log response
          log(
            '✅ RESPONSE[${e.response?.statusCode}] => PATH: ${e.response?.requestOptions.path}',
          );

          return handler.next(e);
        },
      ),
    );
  }

  Future<dynamic> get({required String endPoint}) async {
    final response = await _dio.get('$_baseUrl$endPoint');

    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    Object? data,
  }) async {
    log('POSTING TO: ${_dio.options.baseUrl}$endPoint');
    log('BODY: $data');
    final response = await _dio.post('$_baseUrl$endPoint', data: data);

    log('response.data ==== ${response.data}');
    log('response.data ==== ${response.statusCode}');

    return response.data;
  }

  Future<Map<String, dynamic>> put({
    required String endPoint,
    Object? data,
  }) async {
    final response = await _dio.put('$_baseUrl$endPoint', data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> patch({
    required String endPoint,
    Object? data,
  }) async {
    final response = await _dio.patch('$_baseUrl$endPoint', data: data);

    log('response.data ==== ${response.data}');
    log('response.data ==== ${response.statusCode}');
    return response.data;
  }

  Future<Map<String, dynamic>> delete({required String endPoint}) async {
    final response = await _dio.delete('$_baseUrl$endPoint');
    return response.data;
  }

  Future<Map<String, dynamic>> uploadImage({
    required files,

    required String type,

    required String endPoint,
  }) async {
    MultipartFile? multipartFiles;

    final String fileName = files.path.split('/').last;
    multipartFiles = await MultipartFile.fromFile(
      files.path,
      filename: fileName,
    );

    final FormData formData = FormData.fromMap({
      'image': multipartFiles,
      'type': type,
    });

    final response = await _dio.post('$_baseUrl$endPoint', data: formData);
    return response.data;
  }
}
