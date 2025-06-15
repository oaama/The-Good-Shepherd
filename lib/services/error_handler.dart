import 'package:dio/dio.dart';

/// ErrorHandler provides user-friendly error messages for Dio errors.
class ErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is DioException) {
      if (error.response != null && error.response?.data['message'] != null) {
        return error.response?.data['message'] ?? 'Unknown error';
      } else if (error.type == DioExceptionType.connectionTimeout) {
        return 'Connection timeout. Please try again.';
      } else if (error.type == DioExceptionType.receiveTimeout) {
        return 'Server timeout. Please try again.';
      } else if (error.type == DioExceptionType.badResponse) {
        return 'Server error. Please try again.';
      } else {
        return 'Network error. Please check your connection.';
      }
    }
    return 'An unexpected error occurred.';
  }
}
