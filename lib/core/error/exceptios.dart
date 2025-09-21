import 'package:dio/dio.dart';

class ApiException {
  static void handle(DioError e) {
    if (e.response != null) {
      final status = e.response?.statusCode ?? 0;
      final data = e.response?.data;
      switch (status) {
        case 400:
          throw BadRequestException(data['errorMessage'] ?? 'Bad Request');
        case 401:
          throw UnauthorisedException(data.toString());
        case 403:
          throw ForbiddenException(data.toString());
        case 404:
          throw NotFoundException(data['errorMessage'] ?? 'Not Found');
        case 409:
          throw RequestConflictException(data['errorMessage'] ?? 'Conflict');
        case 422:
          throw InvalidInputException('Invalid Input');
        case 204:
          throw NoContentException();
        default:
          throw UnknownException(
            'Server Error: $status, Message: ${data.toString()}',
          );
      }
    } else if (e.type == DioErrorType.connectionTimeout ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.unknown) {
      throw NetworkException('Network Error: ${e.message}');
    } else {
      throw UnknownException('Unexpected Dio Error: ${e.message}');
    }
  }
}

// Custom exception classes
class BadRequestException implements Exception {
  final String message;
  BadRequestException(this.message);
}

class UnauthorisedException implements Exception {
  final String message;
  UnauthorisedException(this.message);
}

class ForbiddenException implements Exception {
  final String message;
  ForbiddenException(this.message);
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);
}

class RequestConflictException implements Exception {
  final String message;
  RequestConflictException(this.message);
}

class InvalidInputException implements Exception {
  final String message;
  InvalidInputException(this.message);
}

class NoContentException implements Exception {}

class UnknownException implements Exception {
  final String message;
  UnknownException(this.message);
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}
