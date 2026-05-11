import 'dart:developer';
import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;
  final int? statusCode;

  const Failure(this.errMessage, {this.statusCode});
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage, {super.statusCode});

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.cancel:
        return ServerFailure('Connection error, please try again later');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response?.statusCode,
          dioError.response?.data,
        );

      case DioExceptionType.unknown:
        if (dioError.message?.contains('SocketException') ?? false) {
          return ServerFailure('Connection error, please try again later');
        }
        return ServerFailure('Connection error, please try again later');

      default:
        return ServerFailure('Connection error, please try again laterlll');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    log('Response ==== $response');
    log('StatusCode ==== $statusCode');

    if (response == null) {
      return ServerFailure(
        'Connection error, please try again later',
        statusCode: statusCode,
      );
    }

    try {
      // ✅ Validation error (422)
      if (statusCode == 422) {
        final validationErrors = response['data'];
        if (validationErrors is Map<String, dynamic>) {
          for (var value in validationErrors.values) {
            if (value is List && value.isNotEmpty) {
              return ServerFailure(value[0], statusCode: statusCode);
            }
          }
        }
      }

      // ✅ Maintenance (503)
      if (statusCode == 503) {
        return ServerFailure(
          response['message'] ?? 'Service unavailable',
          statusCode: statusCode,
        );
      }

      // Fallback
      final errors = response['errors'] ?? response['data'];
      if (errors is Map<String, dynamic>) {
        for (var value in errors.values) {
          if (value is List && value.isNotEmpty) {
            return ServerFailure(value[0], statusCode: statusCode);
          }
        }
      }

      if (response['message'] is String) {
        return ServerFailure(response['message'], statusCode: statusCode);
      }

      return ServerFailure(
        'Connection error, please try again later',
        statusCode: statusCode,
      );
    } catch (_) {
      return ServerFailure(
        'Connection error, please try again later',
        statusCode: statusCode,
      );
    }
  }
}
